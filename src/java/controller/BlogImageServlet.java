package controller;

import dal.BlogImageDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import model.BlogImage;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@WebServlet(name="BlogImageServlet", urlPatterns={"/api/blog-images"})
public class BlogImageServlet extends HttpServlet {
   
    private final BlogImageDAO blogImageDAO;
    private final Gson gson;

    public BlogImageServlet() {
        blogImageDAO = new BlogImageDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            String blogIdParam = request.getParameter("blogId");
            
            if (blogIdParam == null || blogIdParam.trim().isEmpty()) {
                sendErrorResponse(response, "Blog ID is required", 400);
                return;
            }
            
            int blogId = Integer.parseInt(blogIdParam);
            Vector<BlogImage> images = blogImageDAO.getImagesByBlogId(blogId);
            
            // Convert to JSON
            JsonArray jsonArray = new JsonArray();
            for (BlogImage image : images) {
                JsonObject imageObj = new JsonObject();
                imageObj.addProperty("image_id", image.getImage_id());
                imageObj.addProperty("image_url", image.getImage_url());
                imageObj.addProperty("image_alt", image.getImage_alt());
                imageObj.addProperty("display_order", image.getDisplay_order());
                jsonArray.add(imageObj);
            }
            
            JsonObject result = new JsonObject();
            result.addProperty("success", true);
            result.addProperty("blogId", blogId);
            result.addProperty("count", images.size());
            result.add("images", jsonArray);
            
            response.getWriter().write(gson.toJson(result));
            
        } catch (NumberFormatException e) {
            sendErrorResponse(response, "Invalid blog ID format", 400);
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Error loading images: " + e.getMessage(), 500);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void sendErrorResponse(HttpServletResponse response, String message, int status) throws IOException {
        response.setStatus(status);
        JsonObject error = new JsonObject();
        error.addProperty("success", false);
        error.addProperty("error", message);
        response.getWriter().write(gson.toJson(error));
    }
} 