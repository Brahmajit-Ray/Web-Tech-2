<%@ page import="java.sql.*" %>
<%@ page contentType="text/plain" %>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
    out.print("failure");
    return;
}


try {
    // Database Connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url="jdbc:mysql://localhost:3306/demo_db";
    String user="root";
    String passwd="0000";
    Connection conn = DriverManager.getConnection(url,user,passwd);

    // SQL Query to check credentials
    String sql = "SELECT * FROM customers WHERE username=? AND password=?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, username);
    stmt.setString(2, password);
    
    ResultSet rs = stmt.executeQuery();
    
    if (rs.next()) {
        out.print("success"); // Valid credentials
    } else {
        out.print("failure"); // Invalid credentials
    }
} catch (Exception e) {
    e.printStackTrace();
    out.print("error");
}
%>
