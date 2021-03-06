package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;

public class EbookDao {
	
	//[All] 메인 화면 페이징
	public int totalEbookCount(String ebookCategory) throws ClassNotFoundException, SQLException {
		// 매개변수 값 디버깅 코드
		System.out.println("[Debug] EbookDao.totalEbookCount ebookCategory : " + ebookCategory);
		// DB 연동
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT COUNT(*) from ebook WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookCategory);
		// 디버깅 코드
		System.out.println("[Debug] EbookDao.totalEbookCount stmt : " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			System.out.println("EbookDao.totalEbookCount - Success!");
			return rs.getInt("COUNT(*)");
		}
		return 0;
	}
	// [All] 신상품 목록 5개
	public ArrayList<Ebook> selectNewEbookList() throws ClassNotFoundException, SQLException{
		ArrayList<Ebook> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice  FROM ebook e ORDER BY create_date DESC LIMIT 0, 5";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();

		System.out.println("[Debug] EbookDao.selectEbookList stmt : " + stmt);
		System.out.println("[Debug] EbookDao.selectEbookList rs : " + rs);


		while (rs.next()) {
			Ebook e = new Ebook();

			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));

			list.add(e);
		}

		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	// [All] 베스트 전자책 목록 5개
	public ArrayList<Ebook> selectPopularEbookList() throws SQLException, ClassNotFoundException {
		ArrayList<Ebook> list = new ArrayList<>();
		/*
		 	SELECT t.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_img ebookImg, e.ebook_price ebookPrice
			FROM ebook e INNER JOIN (SELECT ebook_no, COUNT(ebook_no) cnt FROM orders
									GROUP BY ebook_no
									ORDER BY COUNT(ebook_no) DESC
									LIMIT 0, 5) t
			ON e.ebook_no = t.ebook_no
		 */
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT t.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_img ebookImg, e.ebook_price ebookPrice FROM ebook e INNER JOIN (SELECT ebook_no, COUNT(ebook_no) cnt FROM orders GROUP BY ebook_no ORDER BY COUNT(ebook_no) DESC LIMIT 0, 5) t ON e.ebook_no = t.ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			list.add(e);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	// [관리자] 전자책 이미지 수정
	public void updateEbookImg(Ebook ebook) throws ClassNotFoundException, SQLException {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE ebook SET ebook_img=? WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookImg());
		stmt.setInt(2, ebook.getEbookNo());
		stmt.executeUpdate();
		stmt.close();
		conn.close();
	}
	// 전자책 상세보기
	public Ebook selectEbookOne(int ebookNo) throws ClassNotFoundException, SQLException {
		Ebook ebook = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_img ebookImg, ebook_summary ebookSummary, ebook_state ebookState FROM ebook WHERE ebook_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookAuthor(rs.getString("ebookAuthor"));
			ebook.setEbookCompany(rs.getString("ebookCompany"));
			ebook.setEbookPageCount(rs.getInt("ebookPageCount"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookSummary(rs.getString("ebookSummary"));
			ebook.setEbookState(rs.getString("ebookState"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return ebook;
	}
	
	// [관리자 & 고객] ebook 목록출력
	public ArrayList<Ebook> selectEbookList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Ebook> list = new ArrayList<>();
		/*
		 * SELECT ebook_no ebookNo, ebook_title ebookTitle, category_name categoryName,
		 * ebook_state ebookState FROM ebook ORDER BY create_date DESC LIMIT ?, ?
		 */
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice, category_name categoryName, ebook_state ebookState FROM ebook ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();

		System.out.println("[Debug] EbookDao.selectEbookList stmt : " + stmt);
		System.out.println("[Debug] EbookDao.selectEbookList rs : " + rs);


		while (rs.next()) {
			Ebook e = new Ebook();

			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookState(rs.getString("ebookState"));

			list.add(e);
		}

		rs.close();
		stmt.close();
		conn.close();

		return list;
	}

	// [관리자] 카테고리별 ebook 목록출력
	public ArrayList<Ebook> selectEbookListByCategory(int beginRow, int rowPerPage, String category)
			throws ClassNotFoundException, SQLException {
		ArrayList<Ebook> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, category_name categoryName, ebook_state ebookState FROM ebook WHERE category_name LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + category + "%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();

		System.out.println("[Debug] EbookDao.selectEbookList stmt : " + stmt);
		System.out.println("[Debug] EbookDao.selectEbookList rs : " + rs);

		while (rs.next()) {
			Ebook e = new Ebook();

			// 정보은닉되어있는 필드값 직접 쓰기 불가
			// 캡슐화 메서드(setter)를 통해 쓰기
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookState(rs.getString("ebookState"));

			list.add(e);
		}

		rs.close();
		stmt.close();
		conn.close();

		return list;
	}

	// [관리자] ebook 마지막 페이지 도출
	public int selectEbookLastPage(int rowPerPage, String category) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "";
		if (category.equals("") == true) {
			sql = "SELECT COUNT(*) from ebook";
		} else {
			sql = "SELECT COUNT(*) from ebook WHERE category_name LIKE '%" + category + "%'";
		}

		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int totalRowCount = 0;

		System.out.println("[Debug] selectebookLastPage stmt : " + stmt);
		System.out.println("[Debug] selectebookLastPage rs : " + rs);

		if (rs.next()) {
			totalRowCount = rs.getInt("COUNT(*)");
		}
		lastPage = totalRowCount / rowPerPage;
		if (totalRowCount % rowPerPage != 0) {
			lastPage++;
		}

		rs.close();
		stmt.close();
		conn.close();

		return lastPage;
	}

}