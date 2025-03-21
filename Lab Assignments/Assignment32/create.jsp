<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String contact = request.getParameter("contact");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/demo_db";
        String user="root";
        String passwd="0000";
        Connection conn = DriverManager.getConnection(url,user,passwd);


        String sql = "INSERT INTO users2 (username, password, email, name, contact) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password);
        stmt.setString(3, email);
        stmt.setString(4, name);
        stmt.setString(5, contact);
        stmt.executeUpdate();

        out.print("success");
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
