package com.insearch.service;

import java.util.HashMap;
import java.util.List;

import com.insearch.vo.UserVO;

public interface UserService {
	public int emailCheck(String email) throws Exception;
	public int emailAccept(String email, String emailflag) throws Exception;
	public int join(UserVO userVO) throws Exception;
	public void update(UserVO userVO) throws Exception;
	public UserVO selectOneUser(String email) throws Exception;
	public void deleteUser(String email) throws Exception;
	public void updatePassword(String email, String passwordSecret) throws Exception;   
	public int selectUserListCnt(HashMap<String, Object> map) throws Exception;
	public List<UserVO> selectUserList(HashMap<String, Object> map) throws Exception;
}
