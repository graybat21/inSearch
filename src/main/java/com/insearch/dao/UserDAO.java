package com.insearch.dao;

import com.insearch.vo.UserVO;

public interface UserDAO {
	public int emailCheck(String email);
<<<<<<< HEAD:src/main/java/com/insearch/dao/userDAO.java
	public int emailAccept(String email,String emailflag);
	public int join(UserVO userVO);
=======
	public int userExist(UserVO userVo);
	public int emailAccept(String email,int emailflag);
	public int join(UserVO userdto);
>>>>>>> 84b08fbc3305f2b322a259479bc3868122e56b2a:src/main/java/com/insearch/dao/UserDAO.java
	public UserVO userLogin(String email);
	public UserVO selectList();	     
	public int memberSecession(String email);
	public int pwChange(String email,String passwordSecret);
}
