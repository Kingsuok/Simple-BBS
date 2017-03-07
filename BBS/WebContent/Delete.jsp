<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>
<%!
private void delete(Connection connection, String id){
	Statement statement = null;
	ResultSet resultSet = null;
	try {
		statement = connection.createStatement();
		String sql = "select * from article where pid =" + id;
		resultSet = statement.executeQuery(sql);
		while (resultSet.next()){
			delete(connection, resultSet.getString("id"));
		}
		statement.executeUpdate("delete from article where id =" + id);
	} catch (SQLException e){
		e.printStackTrace();
	} finally {
		try{
			if (resultSet != null){
				resultSet.close();
				resultSet = null;
			}
		} catch (SQLException e){
			e.printStackTrace();
		}
	}
}
%>

<%
String checkAdmin = (String)session.getAttribute("admin");
if (checkAdmin == null || !checkAdmin.equals("true") ){
	out.println("You are not an admin!");
	return;
}
String id = request.getParameter("id");
String pid = request.getParameter("pid");
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?useUnicode=true&characterEncoding=utf-8&useSSL=false&user=root&password=root";
Connection connection = DriverManager.getConnection(url);
connection.setAutoCommit(false);
delete(connection, id);
Statement statement = connection.createStatement();
String sql = "select count(*) from article where pid = " + pid;
ResultSet resultSet = statement.executeQuery(sql);
resultSet.next();
if (resultSet.getInt(1) == 0){
	statement.executeUpdate("update article set isleaf = 0 where id = " + pid);
}
connection.commit();
connection.setAutoCommit(true);
connection.close();
connection = null;
statement.close();
statement = null;
response.sendRedirect("ShowArticleTree.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>

</body>
</html>