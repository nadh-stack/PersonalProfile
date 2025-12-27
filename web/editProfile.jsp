<%@ page import="java.sql.*, com.profile.model.ProfileBean" %>
<%
    String studentId = request.getParameter("studentId");
    ProfileBean profile = new ProfileBean();

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/StudentProfile", "app", "app");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM PROFILE WHERE STUDENTID=?");
        ps.setString(1, studentId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            profile.setStudentId(rs.getString("STUDENTID"));
            profile.setName(rs.getString("NAME"));
            profile.setProgram(rs.getString("PROGRAM"));
            profile.setEmail(rs.getString("EMAIL"));
            profile.setHobbies(rs.getString("HOBBIES"));
            profile.setIntroduction(rs.getString("INTRODUCTION"));
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
        <title>Edit Profile</title>
        <script>
            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                const status = urlParams.get('status');
                if (status === 'update') {
                    alert('Profile successfully updated!');
                    window.history.replaceState({}, document.title, window.location.pathname);
                }
            }
        </script>

        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #FCE1FA;
                color: #4a235a;
                margin: 0;
                padding: 0;
            }
            .form-container {
                width: 500px;
                margin: 50px auto;
                background: white;
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.2);
                padding: 30px;
            }
            h2 {
                text-align: center;
                margin-bottom: 30px;
            }
            input, textarea {
                width: 100%;
                padding: 10px;
                margin: 8px 0 15px 0;
                border: 1px solid #ccc;
                border-radius: 8px;
                box-sizing: border-box;
            }
            button, input[type="submit"] {
                width: 100%;
                background-color: #8e44ad;
                color: white;
                padding: 15px;
                font-size: 18px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                transition: 0.3s;
            }
            button:hover, input[type="submit"]:hover {
                background-color: #732d91;
            }
            label {
                font-weight: bold;
            }
        </style>

    </head>
    <body>
        <div class="form-container">
            <h2>Edit Profile</h2>
            <form action="editProfile.controller" method="post">
                <input type="hidden" name="studentId" value="<%=profile.getStudentId()%>">
                <label>Name:</label>
                <input type="text" name="name" value="<%=profile.getName()%>" required>
                <label>Program:</label>
                <input type="text" name="program" value="<%=profile.getProgram()%>" required>
                <label>Email:</label>
                <input type="email" name="email" value="<%=profile.getEmail()%>" required>
                <label>Hobbies:</label>
                <input type="text" name="hobbies" value="<%=profile.getHobbies()%>">
                <label>Introduction:</label>
                <textarea name="introduction" rows="4"><%=profile.getIntroduction()%></textarea>
                <input type="submit" value="Update Profile">
            </form>
        </div>
    </body>
</html>
