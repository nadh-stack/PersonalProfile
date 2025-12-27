<%@page import="com.profile.model.ProfileBean"%>
<%
    ProfileBean p = (ProfileBean) request.getAttribute("profile");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Your Profile</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #FCE1FA;
                color: #4a235a;
                margin: 0;
                padding: 0;
            }
            .card {
                width: 500px;
                margin: 50px auto;
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            }
            h2 {
                text-align: center;
                margin-bottom: 25px;
            }
            p {
                font-size: 16px;
                margin-bottom: 15px;
            }
            p strong {
                color: black;
            }
            .back-button {
                display: block;
                text-align: center;
                margin-top: 30px;
            }
            .back-button a {
                background-color: #8e44ad;
                color: white;
                text-decoration: none;
                padding: 12px 25px;
                border-radius: 10px;
                transition: 0.3s;
            }
            .back-button a:hover {
                background-color: #732d91;
            }
        </style>
    </head>
    <body>
        <div class="card">
            <h2>Your Personal Profile</h2>

            <p><strong>Name:</strong> <%= p.getName()%></p>
            <p><strong>Student ID:</strong> <%= p.getStudentId()%></p>
            <p><strong>Program:</strong> <%= p.getProgram()%></p>
            <p><strong>Email:</strong> <%= p.getEmail()%></p>
            <p><strong>Hobbies:</strong> <%= p.getHobbies()%></p>
            <p><strong>About Me:</strong><br> <%= p.getIntroduction()%></p>

        </div>
        <div class="back-button">
            <a href="viewProfiles.jsp">View All Profiles & Manage</a>
        </div>

    </body>
</html>
