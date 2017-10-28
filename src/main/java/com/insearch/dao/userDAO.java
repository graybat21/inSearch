package com.insearch.dao;

import com.insearch.vo.UserVO;

public interface userDAO {
	public int emailCheck(String email);
	public int emailAccept(String email,int emailflag);
	public int join(UserVO userdto);
	public UserVO userLogin(String email);
	public UserVO selectList();	           
}
