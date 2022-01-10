<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");
	// 로그인 후 이용가능한 페이지
	Member loginMember = (Member) session.getAttribute("loginMember");
	if (loginMember == null) {
	      response.sendRedirect(request.getContextPath() + "/index.jsp");
	      return;
	   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateProfileImg</title>
</head>
<body>
<div class="container">
	<h4>UpdateProfileImg</h4>
	<form id="updateProfile" action="<%=request.getContextPath() %>/updateProtileImgAction.jsp" method="post" enctype="multipart/form-data">
		<table class="table">
			<tr>
				<td><img src="<%=request.getContextPath() %>/image/user.png"></td>
			</tr>
			<tr>
				<td><input type="file" name="profileImg"></td>
			</tr>
		</table>
		<button type="button" id="updateProfileImg">update</button>
	</form>	
</div>
</body>
</html>