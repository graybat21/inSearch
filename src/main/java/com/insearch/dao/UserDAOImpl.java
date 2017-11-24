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

	@Override
	public int emailCheck(String email){
		int result=session.selectOne("emailCheck",email);		
		return result;
	}
	
	@Override
	public int emailAccept(String email,String emailflag){
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("email",email);
		map.put("emailflag",emailflag);		
		System.out.println(map.get("email")+" // "+map.get("emailflag"));
		int result=session.update("emailAccept",map);
		System.out.println(result);
		return result;
	}
	
	@Override
	public int join(UserVO userVO){
		int result=session.insert("join", userVO);
		return result;
	}
	
	@Override
	public void update(UserVO userVO) {
		session.update(namespace + ".update", userVO);
	}
	
	@Override
	public UserVO selectOneUser(String email){
		return session.selectOne(namespace + ".selectOneUser", email);
	}
	
	@Override
	public int memberSecession(String email){
		int result = session.delete("memberSecession",email);
		return result;
	}
	
	@Override
	public int pwChange(String email,String pw){
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("email",email);
		map.put("pw", pw);
		int result=session.update("pwChange",map);		
		return result;
	}

	@Override
	public int selectListCnt(HashMap<String, Object> map) {
		return session.selectOne(namespace + ".selectListCnt", map);
	}
	
	@Override
	public List<UserVO> userList(HashMap<String, Object> map) {
		return session.selectList(namespace + ".userList", map);
	}
}
