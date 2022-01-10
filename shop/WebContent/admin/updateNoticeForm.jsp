<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 방어코드
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp?currentPage=1");
		return;
	}

	// encoding
	request.setCharacterEncoding("utf-8");

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// debug
	System.out.println("debug " + noticeNo + " <-- noticeNo");
	
	// dao
	NoticeDao noticeDao = new NoticeDao();
	
	Notice notice = noticeDao.selectNoticeOne(noticeNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- start : 관리자 adminMenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : 관리자 adminMenu include -->
	
	<form method="post" action="<%=request.getContextPath() %>/admin/updateNoticeAction.jsp">
		<div class="container p-3 my-3 border">
			<div class="jumbotron">
			  <h1>Update Notice</h1>
			</div>
		
				<table class="table table-borderless table-hover">
						<tr class="border-bottom font-weight-bold">
							<th class="text-right">noticeNo</th>
							<td><input type="text" class="text-center" name="noticeNo" value="<%=notice.getNoticeNo() %>" readonly="readonly"></td>					
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">memberNo</th>
							<td><input type="text" class="text-center" name="memberNo" value="<%=notice.getMemberNo() %>" readonly="readonly"></td>					
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">noticeTitle</th>
							<td><input type="text" class="text-center" name="noticeTitle" value="<%=notice.getNoticeTitle() %>"></td>					
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">noticeContent</th>
							<td><input type="text" class="text-center" name="noticeContent" value="<%=notice.getNoticeContent() %>"></td>					
						</tr>				
						<tr class="border-bottom font-weight-bold">				
							<th class="text-right">createDate</th>
							<td><input type="text" class="text-center" name="createDate" value="<%=notice.getCreateDate() %>" readonly="readonly"></td>
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">updateDate</th>
							<td><input type="text" class="text-center" name="updateDate" value="<%=notice.getUpdateDate() %>" readonly="readonly"></td>				
						</tr>
				</table>
		</div>
				
		<div class="text-center">
			<button type="submit" class="btn btn-outline-dark">Update</button>
			<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/admin/selctNoticeOne.jsp?noticeNo=<%=notice.getNoticeNo() %>">Cancel</a>
		</div>
	</form>
</div>
</body>
</html>