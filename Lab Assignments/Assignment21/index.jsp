<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.Cookie" %>
<!DOCTYPE html>
<html>
<head>
    <title>Counter Page</title>
</head>
<body>
    <h2>Session Tracking Counter</h2>

    <%
        int counter = 0;

        // **Hidden Field Method**
        String hiddenCounter = request.getParameter("hiddenCounter");
        if (hiddenCounter != null) {
            counter = Integer.parseInt(hiddenCounter);
        }

        // **URL Rewriting Method**
        String urlCounter = request.getParameter("urlCounter");
        if (urlCounter != null) {
            counter = Integer.parseInt(urlCounter);
        }

        //  **Cookie Method**
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("counter")) {
                    counter = Integer.parseInt(cookie.getValue());
                }
            }
        }

        //  **Session API Method**
        Integer sessionCounter = (Integer) session.getAttribute("counter");
        if (sessionCounter != null) {
            counter = sessionCounter;
        }

        // Get action: prev or next
        String action = request.getParameter("action");
        if ("next".equals(action)) {
            counter++;
        } else if ("prev".equals(action)) {
            counter--;
        }

        // Save in Session
        session.setAttribute("counter", counter);

        // Save in Cookie
        Cookie counterCookie = new Cookie("counter", String.valueOf(counter));
        counterCookie.setMaxAge(60 * 60); // 1 hour
        response.addCookie(counterCookie);
    %>

    <h2>Current Value: <%= counter %></h2>

    <!-- Buttons with Hidden Fields -->
    <form method="GET" action="index.jsp">
        <input type="hidden" name="hiddenCounter" value="<%= counter %>">
        <button type="submit" name="action" value="prev">Prev</button>
        <button type="submit" name="action" value="next">Next</button>
    </form>

    <!-- URL Rewriting Method -->
    <p><a href="index.jsp?action=prev&urlCounter=<%= counter %>">Prev (URL Rewriting)</a></p>
    <p><a href="index.jsp?action=next&urlCounter=<%= counter %>">Next (URL Rewriting)</a></p>

</body>
</html>
