package com.insearch.dao;

import java.util.HashMap;
import java.util.List;

import com.insearch.vo.UserVO;

public interface UserDAO {
	public int emailCheck(String email);
	public int emailAccept(String email, String emailflag);
	public int join(UserVO userVO);
	public void update(UserVO userVO);
	public UserVO selectOneUser(String email);
	public UserVO selectList();	     
	public int memberSecession(String email);
	public int pwChange(String email, String passwordSecret);        
	public int selectListCnt(HashMap<String, Object> map);
	public List<UserVO> userList(HashMap<String, Object> map);
}
