package com.insearch.service;

import com.insearch.vo.UserVO;

public interface UserService {
	public int emailCheck(String email);
	public int userExist(UserVO userVo);
	public int emailAccept(String email,int emailflag);
	public int join(UserVO userdto);
	public UserVO userLogin(String email);
	public UserVO selectList();	           
}
