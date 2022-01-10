<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");

	Member member = new Member();
	member.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
	// 디버깅 코드
	System.out.println("memberNo ->" + member.getMemberNo());
%>
	<form id="updatePW" action="<%=request.getContextPath() %>/admin/updateMemberAction.jsp">
		<h1>Update Password</h1>
		<div>memberPw : </div>
		<div><input id="memberPw" type = "password" name="memberPw"></div>
		<div><input type = "text" id="memberNo" name="memberNo" hidden="hidden" value = "<%=member.getMemberNo()%>"></div>
		<button id="updatePWbtn" type="button">Update PW</button>
	</form>
	<Script>
		$('#updatePWbtn').click(function(){
			if($('#memberPw').val() == ''){
				alert('memberPw를 입력하세요');
				return;
			}
			$('#updatePW').submit();
		});
	</Script>
</body>
</html>