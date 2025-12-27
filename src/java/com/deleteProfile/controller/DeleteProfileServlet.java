package com.deleteProfile.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "DeleteProfileServlet", urlPatterns = {"/deleteProfile.controller"})
public class DeleteProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/StudentProfile", "app", "app");

            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM PROFILE WHERE STUDENTID=?");

            ps.setString(1, studentId);
            ps.executeUpdate();

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("viewProfiles.jsp?status=delete");
    }
}
