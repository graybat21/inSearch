package com.insearch.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import io.swagger.annotations.Api;

/**
 * Handles requests for the application home page.
 */

@Controller
@Api(value="swagger", description="swagger-test")
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public String home() {
//		return "home";
//	}
	
	@RequestMapping(value="/swagger", method = RequestMethod.GET)
	public String homePost(){
		return "redirect:/swagger-ui.html";
	}

}
