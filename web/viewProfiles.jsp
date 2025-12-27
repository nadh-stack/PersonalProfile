<%@ page import="java.sql.*, java.util.*, com.profile.model.ProfileBean" %>
<%
    String keyword = request.getParameter("keyword");

    List profiles = new ArrayList(); // no diamond operator

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/StudentProfile", "app", "app");

        String sql;
        PreparedStatement ps;
        if (keyword != null && !keyword.trim().isEmpty()) {
            // If input is ID-like (starts with S followed by numbers), search by STUDENTID
            if (keyword.matches("[S]\\d+")) {
                sql = "SELECT * FROM PROFILE WHERE UPPER(STUDENTID) = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, keyword.toUpperCase());
            } else {
                sql = "SELECT * FROM PROFILE WHERE UPPER(NAME) LIKE ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + keyword.toUpperCase() + "%");
            }
        } else {
            sql = "SELECT * FROM PROFILE";
            ps = con.prepareStatement(sql);
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ProfileBean p = new ProfileBean();
            p.setStudentId(rs.getString("STUDENTID"));
            p.setName(rs.getString("NAME"));
            p.setProgram(rs.getString("PROGRAM"));
            p.setEmail(rs.getString("EMAIL"));
            p.setHobbies(rs.getString("HOBBIES"));
            p.setIntroduction(rs.getString("INTRODUCTION"));
            profiles.add(p);
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>All Profiles</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body { font-family: Arial; background-color: #F5CBF2; color: #4a235a; }
            .container { width: 90%; margin: 40px auto; }
            h2 { text-align: center; margin-bottom: 20px; }

            .search-box { text-align: center; margin-bottom: 20px; }
            .search-box input[type="text"] { padding: 8px; width: 250px; }
            .search-box input[type="submit"] { padding: 8px 12px; background-color: #8e44ad; color: white; border: none; cursor: pointer; }
            .search-box input[type="submit"]:hover { background-color: #732d91; }

            table { width: 100%; border-collapse: collapse; }
            th, td { padding: 12px; border: 1px solid #4a235a; text-align: left; }
            th { background-color: #8e44ad; color: white; }
            tr:nth-child(even) { background-color: #f2e6f9; }
            .actions {
                display: flex;
                justify-content: center;
                gap: 12px;
            }

            .icon {
                text-decoration: none;
                font-size: 18px;
            }
            .action-buttons a { display: inline-block; margin-right: 8px; text-decoration: none; color: white; padding: 5px 10px; border-radius: 5px; }
            .action-buttons a.edit { background-color: #3498db; }
            .action-buttons a.edit:hover { background-color: #2980b9; }
            .action-buttons a.delete { background-color: #e74c3c; }
            .action-buttons a.delete:hover { background-color: #c0392b; }

            .back-button { text-align: center; margin-top: 20px; }
            .back-button a { background-color: #8e44ad; color: white; padding: 10px 20px; border-radius: 8px; text-decoration: none; }
            .back-button a:hover { background-color: #732d91; }
            .alert {
                width: 60%;
                margin: 15px auto;
                padding: 12px;
                text-align: center;
                border-radius: 8px;
                font-weight: bold;
            }

            .alert.success {
                background-color: #d5f5e3;
                color: #1e8449;
                border: 1px solid #1e8449;
            }

        </style>
        <script>
            function confirmDelete(name) {
                if (confirm("Are you sure you want to delete " + name + "?")) {
                    // will go to servlet and delete
                    return true;
                }
                return false; // cancel
            }

// Show success message after redirect
            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                const status = urlParams.get('status');
                if (status === 'delete') {
                    alert('Profile successfully deleted!');
                    window.history.replaceState({}, document.title, window.location.pathname); // remove status from URL
                } else if (status === 'update') {
                    alert('Profile successfully updated!');
                    window.history.replaceState({}, document.title, window.location.pathname);
                }
            }
        </script>

    </head>
    <body>
        <div class="container">
            <h2>All Profiles</h2>
            <div class="search-box">
                <form method="get" action="viewProfiles.jsp">
                    <input type="text" name="keyword" placeholder="Search by ID or Name" value="<%= (keyword != null) ? keyword : ""%>">
                    <input type="submit" value="Search">
                </form>
            </div>

            <table>
                <tr>
                    <th>Student ID</th><th>Name</th><th>Program</th><th>Email</th>
                    <th>Hobbies</th><th>Introduction</th><th>Actions</th>
                </tr>
                <%
                    for (int i = 0; i < profiles.size(); i++) {
                        ProfileBean p = (ProfileBean) profiles.get(i);
                %>
                <tr>
                    <td><%=p.getStudentId()%></td>
                    <td><%=p.getName()%></td>
                    <td><%=p.getProgram()%></td>
                    <td><%=p.getEmail()%></td>
                    <td><%=p.getHobbies()%></td>
                    <td><%=p.getIntroduction()%></td>
                    <td class="action-buttons">
                        <a href="editProfile.jsp?studentId=<%=p.getStudentId()%>" class="edit" title="Edit">
                            <i class="fas fa-pencil-alt"></i>
                        </a>
                        <a href="deleteProfile.controller?studentId=<%=p.getStudentId()%>" class="delete" 
                           onclick="return confirmDelete('<%=p.getName()%>');" title="Delete">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>

            <div class="back-button">
                <a href="index.html">Back to Home</a>
            </div>
        </div>
    </body>
</html>
