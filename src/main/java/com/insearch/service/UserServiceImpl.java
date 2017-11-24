package com.insearch.service;


import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.insearch.dao.MapDAO;
import com.insearch.dao.UserDAO;
import com.insearch.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	
	@Inject
	private UserDAO userDao;
	
	@Override
	public UserVO selectList() {
		UserVO userVO = userDao.selectList();
		return userVO;
	}
	
	@Override
	public int emailCheck(String email){
		int result=userDao.emailCheck(email);
		return result;
	}
	
	@Override
	public int emailAccept(String email, String emailflag) {
		HashMap<String, String> map=new HashMap<>();
		map.put("email", email);
		map.put("emailflag", emailflag);		
		
		int result = userDao.emailAccept(email, emailflag);
		return result;
	}
	
	@Override
	public int join(UserVO userVO) {
		int result = userDao.join(userVO);
		return result;
	}
	
	@Override
	public void update(UserVO userVO) {
		userDao.update(userVO);
	}
	
	@Override
	public UserVO selectOneUser(String email) {		
		UserVO userdto = userDao.selectOneUser(email);		
		return userdto;
	}
	
	@Override
	public int memberSecession(String email){
		int result = userDao.memberSecession(email);
		return result;
	}
	
	@Override
	public int pwChange(String email,String pw){
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("email",email);
		map.put("pw", pw);
		
		int result = userDao.pwChange(email, pw);
		
		return result;
	}
	
//	@Transactional
//	@Override
//	public void delete(UserVO userdto) throws Exception {
//		reviewDao.deleteCommentByEmail(user_no);
//		userDao.delete(email);
//	}
	
	@Override
	public int selectListCnt(HashMap<String, Object> map) {
		return userDao.selectListCnt(map);
	}
	
	@Override
	public List<UserVO> userList(HashMap<String, Object> map) {
		return userDao.userList(map);
	}
}
