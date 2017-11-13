package com.insearch.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
<<<<<<< HEAD:src/main/java/com/insearch/service/userDAOImple.java
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
=======
import org.springframework.stereotype.Repository;
>>>>>>> 84b08fbc3305f2b322a259479bc3868122e56b2a:src/main/java/com/insearch/dao/UserDAOImpl.java

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
	
<<<<<<< HEAD:src/main/java/com/insearch/service/userDAOImple.java
	public int emailAccept(String email,String emailflag){
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("email",email);
		map.put("emailflag",emailflag);		
		System.out.println(map.get("email")+" // "+map.get("emailflag"));
		int result=session.update("emailAccept",map);
		System.out.println(result);
		return result;
	}
	
	
	public int join(UserVO userVO){
		int result=session.insert("join", userVO);
=======
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
>>>>>>> 84b08fbc3305f2b322a259479bc3868122e56b2a:src/main/java/com/insearch/dao/UserDAOImpl.java
		return result;
	}
	
	@Override
	public UserVO userLogin(String email){
		List<UserVO> userlist=session.selectList("userLogin", email);
		UserVO userdto=new UserVO();
		if(userlist.size()==1){
			userdto=userlist.get(0);
		}
		return userdto;
	}
	
	public int memberSecession(String email){
		int result = session.delete("memberSecession",email);
		return result;
	}
	
	public int pwChange(String email,String pw){
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("email",email);
		map.put("pw", pw);
		int result=session.update("pwChange",map);		
		return result;
	}
}
