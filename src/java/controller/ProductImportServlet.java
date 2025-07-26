package controller;

import dal.ProductDAO;
import dal.InventoryLogDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Products;
import model.InventoryLog;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

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

    static class ImportResult {
        boolean success;
        String message;
        int count;
        List<String> errors;

        public ImportResult(boolean success, String message, int count, List<String> errors) {
            this.success = success;
            this.message = message;
            this.count = count;
            this.errors = errors;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Products> validProducts = new ArrayList<>();
        List<RowError> errors = new ArrayList<>();
        ProductDAO dao = new ProductDAO();

        try {
            Part filePart = request.getPart("excelFile");
            if (filePart == null) {
                request.setAttribute("errorMsg", "Excel file not found.");
                request.getRequestDispatcher("/viewProduct.jsp").forward(request, response);
                return;
            }
            
            String fileName = filePart.getSubmittedFileName();
            if (fileName == null || !(fileName.toLowerCase().endsWith(".xlsx") || fileName.toLowerCase().endsWith(".xls"))) {
                request.setAttribute("errorMsg", "Invalid file type. Please upload an Excel file (.xlsx or .xls).");
                request.getRequestDispatcher("/viewProduct.jsp").forward(request, response);
                return;
            }
            
            InputStream fileContent = filePart.getInputStream();
            Workbook workbook = new XSSFWorkbook(fileContent);
            Sheet sheet = workbook.getSheetAt(0);
            
            if (sheet.getLastRowNum() < 1) {
                request.setAttribute("errorMsg", "Excel file has no data or only header row.");
                request.getRequestDispatcher("/viewProduct.jsp").forward(request, response);
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
                        errors.add(new RowError(i + 1, "Missing required information (Name, Brand, Component Type)"));
                        continue;
                    }
                    
                    if (price <= 0) {
                        errors.add(new RowError(i + 1, "Price must be greater than 0"));
                        continue;
                    }
                    
                    if (stock < 0) {
                        errors.add(new RowError(i + 1, "Stock quantity cannot be negative"));
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
                        errors.add(new RowError(i + 1, "Unable to create brand or component type"));
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
                    errors.add(new RowError(i + 1, "Data format error"));
                }
            }

            // ===== IMPORT LOGIC HERE =====
            int importedCount = 0;
            if (!validProducts.isEmpty()) {
                InventoryLogDAO logDAO = new InventoryLogDAO();
                for (Products imported : validProducts) {
                    Products existing = dao.importFilter(
                            imported.getName(),
                            imported.getBrandId(),
                            imported.getComponentTypeId(),
                            imported.getModel(),
                            imported.getSku()
                    );

                    if (existing != null) {
                        boolean samePrice = imported.getPrice() == existing.getPrice();
                        boolean sameImport = (imported.getImportPrice() == null && existing.getImportPrice() == null)
                                || (imported.getImportPrice() != null && imported.getImportPrice().equals(existing.getImportPrice()));

                        if (samePrice && sameImport) {
                            // Same product -> update stock
                            int oldStock = existing.getStock();
                            existing.setStock(existing.getStock() + imported.getStock());
                            dao.updateStock(existing);
                            // Log Adjust
                            InventoryLog log = new InventoryLog();
                            log.setProduct_id(existing.getProductId());
                            log.setAction("Adjust");
                            log.setQuantity(imported.getStock());
                            log.setNote("Stock adjusted via import. Old stock: " + oldStock + ", Added: " + imported.getStock());
                            log.setCreated_at(new java.sql.Timestamp(System.currentTimeMillis()));
                            logDAO.insertLog(log);
                        } else {
                            // Different price or import price -> update
                            int oldStock = existing.getStock();
                            existing.setPrice(imported.getPrice());
                            existing.setImportPrice(imported.getImportPrice());
                            existing.setStock(existing.getStock() + imported.getStock());
                            dao.updatePriceStock(existing);
                            // Log Adjust
                            InventoryLog log = new InventoryLog();
                            log.setProduct_id(existing.getProductId());
                            log.setAction("Adjust");
                            log.setQuantity(imported.getStock());
                            log.setNote("Stock adjusted via import (price/import price changed). Old stock: " + oldStock + ", Added: " + imported.getStock());
                            log.setCreated_at(new java.sql.Timestamp(System.currentTimeMillis()));
                            logDAO.insertLog(log);
                        }
                    } else {
                        // New product -> insert
                        dao.insertProduct(imported);
                        // Get the inserted product to get its ID
                        Products newProduct = dao.importFilter(
                            imported.getName(),
                            imported.getBrandId(),
                            imported.getComponentTypeId(),
                            imported.getModel(),
                            imported.getSku()
                        );
                        if (newProduct != null) {
                            InventoryLog log = new InventoryLog();
                            log.setProduct_id(newProduct.getProductId());
                            log.setAction("Add");
                            log.setQuantity(newProduct.getStock());
                            log.setNote("Product added via import.");
                            log.setCreated_at(new java.sql.Timestamp(System.currentTimeMillis()));
                            logDAO.insertLog(log);
                        }
                    }
                    importedCount++;
                }
            }

            // Convert errors to string list
            List<String> errorMessages = new ArrayList<>();
            for (RowError error : errors) {
                errorMessages.add("Row " + error.rowIndex + ": " + error.reason);
            }

            if (importedCount > 0) {
                // Optionally, set a success message in session
                request.getSession().setAttribute("successMsg", "Successfully imported " + importedCount + " products.");
                // Redirect to the product list servlet/JSP
                response.sendRedirect(request.getContextPath() + "/productservlet?service=viewProduct");
                return;
            } else {
                // If no products imported, forward back to the upload page with error messages
                request.setAttribute("errorMsg", "No valid products to import. " + String.join(" ", errorMessages));
                request.getRequestDispatcher("/viewProduct.jsp").forward(request, response);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "An error occurred while processing the Excel file: " + e.getMessage());
            request.getRequestDispatcher("/viewProduct.jsp").forward(request, response);
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