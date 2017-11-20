package com.insearch.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();

		if ( session.getAttribute("email") == null ) {
			logger.info("current user is not logined");
			
			String oldUrl = request.getHeader("referer");		// 이전 페이지 주소값
			
			session.setAttribute("dest", oldUrl);
			
			response.sendRedirect("/login");
			return false;
		}
		return true;
	}
}
