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
import java.util.Date;

@WebServlet(name = "ProductImportServlet", urlPatterns = {"/productimportservlet"})
@MultipartConfig
public class ProductImportServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("excelFile");
        InputStream fileContent = filePart.getInputStream();

        try (Workbook workbook = new XSSFWorkbook(fileContent)) {
            Sheet sheet = workbook.getSheetAt(0);
            ProductDAO dao = new ProductDAO();

            for (int i = 1; i <= sheet.getLastRowNum(); i++) { // Skip header
                Row row = sheet.getRow(i);
                if (row == null) continue;

                String name = getStringCell(row, 0);
                String brandName = getStringCell(row, 1);
                String componentType = getStringCell(row, 2);
                String model = getStringCell(row, 3);
                double price = getNumericCell(row, 4);
                double importPrice = getNumericCell(row, 5);
                int stock = (int) getNumericCell(row, 6);
                String sku = getStringCell(row, 7);
                String description = getStringCell(row, 8);

                // Handle brand
                int brandId = dao.getBrandIdByName(brandName);
                if (brandId == 0 && !brandName.isBlank()) {
                    dao.insertBrand(brandName);
                    brandId = dao.getBrandIdByName(brandName);
                }

                // Handle component type
                int typeId = dao.getComponentTypeIdByName(componentType);
                if (typeId == 0 && !componentType.isBlank()) {
                    dao.insertComponentType(componentType);
                    typeId = dao.getComponentTypeIdByName(componentType);
                }

                // Create product object
                Products p = new Products();
                p.setName(name);
                p.setBrandId(brandId);
                p.setComponentTypeId(typeId);
                p.setModel(model);
                p.setPrice(price);
                p.setImportPrice(importPrice);
                p.setStock(stock);
                p.setSku(sku);
                p.setDescription(description);
                p.setStatus("Active");
                p.setCreatedAt(new Timestamp(new Date().getTime()));

                // Insert into database
                dao.insertProduct(p);
            }

            response.sendRedirect("productList.jsp?importSuccess=true");

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("productList.jsp?importError=true");
        }
    }

    private String getStringCell(Row row, int col) {
        Cell cell = row.getCell(col);
        return cell != null ? cell.toString().trim() : "";
    }

    private double getNumericCell(Row row, int col) {
        Cell cell = row.getCell(col);
        if (cell == null) return 0;
        if (cell.getCellType() == CellType.NUMERIC) return cell.getNumericCellValue();
        try {
            return Double.parseDouble(cell.toString().trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
