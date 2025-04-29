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
            double aPrice = 150 + (random.nextDouble() * 10);   // Random price
            double bPrice = 800 + (random.nextDouble() * 40); // Random price

            long lastAUpdate = System.currentTimeMillis();
            long lastBUpdate = System.currentTimeMillis();

            while (true) {
                long currentTime = System.currentTimeMillis();
                if (currentTime - lastAUpdate >= 1000) {
                    aPrice = 150 + (random.nextDouble() * 10);
                    lastAUpdate = currentTime;
                }

                if (currentTime - lastBUpdate >= 3000) {
                    bPrice = 800 + (random.nextDouble() * 40);
                    lastBUpdate = currentTime;
                }

                String stockJson = String.format("{\"A\": %.2f, \"B\": %.2f}", aPrice, bPrice);

                // Send SSE data
                out.println("data: " + stockJson);
                out.println(); // Blank line required for SSE
                out.flush();

                try {
                    Thread.sleep(200);
                } catch (InterruptedException e) {
                    break; // Exit the loop if interrupted
                }
            }
        }
    }
}
