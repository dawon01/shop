package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Cart;
import vo.Ebook;

public class CartDao {
	// 장바구니 목록
	public ArrayList<Cart> cartList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Cart> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT cart_no cartNo, ebook_no ebookNo, create_date createDate FROM cart ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		// 디버깅 코드
		System.out.println("[Debug] CartDao.cartList stmt : " + stmt);
		System.out.println("[Debug] CartDao.cartList rs : " + rs);
		while (rs.next()) {
			Cart c = new Cart();

			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			c.setCartNo(rs.getInt("cartNo"));
			c.setEbookNo(rs.getInt("ebookNo"));
			c.setCreateDate(rs.getString("createDate"));
			list.add(c);
		}

		rs.close();
		stmt.close();
		conn.close();

		return list;
	}
}
