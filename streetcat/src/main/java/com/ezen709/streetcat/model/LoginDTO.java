package com.ezen709.streetcat.model;

public class LoginDTO {
	public static final int OK = 0;
	public static final int NOT_ID = 1;
	public static final int NOT_PWD = 2;
	public static final int ERROR = -1;
	
	private String id;
	private String passwd;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	
	/*public int loginCheck() {	
	
		try {
			con = pool.getConnection();
			String sql = "select passwd from jsp_member where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				String dbPass = rs.getString(1);
				if (dbPass.trim().equals(passwd)) {
					return OK;
				}else {
					return NOT_PWD;
				}
			}else {
				return NOT_ID;
			}
		}catch(SQLException e) {
			e.printStackTrace();
			return ERROR;
		}finally {
			try {
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (con != null) con.close();
			}catch(SQLException e) {}
		}
	}*/
}
