package com.insearch.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.insearch.vo.User;

public interface UserDAO {

	public void insertUser(User user);

	public List<User> selectUsers();

	public User selectUser(String id);

}
