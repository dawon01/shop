<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	
	// 구현코드
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderListByMember(loginMember.getMemberNo());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectOrderList.jsp</title>
</head>
<body>
	<h1>나의 주문 목록</h1>
	<table border="1">
		<thead>
			<tr>
				<th>orderNo</th>
				<th>ebookTitle</th>
				<th>orderPrice</th>
				<th>createDate</th>
				<th>memberId</th>
				<th>상세주문내역</th>
				<th>ebook후기</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(OrderEbookMember oem : list) {
			%>
					<tr>
						<td><%=oem.getOrder().getOrderNo()%></td>
						<td><%=oem.getEbook().getEbookTitle()%></td>
						<td><%=oem.getOrder().getOrderPrice()%></td>
						<td><%=oem.getOrder().getCreateDate()%></td>
						<td><%=oem.getMember().getMemberId()%></td>
						<td><a href="">상세주문내역</a>
						<td><a href="<%=request.getContextPath()%>/insertOrderCommentFrom.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>&ebookNo=<%=oem.getEbook().getEbookNo()%>">ebook후기</a>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
</body>
</html>
