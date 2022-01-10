<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	// 방어 코드 : memberIdCheck값이 공백 또는 null값인지 확인
	if(request.getParameter("memberIdCheck") == null || request.getParameter("memberIdCheck").equals("")){
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
		return;
	}
	// memberIdCheck 변수 생성 및 가져온 memberIdCheck값 입력
	String memberIdCheck = request.getParameter("memberIdCheck");
	// MemberDao.selectMemberId() 메서드 호출
	MemberDao memberDao = new MemberDao();
	// Id의 중복 여부를 확인할 변수 result 생성
	String result = memberDao.selectMemberId(memberIdCheck);
	// result값이 null일 경우, 중복이 아니기 때문에 페이지 이동과 동시에 memberIdCheck값을 보냄
	// 아닐 경우, ID 중복으로 아무값도 보내지 않음
	if(result == null){
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp?memberIdCheck=" + memberIdCheck);
	} else {
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp?memberIdResult= ID already taken");
	}
%>	