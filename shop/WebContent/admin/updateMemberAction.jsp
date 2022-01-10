<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
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
	MemberDao memberDao = new MemberDao();

	member.setMemberPw(request.getParameter("memberPw"));
	member.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));

	memberDao.updateMemberPwByAdmin(member);
	// selectMemberList.jsp로 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>
</body>
</html>