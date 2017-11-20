package com.insearch.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();

		if ( session.getAttribute("email") != null ) {
			logger.info("clear login data before");
			session.removeAttribute("email");
			return false;
		}
		
		return true;
	}
	
	
}
