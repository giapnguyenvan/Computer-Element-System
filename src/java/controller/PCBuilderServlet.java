package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PCComponent;
import model.PCComponentDAO;

@WebServlet(name = "PCBuilderServlet", urlPatterns = {"/PCBuilderServlet"})
public class PCBuilderServlet extends HttpServlet {

    private PCComponentDAO pcComponentDAO;

    @Override
    public void init() throws ServletException {
        pcComponentDAO = new PCComponentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Load all component lists
        List<PCComponent> cpuList = pcComponentDAO.getComponentsByType("CPU");
        List<PCComponent> gpuList = pcComponentDAO.getComponentsByType("GPU");
        List<PCComponent> ramList = pcComponentDAO.getComponentsByType("RAM");
        List<PCComponent> motherboardList = pcComponentDAO.getComponentsByType("Motherboard");
        List<PCComponent> storageList = pcComponentDAO.getComponentsByType("Storage");
        List<PCComponent> psuList = pcComponentDAO.getComponentsByType("PSU");

        // Set attributes for JSP
        request.setAttribute("cpuList", cpuList);
        request.setAttribute("gpuList", gpuList);
        request.setAttribute("ramList", ramList);
        request.setAttribute("motherboardList", motherboardList);
        request.setAttribute("storageList", storageList);
        request.setAttribute("psuList", psuList);

        // Forward to PC Builder page
        request.getRequestDispatcher("pcBuilder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get selected components
        String cpuId = request.getParameter("cpu");
        String gpuId = request.getParameter("gpu");
        String ramId = request.getParameter("ram");
        String motherboardId = request.getParameter("motherboard");
        String storageId = request.getParameter("storage");
        String psuId = request.getParameter("psu");

        // Validate selections
        if (cpuId == null || gpuId == null || ramId == null || 
            motherboardId == null || storageId == null || psuId == null) {
            request.setAttribute("error", "Please select all components");
            doGet(request, response);
            return;
        }

        // Get component details
        PCComponent cpu = pcComponentDAO.getComponentById(Integer.parseInt(cpuId));
        PCComponent gpu = pcComponentDAO.getComponentById(Integer.parseInt(gpuId));
        PCComponent ram = pcComponentDAO.getComponentById(Integer.parseInt(ramId));
        PCComponent motherboard = pcComponentDAO.getComponentById(Integer.parseInt(motherboardId));
        PCComponent storage = pcComponentDAO.getComponentById(Integer.parseInt(storageId));
        PCComponent psu = pcComponentDAO.getComponentById(Integer.parseInt(psuId));

        // Calculate total price
        double totalPrice = cpu.getPrice() + gpu.getPrice() + ram.getPrice() + 
                          motherboard.getPrice() + storage.getPrice() + psu.getPrice();

        // Set attributes for the confirmation page
        request.setAttribute("cpu", cpu);
        request.setAttribute("gpu", gpu);
        request.setAttribute("ram", ram);
        request.setAttribute("motherboard", motherboard);
        request.setAttribute("storage", storage);
        request.setAttribute("psu", psu);
        request.setAttribute("totalPrice", totalPrice);

        // Forward to confirmation page
        request.getRequestDispatcher("pcBuilderConfirmation.jsp").forward(request, response);
    }
} 