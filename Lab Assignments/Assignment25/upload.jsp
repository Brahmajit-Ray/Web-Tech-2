<%@ page import="java.io.*, java.sql.*, javax.xml.parsers.*, org.w3c.dom.*, com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
    <title>
        Upload Page
    </title>
</head>

<%
    // Set upload directory
    String uploadDir = application.getRealPath("/") + "uploads";
    File dir = new File(uploadDir);
    if (!dir.exists()) {
        dir.mkdirs();  // Create directory if not exists
    }

    // Handle file upload using cos.jar
    MultipartRequest mRequest = new MultipartRequest(request, uploadDir, 10 * 1024 * 1024); // 10MB max file size
    File xmlFile = mRequest.getFile("xmlFile");

    if (xmlFile == null) {
        out.println("<h3 style='color:red;'>Error: No file uploaded.</h3>");
        return;
    }

    // Database connection setup
    String url = "jdbc:mysql://localhost:3306/demo_db";
    String user = "root";
    String password = "0000";
    Connection conn = null;

    try {
        // Connect to database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Parse XML file
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.parse(xmlFile);
        doc.getDocumentElement().normalize();

        NodeList questionList = doc.getElementsByTagName("question");

        String sql = "INSERT INTO questions (text, optionA, optionB, optionC, optionD, answer) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);

        for (int i = 0; i < questionList.getLength(); i++) {
            Element question = (Element) questionList.item(i);
            String text = question.getElementsByTagName("text").item(0).getTextContent();
            String optionA = question.getElementsByTagName("optionA").item(0).getTextContent();
            String optionB = question.getElementsByTagName("optionB").item(0).getTextContent();
            String optionC = question.getElementsByTagName("optionC").item(0).getTextContent();
            String optionD = question.getElementsByTagName("optionD").item(0).getTextContent();
            String answer = question.getElementsByTagName("answer").item(0).getTextContent();

            stmt.setString(1, text);
            stmt.setString(2, optionA);
            stmt.setString(3, optionB);
            stmt.setString(4, optionC);
            stmt.setString(5, optionD);
            stmt.setString(6, answer);
            stmt.executeUpdate();
        }

        out.println("<h3 style='color:green;'>Questions inserted successfully!</h3>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3 style='color:red;'>Error inserting questions: " + e.getMessage() + "</h3>");
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

