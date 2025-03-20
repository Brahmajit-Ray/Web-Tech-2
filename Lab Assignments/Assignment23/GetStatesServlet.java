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

@WebServlet("/GetStates")
public class GetStatesServlet extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/demo_db";
            String username="root";
            String password="0000";
            Connection conn = DriverManager.getConnection(url,username,password);

            String sql="SELECT * FROM states";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            JsonArray stateArray = new JsonArray();
            while (rs.next()) {
                JsonObject stateObj = new JsonObject();
                stateObj.addProperty("id", rs.getInt("state_id"));
                stateObj.addProperty("name", rs.getString("state_name"));
                stateArray.add(stateObj);
            }
            out.print(stateArray.toString());
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
