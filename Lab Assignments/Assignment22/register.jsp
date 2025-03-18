<%@ page import="java.sql.*" %>
<%
    String loginName = request.getParameter("loginName");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/demo_db";
        String username="root";
        String passwd="0000";
        Connection conn = DriverManager.getConnection(url,username,passwd);

        PreparedStatement stmt = conn.prepareStatement("INSERT INTO users (loginName, password, email, phone) VALUES (?, ?, ?, ?)");
        stmt.setString(1, loginName);
        stmt.setString(2, password);
        stmt.setString(3, email);
        stmt.setString(4, phone);

        int rowsInserted = stmt.executeUpdate();
        if (rowsInserted > 0) {
            out.println("<h3>Account created successfully!</h3>");
        } else {
            out.println("<h3>Error creating account.</h3>");
        }

        conn.close();
    } catch (Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    }
%>
