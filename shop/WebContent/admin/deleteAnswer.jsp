<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");

	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	// 디버깅 코드
	System.out.println("답변 삭제" + qnaNo);
	// 방어코드
	if(request.getParameter("qnaNo") == null) {
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp?currentPage=1");
		return;
	}
	// dao 클래스 객체 생성
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	
	qnaCommentDao.deleteA(qnaNo);
	System.out.println("success deleteA");
	response.sendRedirect(request.getContextPath() + "/admin/selectQnaList.jsp");
%>