package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;
import vo.Member;
import vo.Order;
import vo.OrderEbookMember;

public class OrderDao {
	
	public ArrayList<OrderEbookMember> selectOrderListByMember(int memberNo) throws ClassNotFoundException, SQLException {
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT o.order_no orderNo,e.ebook_no ebookNo,e.ebook_title ebookTitle,m.member_no memberNo,m.member_id memberId,o.order_price orderPrice,o.create_date createDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no WHERE m.member_no=? ORDER BY o.create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	public ArrayList<OrderEbookMember> selectOrderList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT o.order_no orderNo,e.ebook_no ebookNo,e.ebook_title ebookTitle,m.member_no memberNo,m.member_id memberId,o.order_price orderPrice,o.create_date createDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no ORDER BY o.create_date DESC Limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	// [????????????] ???????????????????????? ???????????????????? ??????????????????
	// Oder ??????????????? ?????????????????????????? ???????????? DB?????? insert ??????
	public boolean insertOrder(Order order) throws ClassNotFoundException, SQLException {
		boolean result = false;
		
		// ????????????????????? ???????????? ??????????????????
		System.out.println(order.getEbookNo() + "<--- OrderDao.insertOrder parem : EbookNo");
		System.out.println(order.getMemberNo() + "<--- OrderDao.insertOrder parem : MemberNo");
		System.out.println(order.getOrderPrice() + "<--- OrderDao.insertOrder parem : OrderOrderPrice");
		
		// DB ????????????
		// dbUtil ???????????? ????????????
		DBUtil dbUtil = new DBUtil();
		// dbUtil?????? getConnection???????????????????????? ??????????????????????? DB ?????????
		Connection conn = dbUtil.getConnection();
		System.out.println(conn + "<--- conn");
		String sql = "INSERT INTO orders(ebook_no, member_no, order_price, create_date, update_date) VALUES (?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, order.getEbookNo());
		stmt.setInt(2, order.getMemberNo());
		stmt.setInt(3, order.getOrderPrice());
		// ?????????????????? ???????????? : ???????????????????????? ???????????????????????? ??????????????????????????? ?????????????????????
		System.out.println(stmt + "<--- stmt");
		
		// INSERT ????????????
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
		}
		
		// ????????????
		stmt.close();
		conn.close();
		
		// ????????? : result = true, ???????????? : false
		return result;
	}
}