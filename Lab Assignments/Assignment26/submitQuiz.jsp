<%@ page import="java.sql.*, java.util.Enumeration" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Results</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Quiz Results</h2>
    <%
        String url = "jdbc:mysql://localhost:3306/demo_db";
        String user = "root";
        String password = "0000";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int correctCount = 0;
        int totalQuestions = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            Enumeration<String> parameterNames = request.getParameterNames();
            while (parameterNames.hasMoreElements()) {
                String paramName = parameterNames.nextElement();
                if (paramName.startsWith("answer")) {
                    totalQuestions++;
                    String userAnswer = request.getParameter(paramName);
                    int questionId = Integer.parseInt(paramName.replace("answer", ""));

                    // Check correct answer from database
                    String sql = "SELECT answer FROM questions WHERE id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, questionId);
                    rs = stmt.executeQuery();

                    if (rs.next() && rs.getString("answer").equals(userAnswer)) {
                        correctCount++;
                    }
                }
            }
    %>
            <p>You answered <strong><%= correctCount %> out of <%= totalQuestions %></strong> questions correctly.</p>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
</body>
</html>
