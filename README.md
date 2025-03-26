# Web-Tech-2

This repo contains the lab assignments of Web Tech Lab 2

### Command to compile the servlet files

```bash
javac -cp "D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\lib\servlet-api.jar" -d "D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\webapps\Assignment16\WEB-INF\classes" HelloWorldServlet.java

```

### Command to compile the websocket files

```bash
javac -cp "D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\lib\websocket-api.jar" -d "D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\webapps\Assignment17\WEB-INF\classes" ChatServer.java
```

### Command to compile Assignment19

```bash
javac -cp "D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\lib\servlet-api.jar;D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\lib\mysql-connector-j-9.2.0.jar;D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\lib\gson-2.12.1.jar" -d "D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\webapps\Assignment19\WEB-INF\classes" SearchStudentServlet.java DepartmentServlet.java DepartmentListServlet.java

```
OR

```bash
javac -cp "D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\lib\servlet-api.jar;D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\lib\mysql-connector-j-9.2.0.jar;D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\lib\gson-2.12.1.jar" -d "D:\Web Tech Lab\apache-tomcat-9.0.90\apache-tomcat-9.0.90\webapps\Assignment19\WEB-INF\classes" *.java
```



### File Structure

```
apache-tomcat-9.0.90/
├── webapps/
│   ├── Assignment4
│   ├── Assignment5
│   └── ROOT
├── bin/
│   ├── startup.bat
│   └── shutdown.bat
├── lib/
|   ├── servlet-api.jar
    └── websocket-api.jar
```