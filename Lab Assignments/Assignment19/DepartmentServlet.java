import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DepartmentServlet")
public class DepartmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String department = request.getParameter("department");

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/demo_db";
            String username="root";
            String password="0000";
            Connection conn = DriverManager.getConnection(url,username,password);

            String sql = "SELECT * FROM students WHERE dept_name = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, department);
            ResultSet rs = stmt.executeQuery();

            out.println("<h2>Students in " + department + " Department</h2>");
            out.println("<table border='1'><tr><th>Roll Number</th><th>Name</th><th>Department</th></tr>");
            while (rs.next()) {
                out.println("<tr><td>" + rs.getInt("roll_number") + "</td><td>" + rs.getString("name") + "</td><td>" + rs.getString("dept_name") + "</td></tr>");
            }
            out.println("</table>");
            conn.close();
        
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
