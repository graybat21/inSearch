package com.insearch.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.insearch.dao.UserDAO;
import com.insearch.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO userDao;

	@Override
	public UserVO selectList() {
		return userDao.selectList();
	}
	
	@Override
	public int emailCheck(String email){
		//int result=sqlMap.selectOne("emailCheck",email);		
		return 0;
	}
	
	@Override
	public int userExist(UserVO userVo) {
		return userDao.userExist(userVo);
	}
	
	@Override
	public int emailAccept(String email,String emailflag){
		return userDao.emailAccept(email, emailflag);
	}
	
	@Override
	public int join(UserVO userdto){
		return userDao.join(userdto);
	}
	
	@Override
	public UserVO userLogin(String email){
		return userDao.userLogin(email);
	}
}
