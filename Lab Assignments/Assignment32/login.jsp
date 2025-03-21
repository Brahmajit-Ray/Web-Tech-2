<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/demo_db";
        String user="root";
        String passwd="0000";
        Connection conn = DriverManager.getConnection(url,user,passwd);

        String sql = "SELECT * FROM users2 WHERE username=? AND password=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            out.print("success");
        } else {
            out.print("failure");
        }
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>

