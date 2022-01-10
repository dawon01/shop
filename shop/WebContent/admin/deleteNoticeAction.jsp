<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// encoding
	request.setCharacterEncoding("utf-8");

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// debug
	System.out.println("Delete" + noticeNo);

	// 방어코드
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect("./selectNoticeList.jsp?currentPage=1");
		return;
	}
	
	// dao
	NoticeDao noticeDao = new NoticeDao();
	
	noticeDao.deleteNoticeByAdmin(noticeNo);
	System.out.println("Delete Success");
	response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp");
%>