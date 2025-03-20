<%@ page import="java.sql.*, org.json.JSONArray, org.json.JSONObject" %>
<%@ page contentType="application/json;charset=UTF-8" %>

<%
    String type = request.getParameter("type");
    JSONArray componentsArray = new JSONArray();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/demo_db";
        String username="root";
        String password="0000";
        Connection conn = DriverManager.getConnection(url,username,password);

        String sql="SELECT manufacturer, model, price FROM components WHERE component_type=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, type);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            JSONObject component = new JSONObject();
            component.put("manufacturer", rs.getString("manufacturer"));
            component.put("model", rs.getString("model"));
            component.put("price", rs.getDouble("price"));
            componentsArray.put(component);
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    out.print(componentsArray.toString());
%>
