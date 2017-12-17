package com.insearch.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class CommonExceptionAdvice 
{
	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);
	
	@ExceptionHandler(Exception.class)
	public ModelAndView errorModelAndView(Exception e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorCommon/Error");
		
		logger.error("ERROR!!!", e);		// 콘솔창에 예외 메시지, 예외 발생경로를 띄움.
		return mav;
	}
	
}
