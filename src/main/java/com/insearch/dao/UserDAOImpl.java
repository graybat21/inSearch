package com.insearch.dao;

import java.util.HashMap;
import java.util.List;

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

	public int emailCheck(String email){
		int result=session.selectOne("emailCheck",email);		
		return result;
	}
	
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
		return result;
	}
	
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
