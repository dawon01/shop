<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");

	QnaComment qnaComment = new QnaComment();
	QnaCommentDao qnaCommentDao = new QnaCommentDao();

	qnaComment.setQnaCommentContent(request.getParameter("qnaCommentContent"));
	qnaComment.setQnaNo(Integer.parseInt(request.getParameter("qnaNo")));

	qnaCommentDao.updateA(qnaComment);
	// selectMemberList.jsp로 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectQnaList.jsp");


%>