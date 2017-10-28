package com.insearch.service;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.insearch.dao.userDAO;
import com.insearch.vo.UserVO;


@Service
public class userDAOImple implements userDAO {


	private static String namespace = "com.insearch.mappers.userMapper";

	@Inject
	private SqlSession session;

	
	@Override
	public UserVO selectList() {
		UserVO userVO = (UserVO) session.selectOne("selectList");
		return userVO;
	}

	public int emailCheck(String email){
		//int result=sqlMap.selectOne("emailCheck",email);		
		return 0;
	}
	
	public int emailAccept(String email,int emailflag){
		//update
		return 1;
	}
	
	
	public int join(UserVO userdto){
		int result=session.insert("join", userdto);
		return result;
	}
	
	public UserVO userLogin(String email){
		//List<UserVO> userlist=sqlMap.selectList("userLogin", email);
		UserVO userdto=new UserVO();
		/*if(userlist.size()==1){
			userdto=userlist.get(0);
		}	*/	
		return userdto;
	}
}
