<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
	// 인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");
	// 로그인 후 이용 가능한 페이지
	Member loginMember = (Member) session.getAttribute("loginMember");
	if (loginMember == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	// multipart/form-data로 넘겼기 때문에 request.getParameter("")형태 사용불가
	MultipartRequest mr = new MultipartRequest(
			request, "D:/project/shop/WebContent/image", 1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
%>