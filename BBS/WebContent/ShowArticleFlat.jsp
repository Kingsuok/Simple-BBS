
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>
<%
/*
boolean admin = false;
String checkAdmin = (String)session.getAttribute("admin");
if (checkAdmin != null && checkAdmin.equals("true")){
	admin = true;
	
}
*/
%>

<%
	int pageSize = 3;
	int pageNo = 1;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !pageNoStr.equals("")){
		pageNoStr = pageNoStr.trim();
		if (pageNoStr.matches("[1-9]+")){
			pageNo = Integer.parseInt(pageNoStr);
		}
	}

	
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?useUnicode=true&characterEncoding=utf-8&useSSL=false&user=root&password=root";
    Connection connection = DriverManager.getConnection(url);
    Statement statement = connection.createStatement();
    
    
    String sql1= "select count(*) from article where pid = 0";
    ResultSet resultSet = statement.executeQuery(sql1);
    resultSet.next();
    int totalTitle = resultSet.getInt(1); 
    int totalPage = totalTitle % pageSize == 0? totalTitle / pageSize : totalTitle / pageSize +1;
    
    if (pageNo > totalPage){
    	pageNo = totalPage;
    }
    int pageStart = (pageNo - 1) * pageSize;
    String sql2 = "select * from article where pid = 0 order by pdate desc limit " + pageStart + "," + pageSize;
    resultSet = statement.executeQuery(sql2);
   
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<br>
<a href="Post.jsp">Post New</a><br>
<br>
<table border="1">
<% 
while (resultSet.next()){
%>
	<tr>
		<td><%=resultSet.getString("title") %></td>
	</tr>
<%
}
connection.close();
connection = null;
statement.close();
statement = null;
resultSet.close();
resultSet = null;
%>
</table>
<br>
 <a href="ShowArticleFlat.jsp?pageNo=<%=pageNo-1 %>"><</a>&nbsp;Page:<%=pageNo %>&nbsp; Total:<%=totalPage %>&nbsp;<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo +1 %>">></a>
<br>
<br>
<form name="form1" action="ShowArticleFlat.jsp">
	<select name="pageNo" onchange="document.form1.submit()">
	<%for (int i = 1; i <= totalPage; i++ ){ %>
		<option value="<%=i%>" <%= i==pageNo ? "selected" : "" %>>Page <%=i %>
	<%} %>
	</select>
</form>
<br>
<form name="form2" action="ShowArticleFlat.jsp">
	<input type="text" size="4" name="pageNo" value="<%=pageNo %>" >
	<input type="submit" value="go">
</form>
</body>

</html>