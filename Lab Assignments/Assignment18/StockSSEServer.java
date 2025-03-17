import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/stocks-sse")
public class StockSSEServer extends HttpServlet {
    private static final Random random = new Random();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/event-stream");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        while (true) {
            double applePrice = 150 + (random.nextDouble() * 10);   // Random price
            double googlePrice = 2700 + (random.nextDouble() * 50); // Random price

            String stockJson = String.format("{\"AAPL\": %.2f, \"GOOGL\": %.2f}", applePrice, googlePrice);

            // Send data to the client
            out.println("data: " + stockJson);
            out.println(); // SSE requires a blank line
            out.flush();

            try {
                Thread.sleep(2000); // Send updates every 2 seconds
            } catch (InterruptedException e) {
                e.printStackTrace();
                break;
            }
        }
    }
}
