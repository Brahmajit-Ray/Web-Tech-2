<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Total Price</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Selected Configuration</h2>
        <table border="1">
            <tr><th>Component</th><th>Manufacturer</th><th>Model</th><th>Price (₹)</th></tr>

            <%
                String[] components = {"hdd", "motherboard", "processor", "ram", "monitor", "cd"};
                double totalPrice = 0;
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url="jdbc:mysql://localhost:3306/demo_db";
                String username="root";
                String password="0000";
                Connection conn = DriverManager.getConnection(url,username,password);

                for (String component : components) {
                    String model = request.getParameter(component);
                    if (model != null) {
                        String sql="SELECT manufacturer, model, price FROM components WHERE model=?";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        stmt.setString(1, model);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            totalPrice += rs.getDouble("price");
            %>
                            <tr>
                                <td><%= component.toUpperCase() %></td>
                                <td><%= rs.getString("manufacturer") %></td>
                                <td><%= rs.getString("model") %></td>
                                <td><%= rs.getDouble("price") %></td>
                            </tr>
            <%
                        }
                        rs.close();
                    }
                }
                conn.close();
            %>

            <tr><td colspan="3"><strong>Total Price</strong></td><td><strong>₹<%= totalPrice %></strong></td></tr>
        </table>
    </div>
</body>
</html>
