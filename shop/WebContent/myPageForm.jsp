<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 로그인 후 사용가능한 페이지
	// 만약 로그인을 했다면 필요한 매개변수 값 디버깅 후 member 클래스 객체에 저장
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} else {
		System.out.println(loginMember.getMemberLevel());
		System.out.println(loginMember.getMemberName());
	}
	Member member = new Member();
	member.setMemberLevel(loginMember.getMemberLevel());
	member.setMemberName(loginMember.getMemberName());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<h4>My Page</h4>
	<form method="post" action="<%=request.getContextPath() %>/myPageAction.jsp">
		<table class="table">
			<tr>
				<td>
					<img src="<%=request.getContextPath() %>/image/user.png" width=100 height=100>
					<div>
						프로필 이미지
						<a href="<%=request.getContextPath() %>/updateProfileImgForm.jsp">update</a>
					</div>
				</td>
			</tr>
			<tr>
				<td>Nickname</td>
				<td>
					<div><%=member.getMemberName() %></div>
					<a href="<%=request.getContextPath() %>/updateMemberNameForm.jsp">update</a>
				</td>
			</tr>
			<tr>
				<td>Level</td>
				<td>
					<%
						if(member.getMemberLevel() == 0){
					%>
							<div>일반 회원</div>
					<%
						} else if(member.getMemberLevel() == 1){
					%>
							<div>관리자</div>
					<%		
						} else {
					%>
							<div>존재하지 않는 등급입니다.</div>
					<%
						}
					%>
				</td>
			</tr>
			<tr>
				<td>Password</td>
				<td>
					<a href="<%=request.getContextPath() %>/updatePwForm.jsp">update</a>
				</td>
			</tr>
		</table>
		<a href="<%=request.getContextPath() %>/index.jsp">back</a>
	</form>
</div>
</body>
</html>