package com.insearch.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.insearch.dao.MapDAO;
import com.insearch.dao.UserDAO;
import com.insearch.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	
	@Inject
	private UserDAO userDao;
	
	@Inject
	private MapDAO mapDao;
	
	@Override
	public int emailCheck(String email) throws Exception {
		int result = userDao.emailCheck(email);
		return result;
	}
	
	@Override
	public int emailAccept(String email, String emailflag) throws Exception {
		HashMap<String, String> map=new HashMap<>();
		map.put("email", email);
		map.put("emailflag", emailflag);		
		
		int result = userDao.emailAccept(email, emailflag);
		return result;
	}
	
	@Override
	public int join(UserVO userVO) throws Exception {
		int result = userDao.join(userVO);
		return result;
	}
	
	@Override
	public void update(UserVO userVO) {
		userDao.update(userVO);
	}
	
	@Override
	public UserVO selectOneUser(String email) throws Exception {
		UserVO userdto = userDao.selectOneUser(email);		
		return userdto;
	}
	
	@Transactional
	@Override
	public void deleteUser(String email) throws Exception {
		int user_no = userDao.getNo(email);
		mapDao.deleteCommentByEmail(user_no);
		userDao.deleteUser(email);
	}
	
	@Override
	public void updatePassword(String email, String pw) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("pw", pw);
		
		userDao.updatePassword(map);
	}
	
	@Override
	public int selectUserListCnt(HashMap<String, Object> map) throws Exception {
		return userDao.selectUserListCnt(map);
	}
	
	@Override
	public List<UserVO> selectUserList(HashMap<String, Object> map) throws Exception {
		return userDao.selectUserList(map);
	}
}
