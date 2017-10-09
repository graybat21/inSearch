package com.insearch.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.insearch.dao.UserDAO;
import com.insearch.vo.User;

@Service
public class UserService {

	@Autowired
	private UserDAO userDAO;
	
	public void insertUser(User user) {
		userDAO.insertUser(user);
	}

	public List<User> selectUsers() {
		return userDAO.selectUsers();
	}

	public User selectUser(String id) {
		return userDAO.selectUser(id);
	}

}
