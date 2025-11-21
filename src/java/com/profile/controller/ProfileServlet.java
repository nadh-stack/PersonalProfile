package com.profile.controller;

import com.profile.model.ProfileItem;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile.controller"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String intro = request.getParameter("intro");

        ProfileItem profile = new ProfileItem(name, studentId, program, email, hobbies, intro);

        request.setAttribute("profile", profile);
        request.getRequestDispatcher("view_profile.jsp").forward(request, response);
    }
}
