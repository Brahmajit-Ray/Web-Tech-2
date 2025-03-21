<%@ page import="java.sql.*" %>
<%
String rollNumber = request.getParameter("roll_number");
String semester = request.getParameter("semester");
String subject = request.getParameter("subject");


if (rollNumber == null || rollNumber.trim().isEmpty() ||
    semester == null || semester.trim().isEmpty() ||
    subject == null || subject.trim().isEmpty()) {
    out.println("Error: Please fill in all fields.");
    return;
}

try {
    int roll = Integer.parseInt(rollNumber);
    int sem = Integer.parseInt(semester);

    // Database Connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url="jdbc:mysql://localhost:3306/demo_db";
    String username="root";
    String password="0000";
    Connection conn = DriverManager.getConnection(url,username,password);

    String query = "SELECT marks FROM marks WHERE roll_number = ? AND semester = ? AND subject = ?";
    PreparedStatement stmt = conn.prepareStatement(query);
    stmt.setInt(1, roll);
    stmt.setInt(2, sem);
    stmt.setString(3, subject);

    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        out.println("Marks: " + rs.getInt("marks"));
    } else {
        out.println(" No record found.");
    }

    rs.close();
    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Error fetching marks.");
}
%>
