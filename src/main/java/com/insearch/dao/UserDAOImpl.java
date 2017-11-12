package com.insearch.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.insearch.vo.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {
	private static String namespace = "com.insearch.mappers.userMapper";

	@Inject
	private SqlSession session;
	
	@Override
	public UserVO selectList() {
		UserVO userVO = (UserVO) session.selectOne("selectList");
		return userVO;
	}
	
	@Override
	public int emailCheck(String email){
		//int result=sqlMap.selectOne("emailCheck",email);		
		return 0;
	}
	
	@Override
	public int userExist(UserVO userVo) {
		return session.selectOne(namespace + ".userExist", userVo);
	}
	
	@Override
	public int emailAccept(String email,int emailflag){
		//update
		return 1;
	}
	
	@Override
	public int join(UserVO userdto){
		int result=session.insert("join", userdto);
		return result;
	}
	
	@Override
	public UserVO userLogin(String email){
		//List<UserVO> userlist=sqlMap.selectList("userLogin", email);
		UserVO userdto=new UserVO();
		/*if(userlist.size()==1){
			userdto=userlist.get(0);
		}	*/	
		return userdto;
	}
}
