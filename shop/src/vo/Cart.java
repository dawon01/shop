package vo;

public class Cart {
	public Cart() {
	}
	public Cart(int cartNo, int ebookNo, String createDate) {
		this.cartNo = cartNo;
		this.ebookNo = ebookNo;
		this.setCreateDate(createDate);
	}
	private int cartNo;
	private int ebookNo;
	private String createDate;
	
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public int getEbookNo() {
		return ebookNo;
	}
	public void setEbookNo(int ebookNo) {
		this.ebookNo = ebookNo;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", ebookNo=" + ebookNo + ", createDate=" + createDate + "]";
	}
	
}

