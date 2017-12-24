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
	public int emailCheck(String email){
		int result = session.selectOne(namespace + ".emailCheck", email);		
		return result;
	}
	
	@Override
	public int emailAccept(String email,String emailflag){
		HashMap<String, String> map = new HashMap<>();
		map.put("email", email);
		map.put("emailflag", emailflag);
		
		System.out.println(map.get("email") + " // " + map.get("emailflag"));
		
		int result = session.update(namespace + ".emailAccept", map);
		return result;
	}
	
	@Override
	public int join(UserVO userVO){
		int result = session.insert(namespace + ".join", userVO);
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
	public void deleteUser(String email) {
		session.delete(namespace + ".deleteUser", email);
	}
	
	@Override
	public int getNo(String email) {
		return session.selectOne(namespace + ".getNo", email);
	}
	
	@Override
	public void updatePassword(HashMap<String, Object> map) {
		session.update(namespace + ".pwChange", map);		
	}

	@Override
	public int selectUserListCnt(HashMap<String, Object> map) {
		return session.selectOne(namespace + ".selectUserListCnt", map);
	}
	
	@Override
	public List<UserVO> selectUserList(HashMap<String, Object> map) {
		return session.selectList(namespace + ".selectUserList", map);
	}
}
