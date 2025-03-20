<%@ page import="java.sql.*" %>
<%
    String oldPass = request.getParameter("oldPass");
    String newPass = request.getParameter("newPass");
    String username = request.getParameter("username");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/demo_db";
        String user="root";
        String password="0000";
        Connection conn = DriverManager.getConnection(url,user,password);

        // Verify old password
        String sql="SELECT password FROM customers WHERE username = ?";
        PreparedStatement stmt=conn.prepareStatement(sql);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();

        if (rs.next() && rs.getString("password").equals(oldPass)) {
            // Update password
            stmt = conn.prepareStatement("UPDATE customers SET password = ? WHERE username = ?");
            stmt.setString(1, newPass);
            stmt.setString(2, username);
            stmt.executeUpdate();
            out.print("Password changed successfully!");
        } else {
            out.print("Old password is incorrect!");
        }
    } catch (Exception e) {
        out.print("Database error!");
        e.printStackTrace();
    }
%>
