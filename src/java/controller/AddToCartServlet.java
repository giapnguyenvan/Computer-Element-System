package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.PCComponent;
import model.PCComponentDAO;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {
    private PCComponentDAO pcComponentDAO;

    @Override
    public void init() throws ServletException {
        pcComponentDAO = new PCComponentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get component IDs from the form
        String cpuId = request.getParameter("cpuId");
        String gpuId = request.getParameter("gpuId");
        String ramId = request.getParameter("ramId");
        String motherboardId = request.getParameter("motherboardId");
        String storageId = request.getParameter("storageId");
        String psuId = request.getParameter("psuId");

        // Get components from database
        PCComponent cpu = pcComponentDAO.getComponentById(Integer.parseInt(cpuId));
        PCComponent gpu = pcComponentDAO.getComponentById(Integer.parseInt(gpuId));
        PCComponent ram = pcComponentDAO.getComponentById(Integer.parseInt(ramId));
        PCComponent motherboard = pcComponentDAO.getComponentById(Integer.parseInt(motherboardId));
        PCComponent storage = pcComponentDAO.getComponentById(Integer.parseInt(storageId));
        PCComponent psu = pcComponentDAO.getComponentById(Integer.parseInt(psuId));

        // Create a list of components
        List<PCComponent> pcBuild = new ArrayList<>();
        pcBuild.add(cpu);
        pcBuild.add(gpu);
        pcBuild.add(ram);
        pcBuild.add(motherboard);
        pcBuild.add(storage);
        pcBuild.add(psu);

        // Calculate total price
        double totalPrice = pcBuild.stream()
                .mapToDouble(PCComponent::getPrice)
                .sum();

        // Add to session
        session.setAttribute("pcBuild", pcBuild);
        session.setAttribute("pcBuildTotal", totalPrice);

        // Redirect to cart page
        response.sendRedirect("view-cart.html");
    }
} 