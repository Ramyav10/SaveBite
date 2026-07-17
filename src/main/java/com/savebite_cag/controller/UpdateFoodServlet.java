package com.savebite_cag.controller;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.FoodDAOImpl;
import com.savebite_cag.model.FoodItem;
import com.savebite_cag.model.User;

@WebServlet("/UpdateFoodServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 2,
    maxRequestSize = 1024 * 1024 * 5
)
public class UpdateFoodServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"RESTAURANT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        // Handle file upload
        String imageUrl = request.getParameter("existingImage"); // keep existing by default
        Part filePart = request.getPart("imageFile");

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
            String uploadPath = getServletContext().getRealPath("/images");
            System.out.println("File size = " + filePart.getSize());
            System.out.println("File name = " + getFileName(filePart));
            System.out.println("Upload path = " + uploadPath);
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            filePart.write(uploadPath + File.separator + fileName);
            imageUrl = "images/" + fileName;
        }

        FoodItem food = new FoodItem();
        food.setFoodId(Integer.parseInt(request.getParameter("foodId")));
        food.setFoodName(request.getParameter("foodName"));
        food.setCategory(request.getParameter("category"));
        food.setDescription(request.getParameter("description"));
        food.setPrice(Double.parseDouble(request.getParameter("price")));
        food.setDeliveryTime(Integer.parseInt(request.getParameter("deliveryTime")));
        food.setRating(Double.parseDouble(request.getParameter("rating")));
        food.setAvailableQuantity(Integer.parseInt(request.getParameter("availableQuantity")));
        food.setImageUrl(imageUrl);
        food.setFoodStatus(request.getParameter("foodStatus"));

        FoodDAOImpl dao = new FoodDAOImpl();
        boolean status = dao.updateFoodItem(food);

        if (status) {
            response.sendRedirect(request.getContextPath() +
                "/RestaurantDashboardServlet?tab=menu");
        } else {
            request.setAttribute("error", "Failed to update.");
            request.setAttribute("food", food);
            request.getRequestDispatcher("/jsp/editFoodItem.jsp").forward(request, response);
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "upload.jpg";
    }
}
