//package com.insearch.common;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//
//import lombok.extern.slf4j.Slf4j;
//@Slf4j
//@Component
//public class LoggerInterceptor extends HandlerInterceptorAdapter {
//	
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {		
//		
//		if (log.isDebugEnabled()) {
//			log.debug(
//					"======================================          START         ======================================");
//			log.debug(" Request URI \t:  " + request.getRequestURI());
//		}
//		return super.preHandle(request, response, handler);
//	}
//
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		if (log.isDebugEnabled()) {
//			log.debug(
//					"======================================           END          ======================================\n");
//		}
//	}
//}