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

@WebServlet("/GetDistricts")
public class GetDistrictsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        String state_id = request.getParameter("state_id");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/demo_db";
            String username="root";
            String password="0000";
            Connection conn = DriverManager.getConnection(url,username,password);

            String sql="SELECT * FROM districts WHERE state_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, state_id);
            ResultSet rs = stmt.executeQuery();
            
            JsonArray districtArray = new JsonArray();
            while (rs.next()) {
                JsonObject districtObj = new JsonObject();
                districtObj.addProperty("id", rs.getInt("district_id"));
                districtObj.addProperty("name", rs.getString("district_name"));
                districtArray.add(districtObj);
            }
            out.print(districtArray.toString());
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
