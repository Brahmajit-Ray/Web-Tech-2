<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Quiz</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Online Quiz</h2>
    <form action="submitQuiz.jsp" method="post">
        <%
            String url = "jdbc:mysql://localhost:3306/demo_db";
            String user = "root";
            String password = "0000";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM questions");

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String text = rs.getString("text");
                    String optionA = rs.getString("optionA");
                    String optionB = rs.getString("optionB");
                    String optionC = rs.getString("optionC");
                    String optionD = rs.getString("optionD");
        %>
                    <p><strong><%= text %></strong></p>
                    <input type="radio" name="answer<%= id %>" value="A"> <%= optionA %><br>
                    <input type="radio" name="answer<%= id %>" value="B"> <%= optionB %><br>
                    <input type="radio" name="answer<%= id %>" value="C"> <%= optionC %><br>
                    <input type="radio" name="answer<%= id %>" value="D"> <%= optionD %><br><br>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
        <input type="submit" id="submit_button" value="Submit Quiz">
    </form>
</body>
</html>
