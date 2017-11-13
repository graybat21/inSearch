package com.insearch.dao;

import com.insearch.vo.UserVO;

public interface UserDAO {
	public int emailCheck(String email);
	public int emailAccept(String email,String emailflag);
	public int join(UserVO userVO);
	public UserVO userLogin(String email);
	public UserVO selectList();	     
	public int memberSecession(String email);
	public int pwChange(String email,String passwordSecret);             
}
