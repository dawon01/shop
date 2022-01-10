<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>

<%
	// 현재 페이지 셋팅
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	final int ROW_PER_PAGE = 10; 
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	CartDao cartDao = new CartDao();
	ArrayList<Cart> cartList = cartDao.cartList(beginRow, ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>장바구니 목록</h2>
	<a href="<%=request.getContextPath()%>/index.jsp">전자책 목록</a>
	<a href="<%=request.getContextPath()%>/removeCartAll.jsp">전체 비우기</a>
	<%
		if(session.getAttribute("cartList") == null) {
	%>
		<div>장바구니에 아이템이 없습니다.</div>
	<%
		}
	%>
	
	<% 
		if(session.getAttribute("cartList") != null) {
	%>
		<table border="1">
			<tr>
				<th>장바구니 아이디</th>
				<th>상품번호</th>
				<th>담은 날짜</th>
				<th>장바구니 삭제</th>
			</tr>
			<% 
				for(Cart c : cartList){
			%>
				<tr>
					<td><%=c.getCartNo()%></td>
					<td><%=c.getEbookNo()%></td>
					<td><%=c.getCreateDate() %></td>
					<td><a href="<%=request.getContextPath()%>/removeCart.jsp?cartNo=${c.cartNo}">삭제</a></td>
				</tr>
			<%
				}
			%>
		</table>
	<%
		}
	%>
</body>
</html>