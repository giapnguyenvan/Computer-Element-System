package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Products;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

@WebServlet(name = "ProductImportServlet", urlPatterns = {"/ProductImportServlet"})
@MultipartConfig
public class ProductImportServlet extends HttpServlet {

    static class RowError {

        int rowIndex;
        String reason;

        public RowError(int rowIndex, String reason) {
            this.rowIndex = rowIndex;
            this.reason = reason;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Products> validProducts = new ArrayList<>();
        List<RowError> errors = new ArrayList<>();
        ProductDAO dao = new ProductDAO();

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Part filePart = request.getPart("excelFile");
            if (filePart == null) {
                out.println("<p class='text-danger'>Không tìm thấy file Excel.</p>");
                return;
            }
            
            InputStream fileContent = filePart.getInputStream();
            Workbook workbook = new XSSFWorkbook(fileContent);
            Sheet sheet = workbook.getSheetAt(0);
            
            if (sheet.getLastRowNum() < 1) {
                out.println("<p class='text-danger'>File Excel không có dữ liệu hoặc chỉ có header.</p>");
                return;
            }

            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) {
                    continue;
                }

                try {
                    String name = getString(row, 0);
                    String brandName = getString(row, 1);
                    String typeName = getString(row, 2);
                    String model = getString(row, 3);
                    double price = getDouble(row, 4);
                    double importPrice = getDouble(row, 5);
                    int stock = (int) getDouble(row, 6);
                    String sku = getString(row, 7);
                    String desc = getString(row, 8);

                    // Validate required fields
                    if (name.isEmpty() || brandName.isEmpty() || typeName.isEmpty()) {
                        errors.add(new RowError(i + 1, "Thiếu thông tin bắt buộc (Name, Brand, Component Type)"));
                        continue;
                    }
                    
                    if (price <= 0) {
                        errors.add(new RowError(i + 1, "Giá phải lớn hơn 0"));
                        continue;
                    }
                    
                    if (stock < 0) {
                        errors.add(new RowError(i + 1, "Số lượng tồn kho không được âm"));
                        continue;
                    }

                    int brandId = dao.getBrandIdByName(brandName);
                    int typeId = dao.getComponentTypeIdByName(typeName);

                    // Auto-create brand if it doesn't exist
                    if (brandId == 0) {
                        dao.insertBrand(brandName);
                        brandId = dao.getBrandIdByName(brandName);
                    }
                    
                    // Auto-create component type if it doesn't exist
                    if (typeId == 0) {
                        dao.insertComponentType(typeName);
                        typeId = dao.getComponentTypeIdByName(typeName);
                    }

                    if (brandId == 0 || typeId == 0) {
                        errors.add(new RowError(i + 1, "Không thể tạo brand hoặc type"));
                        continue;
                    }

                    Products p = new Products();
                    p.setName(name);
                    p.setBrandId(brandId);
                    p.setComponentTypeId(typeId);
                    p.setModel(model);
                    p.setPrice(price);
                    p.setImportPrice(importPrice);
                    p.setStock(stock);
                    p.setSku(sku);
                    p.setDescription(desc);
                    p.setStatus("Active");
                    p.setCreatedAt(new Timestamp(new Date().getTime()));
                    p.setBrandName(brandName);
                    p.setComponentTypeName(typeName);

                    validProducts.add(p);

                } catch (Exception e) {
                    errors.add(new RowError(i + 1, "Lỗi định dạng dữ liệu"));
                }
            }

            // ===== IMPORT LOGIC HERE =====
            if (!validProducts.isEmpty()) {
                for (Products imported : validProducts) {
                    Products existing = dao.importFilter(
                            imported.getName(),
                            imported.getBrandId(),
                            imported.getComponentTypeId()
                    );

                    if (existing != null) {
                        boolean samePrice = imported.getPrice() == existing.getPrice();
                        boolean sameImport = (imported.getImportPrice() == null && existing.getImportPrice() == null)
                                || (imported.getImportPrice() != null && imported.getImportPrice().equals(existing.getImportPrice()));

                        if (samePrice && sameImport) {
                            // Same product → update stock
                            existing.setStock(existing.getStock() + imported.getStock());
                            dao.updateStock(existing);
                        } else {
                            // Different price or import price → update them
                            existing.setPrice(imported.getPrice());
                            existing.setImportPrice(imported.getImportPrice());
                            existing.setStock(existing.getStock() + imported.getStock());
                            dao.updatePriceStock(existing);
                        }
                    } else {
                        // New product → insert
                        dao.insertProduct(imported);
                    }
                }
            }

            // ===== PREVIEW HTML OUTPUT =====
            out.println("<html><head><title>Kết quả import</title>");
            out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");
            out.println("</head><body class='p-4'>");

            out.println("<h3>Kết quả nhập từ Excel</h3>");
            out.println("<p><strong>Tổng số dòng xử lý:</strong> " + (sheet.getLastRowNum()) + "</p>");

            if (!validProducts.isEmpty()) {
                out.println("<h5 class='text-success'>Sản phẩm hợp lệ (" + validProducts.size() + " sản phẩm)</h5>");
                out.println("<table class='table table-bordered table-striped'><thead><tr><th>Name</th><th>Brand</th><th>Component Type</th><th>Model</th><th>Price</th><th>Stock</th><th>SKU</th></tr></thead><tbody>");
                for (Products p : validProducts) {
                    out.printf("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%.2f</td><td>%d</td><td>%s</td></tr>",
                            p.getName(), 
                            p.getBrandName(),
                            p.getComponentTypeName(),
                            p.getModel() != null ? p.getModel() : "",
                            p.getPrice(), 
                            p.getStock(), 
                            p.getSku() != null ? p.getSku() : "");
                }
                out.println("</tbody></table>");
            }

            if (!errors.isEmpty()) {
                out.println("<h5 class='text-danger'>Dòng lỗi (" + errors.size() + " lỗi)</h5><ul class='list-group'>");
                for (RowError e : errors) {
                    out.printf("<li class='list-group-item list-group-item-danger'>Hàng %d: %s</li>", e.rowIndex, e.reason);
                }
                out.println("</ul>");
            }

            if (validProducts.isEmpty() && errors.isEmpty()) {
                out.println("<p class='text-warning'>Không có dữ liệu hợp lệ để import.</p>");
            }

            out.println("<a href='viewProduct.jsp' class='btn btn-secondary mt-3'>Quay lại danh sách</a>");
            out.println("</body></html>");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p class='text-danger'>Đã xảy ra lỗi trong quá trình xử lý file Excel.</p>");
        }
    }

    private String getString(Row row, int cellIndex) {
        Cell cell = row.getCell(cellIndex);
        if (cell == null) {
            return "";
        }
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                return String.valueOf((int) cell.getNumericCellValue());
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            default:
                return "";
        }
    }

    private double getDouble(Row row, int cellIndex) {
        Cell cell = row.getCell(cellIndex);
        if (cell == null) {
            return 0.0;
        }
        switch (cell.getCellType()) {
            case NUMERIC:
                return cell.getNumericCellValue();
            case STRING:
                try {
                    return Double.parseDouble(cell.getStringCellValue());
                } catch (NumberFormatException e) {
                    return 0.0;
                }
            default:
                return 0.0;
        }
    }
}