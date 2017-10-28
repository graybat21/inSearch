package com.insearch.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class UserController {
	
/*	@Autowired
	private UserService userService;*/

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView index(){
		System.out.println("인덱스 들어옴");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/index/title");
		return mav;
	}	
			
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView loginGo(){
		System.out.println("로그인화면 들어옴");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/login/login");
		return mav;
	}	
//	
//	@RequestMapping(value="/logincheck", method=RequestMethod.GET)
//	public ModelAndView login(UserVO userdto){
//		System.out.println(userdto.getEmail()+" // "+userdto.getPwd());
//		ModelAndView mav = new ModelAndView();		
//		UserVO userLogin=userDao.userLogin(userdto.getEmail());
//		if(userLogin==null){
//			mav.addObject("msg","가입이 하지 않은 이메일 입니다.");
//		}else if(userdto.getPwd()!=userLogin.getPwd()){
//			mav.addObject("msg","비밀번호가 틀렸습니다.");
//		}else if(userLogin.getEmailflag()>0){
//			mav.addObject("msg","이메일 인증을 완료하지 않았습니다.");
//		}
//		mav.setViewName("Json");
//		return mav;
//	}
//	
//	@RequestMapping("/join.do")
//	public ModelAndView join(UserVO userdto){
//		System.out.println(userdto.getEmail()+" // "+userdto.getPwd()+" // "+userdto.getGender()+" // "+userdto.getAgerange());
//		ModelAndView mav = new ModelAndView();
//		
//		int emailflag = (int)(Math.random()*9999+1000);		
//		userdto.setEmailflag(emailflag);
//		
//		int joinCheck=userDao.join(userdto);	
//		mailSend.send_Email(userdto.getEmail(),emailflag);
//		mav.setViewName("emailready");				
//		return mav;
//	}
//	
//	@RequestMapping("/emailCheck.do")
//	public ModelAndView emailcheck(String email){
//		ModelAndView mav = new ModelAndView();
//		System.out.println("이메일 체크 들어옴 ");
//		int emailCheck=userDao.emailCheck(email);		
//		if(emailCheck>0){
//			mav.addObject("msg","이미 가입되어있는 이메일 입니다.");			
//		}
//		mav.setViewName("Json");
//		return mav;
//	}
//	
//	@RequestMapping("/emailAccept.do")
//	public ModelAndView emailAccept(UserVO userdto){
//		
//		ModelAndView mav = new ModelAndView();		
//		int emailAccept=userDao.emailAccept(userdto.getEmail(),userdto.getEmailflag());
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