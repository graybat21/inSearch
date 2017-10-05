//package com.insearch.common;
//
//import java.lang.annotation.Annotation;
//
//import org.aspectj.lang.ProceedingJoinPoint;
//import org.aspectj.lang.SoftException;
//import org.aspectj.lang.annotation.Around;
//import org.aspectj.lang.annotation.Aspect;
//import org.aspectj.lang.annotation.Pointcut;
//import org.aspectj.lang.reflect.MethodSignature;
//import org.springframework.stereotype.Component;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Component
//@Aspect
//@Slf4j
//public class LoggerAspect {
//	private String name = "";
//	private String type = "";
//
//	@Pointcut(value = "execution(* com.chorocksoft.ymjm.apigateway.restful..*Controller.*(..))")
//	private void ctrlPointCut() {
//	}
//	@Pointcut(value = "execution(* com.chorocksoft.ymjm.apigateway.restful..*Dao.*(..))")
//	private void daoPointCut() {
//	}
//	@Pointcut(value = "execution(* com.chorocksoft.ymjm.apigateway.restful..*Service.*(..))")
//	private void servicePointCut() {
//	}
//
//	@Around("ctrlPointCut() || daoPointCut() || servicePointCut()")
//	public Object logPrint(ProceedingJoinPoint joinPoint) throws Throwable {
//		type = joinPoint.getSignature().getDeclaringTypeName();
//
//		if (type.indexOf("Controller") > -1) {
//			name = "Controller  \t:  ";
//		} else if (type.indexOf("Service") > -1) {
//			name = "Service  \t:  ";
//		} else if (type.indexOf("DAO") > -1) {
//			name = "DAO  \t\t:  ";
//		}
//		log.info(name + type + "." + joinPoint.getSignature().getName() + "()");
//		return joinPoint.proceed();
//	}
//
//}