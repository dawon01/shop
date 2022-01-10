<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");

	Qna qna = new Qna();
	QnaDao qnaDao = new QnaDao();
	
	qna.setQnaContent(request.getParameter("qnaContent"));
	qna.setQnaNo(Integer.parseInt(request.getParameter("qnaNo")));

	qnaDao.updateQ(qna);
	// selectMemberList.jsp로 이동
	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");


%>