<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");
	
	QnaComment qnaComment = new QnaComment();
	// 로그인 후 문의 사항 입력 가능
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		%>
			<div>로그인 후 관리자 계정만 사용할 수 있는 페이지입니다.</div>
		<%
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} else {
		// memberNo값 디버깅 코드
		System.out.println(loginMember.getMemberNo());
		qnaComment.setMemberNo(loginMember.getMemberNo());
		
	}
	
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	// 매개변수 값 디버깅 코드
	System.out.println(request.getParameter("qnaCommentContent"));
	// qna 클래스 객체의 set() 메서드 호출
	qnaComment.setQnaCommentContent(request.getParameter("qnaCommentContent"));
	// insertQ() 메서드 호출 
	qnaCommentDao.insertA(qnaComment);
	// 메서드 호출 후 입력을 마치고 selectQnaList.jsp로 강제 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectQnaList.jsp");
%>