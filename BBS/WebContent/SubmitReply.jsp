<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("gbk");// deal with the Chinese charactristic, if all are English, this sentence does not need
int id = Integer.parseInt(request.getParameter("id"));
int rootid = Integer.parseInt(request.getParameter("rootid"));
String title = request.getParameter("title");
String cont = request.getParameter("cont");
if (title == null){
	out.println("Title should not be empty!");
	return;
}
if (cont == null){
	out.println("Content should not be empty!");
	return;
}
title.trim();
cont.trim();
if (title.equals("")){
	out.println("Title should not be empty!");
	return;
}
if (cont.equals("")){
	out.println("Content should not be empty!");
	return;
}
cont = cont.replaceAll("\n", "<br>");
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?useUnicode=true&characterEncoding=utf-8&useSSL=false&user=root&password=root";
Connection connection = DriverManager.getConnection(url);
String sql = "insert into article values(null, ?, ?, ?, ?, now(), 0 )";
PreparedStatement prepareStatement = connection.prepareStatement(sql);
prepareStatement.setInt(1, id);
prepareStatement.setInt(2, rootid);
prepareStatement.setString(3, title);
prepareStatement.setString(4, cont);
prepareStatement.executeUpdate();
connection.setAutoCommit(false);
Statement statement = connection.createStatement();
statement.executeUpdate("update article set isleaf=1 where id=" + id);
connection.commit();
connection.setAutoCommit(true);
connection.close();
connection = null;
statement.close();
statement = null;
prepareStatement.close();
prepareStatement = null;
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