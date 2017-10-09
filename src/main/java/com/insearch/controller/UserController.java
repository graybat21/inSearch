package com.insearch.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.insearch.service.UserService;
import com.insearch.vo.User;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/users")
@ComponentScan
public class UserController {

	@Autowired
	private UserService userService;

	@GetMapping
	@ApiOperation(value = "get users list")
	public ModelAndView readUsers() {
		ModelAndView mav = new ModelAndView();
		HashMap<String, String> map = new HashMap<>();

		List<User> list = userService.selectUsers();
		mav.setViewName("UserList");
		mav.addObject("userList", list);
		return mav;
	}
	
//	@PostMapping
//	@ApiOperation(value = "insert user")
//	public String createUser(@RequestBody User user) {
//		userService.insertUser(user);
//		return "redirect:/";
//	}

	@GetMapping("/{id}")
	@ApiOperation(value = "get user")
	public ModelAndView readUser(@PathVariable String id) {
		ModelAndView mav = new ModelAndView();
		
		User user = userService.selectUser(id);
		mav.setViewName("UserInfo");
		mav.addObject("user", user);
		return mav;
	}
}
