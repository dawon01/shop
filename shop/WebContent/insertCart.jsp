<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%> 
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8"); //인코딩	
	//인증 방어 코드 : 로그인 전 session.getAttribute("loginMember") == null 인 경우
	if(session.getAttribute("loginMember")==null){
		System.out.println("로그인 해야됨");
		response.sendRedirect("./index.jsp"); //로그인 안되면 후기 달수 없음.
		return;
	}
	Cart cart = new Cart();
	
	// 장바구니 추가 링크
	if(request.getParameter("ebookNo") != null) {
		int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
		cart.setEbookNo(ebookNo);
	}
	if(session.getAttribute("cartList") == null) {
		List<Cart> cartList = new ArrayList<Cart>();
		cartList.add(cart);
		session.setAttribute("cartList", cartList);
	} else {
		List<Cart> cartList = (List<Cart>)session.getAttribute("cartList");
		cartList.add(cart);
	}
 %>