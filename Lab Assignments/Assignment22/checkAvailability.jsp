<%@ page import="java.sql.*" %>
<%
    String loginName = request.getParameter("loginName");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/demo_db";
        String username="root";
        String password="0000";
        Connection conn = DriverManager.getConnection(url,username,password);

        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE loginName = ?");
        stmt.setString(1, loginName);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            out.print("taken");
        } else {
            out.print("available");
        }

        conn.close();
    } catch (Exception e) {
        out.print("error");
    }
%>
