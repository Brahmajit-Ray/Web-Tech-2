import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.ArrayList;
import com.google.gson.Gson;

@WebServlet("/DepartmentListServlet")
public class DepartmentListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        ArrayList<String> departments = new ArrayList<>();

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/demo_db";
            String username="root";
            String password="0000";
            Connection conn = DriverManager.getConnection(url,username,password);

            String sql = "SELECT DISTINCT dept_name FROM students";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                departments.add(rs.getString("dept_name"));
                System.out.println(rs.getString("dept_name"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Convert list to JSON
        String json = new Gson().toJson(departments);
        out.print(json);
    }
}
