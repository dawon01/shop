<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 인코딩 utf-8로 설정
	request.setCharacterEncoding("utf-8");

	Qna qna = new Qna();
	// 로그인 후 문의 사항 입력 가능
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		%>
			<div>로그인 후 사용 가능한 페이지입니다. 로그인 해주세요.</div>
		<%
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} else {
		// memberNo값 디버깅 코드
		System.out.println(loginMember.getMemberNo());
		qna.setMemberNo(loginMember.getMemberNo());
		
	}
	
	QnaDao qnaDao = new QnaDao();
	// insertQuestionForm.jsp에서 받아온 값 디버깅 코드
	/* 1) qnaCategory 값 디버깅
	 * 2) qnaSecret 값 디버깅
	 * 3) qnaTitle 값 디버깅
	 * 4) qnaContent 값 디버깅
	 */
	System.out.println(request.getParameter("qnaCategory"));
	System.out.println(request.getParameter("qnaSecret"));
	System.out.println(request.getParameter("qnaTitle"));
	System.out.println(request.getParameter("qnaContent"));
	// qna 클래스 객체의 set() 메서드 호출
	qna.setQnaCategory(request.getParameter("qnaCategory"));
	qna.setQnaSecret(request.getParameter("qnaSecret"));
	qna.setQnaTitle(request.getParameter("qnaTitle"));
	qna.setQnaContent(request.getParameter("qnaContent"));
	// insertQ() 메서드 호출 
	qnaDao.insertQ(qna);
	// 메서드 호출 후 입력을 마치고 selectQnaList.jsp로 강제 이동
	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
%>