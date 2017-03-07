<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("gbk");// deal with the Chinese charactristic, if all are English, this sentence does not need
String checkPost = request.getParameter("post");
if (checkPost != null && checkPost.equals("post")){
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
	String sql = "insert into article values(null, 0, ?, ?, ?, now(), 0 )";
	PreparedStatement prepareStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	prepareStatement.setInt(1, -1);
	prepareStatement.setString(2, title);
	prepareStatement.setString(3, cont);
	prepareStatement.executeUpdate();
	connection.setAutoCommit(false);
	Statement statement = connection.createStatement();
	ResultSet keys = prepareStatement.getGeneratedKeys();
	keys.next();
	int key = keys.getInt(1);
	statement.executeUpdate("update article set rootid=" + key +" where id=" + key);
	connection.commit();
	connection.setAutoCommit(true);
	connection.close();
	connection = null;
	statement.close();
	statement = null;
	prepareStatement.close();
	prepareStatement = null;
	//response.sendRedirect("ShowArticleTree.jsp");
	response.sendRedirect("ShowArticleFlat.jsp");
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Post</title>
<script type="text/javascript">
<!--
//javascript去空格函数 
function LTrim(str){ //去掉字符串 的头空格
	var i;
	for(i=0;i<str.length; i++) {
		if(str.charAt(i)!=" ") break;
	}
	str = str.substring(i,str.length);
	return str;
}

function RTrim(str){
	var i;
	for(i=str.length-1;i>=0;i--){
		if(str.charAt(i)!=" "&&str.charAt(i)!=" ") break;
	}
	str = str.substring(0,i+1);
	return str;
}
function Trim(str){

	return LTrim(RTrim(str));

}

function check() {
	if(Trim(document.reply.title.value) == "") {
		alert("please intput the title!");
		document.reply.title.focus();
		return false;
	}
	
	if(Trim(document.reply.cont.value) == "") {
		alert("plsease input the content!");
		document.reply.cont.focus();
		return false;
	}
	
	return true;
	
}
-->
</script>
</head>
<body>
	<form name="post" action="Post.jsp" method="post" onsubmit="return check()">
		<input type="hidden" name="post" value="post">

		<table border="1">
			<tr>
				<td>
					<label>Title:</label>
					<input type="text" name="title" size="70">
				</td>
			</tr>
			<tr>
				<td>
					<label>Content:</label><br>
					<textarea cols="80" rows="12" name="cont"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="submit">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>