<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// encoding
	request.setCharacterEncoding("utf-8");

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// debug
	System.out.println("noticeNo ->" + noticeNo);
	System.out.println("noticeTitle ->" + noticeTitle);
	System.out.println("noticeContent ->" + noticeContent);

	// 방어코드
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp?currentPage=1");
		return;
	}
	
	// dao
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	noticeDao.updateNoticeByAdmin(notice);
	System.out.println("Update Success");
	response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp");
%>