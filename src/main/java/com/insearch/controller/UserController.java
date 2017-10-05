package com.insearch.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.insearch.common.ResponseBuilder;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/users")
@ComponentScan
public class UserController {

	@GetMapping
	@ApiOperation(value = "get user list")
	public void readUsers(HttpServletResponse response) {

		new ResponseBuilder(response).build().flush();
	}
}
