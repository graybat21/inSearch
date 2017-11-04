package com.insearch.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.insearch.service.UserService;
import com.insearch.vo.UserVO;

@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Inject
	private UserService userService;
	
	@Inject
	BCryptPasswordEncoder passwordEncoder;

	@RequestMapping(value="/test", method = RequestMethod.GET)
	public ModelAndView checkDB(){
		ModelAndView mav = new ModelAndView();
		UserVO userVO= userService.selectList();
//		mav.addObject(userVO);
		mav.setViewName("user/check/check");
//		System.out.println(userVO.toString());
		return mav;
	}
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView index(){
		logger.info("인덱스 들어옴");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/index/title");
		return mav;
	}	
			
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView loginGo(){
		logger.info("로그인화면 들어옴");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/login/login");
		return mav;
	}	
//	
//	@RequestMapping(value="/logincheck", method=RequestMethod.GET)
//	public ModelAndView login(UserVO userVo){
//		System.out.println(userVo.getEmail()+" // "+userVo.getPwd());
//		ModelAndView mav = new ModelAndView();		
//		UserVO userLogin=userDao.userLogin(userVo.getEmail());
//		if(userLogin==null){
//			mav.addObject("msg","가입이 하지 않은 이메일 입니다.");
//		}else if(userVo.getPwd()!=userLogin.getPwd()){
//			mav.addObject("msg","비밀번호가 틀렸습니다.");
//		}else if(userLogin.getEmailflag()>0){
//			mav.addObject("msg","이메일 인증을 완료하지 않았습니다.");
//		}
//		mav.setViewName("Json");
//		return mav;
//	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public ModelAndView join(UserVO userVo){
		ModelAndView mav = new ModelAndView();
		
		String encryptPassword = passwordEncoder.encode(userVo.getPw());
		userVo.setPw(encryptPassword);
		
		logger.info(userVo.getId());
		
		//---- 추가 작업 예정  ----
		
//		int emailflag = (int)(Math.random()*8999+1000);		
//		userVo.setEmailflag(emailflag);
//		
//		int joinCheck=userService.join(userVo);	
//		System.out.println("joincheck"+joinCheck);
//		MailSend.sendEmail(userVo.getEmail(),emailflag);
//		mav.setViewName("user/emailready/emailready");				
		return mav;
	}
	
	@RequestMapping(value = "/duplicationCheck", method = RequestMethod.POST)
	@ResponseBody
	public int userExist(@RequestBody UserVO userVo) throws Exception {
		logger.info(userVo.getId());
		int isUserExist = userService.userExist(userVo);
		
		System.out.println(isUserExist);
		return isUserExist;
	}
	
	@RequestMapping("/emailCheck")
	public ModelAndView emailcheck(String email){
		ModelAndView mav = new ModelAndView();
		System.out.println("이메일 체크 들어옴 ");
		int emailCheck=userService.emailCheck(email);		
		if(emailCheck>0){
			mav.addObject("msg","이미 가입되어있는 이메일 입니다.");			
		}
		mav.setViewName("Json");
		return mav;
	}
	
//	@RequestMapping("/emailAccept.do")
//	public ModelAndView emailAccept(UserVO userVo){
//		
//		ModelAndView mav = new ModelAndView();		
//		int emailAccept=userDao.emailAccept(userVo.getEmail(),userVo.getEmailflag());
//		if(emailAccept>0){
//			mav.setViewName("emailaccept");
//			System.out.println("이메일 인증완료");
//		}else{
//			mav.setViewName("emailfail");
//			System.out.println("정상적이지 않은 경로로 인증 시도 ");
//		}
//		return mav;
//	}
}