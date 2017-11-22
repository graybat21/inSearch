package com.insearch.service;


import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

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
		
//		System.out.println(map.get("email") + " // " + map.get("emailflag"));
		int result = userDao.emailAccept(email, emailflag);
//		System.out.println(result);
		return result;
	}
	
	@Override
	public int join(UserVO userVO) {
		int result = userDao.join(userVO);
		return result;
	}
	
	@Override
	public UserVO userLogin(String email){		
		UserVO userdto = userDao.userLogin(email);		
		return userdto;
	}
	
	public int memberSecession(String email){
		int result = userDao.memberSecession(email);
		return result;
	}
	
	public int pwChange(String email,String pw){
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("email",email);
		map.put("pw", pw);
		int result=userDao.pwChange(email, pw);
		return result;
	}
}
