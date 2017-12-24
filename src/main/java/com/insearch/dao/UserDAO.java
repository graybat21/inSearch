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
	public void deleteUser(String email);
	public int getNo(String email);
	public void updatePassword(HashMap<String, Object> map);        
	public int selectUserListCnt(HashMap<String, Object> map);
	public List<UserVO> selectUserList(HashMap<String, Object> map);
}
