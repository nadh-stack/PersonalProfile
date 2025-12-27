package com.editProfile.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "EditProfileServlets", urlPatterns = {"/editProfile.controller"})
public class EditProfileServlets extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String introduction = request.getParameter("introduction");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/StudentProfile", "app", "app");

            PreparedStatement ps = con.prepareStatement(
                "UPDATE PROFILE SET NAME=?, PROGRAM=?, EMAIL=?, HOBBIES=?, INTRODUCTION=? WHERE STUDENTID=?");

            ps.setString(1, name);
            ps.setString(2, program);
            ps.setString(3, email);
            ps.setString(4, hobbies);
            ps.setString(5, introduction);
            ps.setString(6, studentId);

            ps.executeUpdate();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("viewProfiles.jsp?status=update");
    }
}
