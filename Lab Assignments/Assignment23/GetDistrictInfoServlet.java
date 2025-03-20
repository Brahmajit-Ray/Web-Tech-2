import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@WebServlet("/GetDistrictInfo")
public class GetDistrictInfoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        String district_id = request.getParameter("district_id");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/demo_db";
            String username="root";
            String password="0000";
            Connection conn = DriverManager.getConnection(url,username,password);

            String sql="SELECT * FROM district_info WHERE district_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, district_id);
            ResultSet rs = stmt.executeQuery();
            
            JsonObject districtInfo = new JsonObject();
            if (rs.next()) {
                districtInfo.addProperty("population", rs.getInt("population"));
                districtInfo.addProperty("area", rs.getDouble("area_sq_km"));
                districtInfo.addProperty("description", rs.getString("description"));
            }
            out.print(districtInfo.toString());
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
