package com.insearch.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.insearch.config.MailSend;
import com.insearch.service.UserService;
import com.insearch.vo.UserVO;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;	
	

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView index() {
		System.out.println("인덱스 들어옴");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/index/title");
		return mav;
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginGo(HttpServletRequest request,HttpSession session) {
		System.out.println("로그인화면 들어옴");
		ModelAndView mav = new ModelAndView();
		
		Cookie[] cks = request.getCookies();
		int autologin_check=0;
		String autologin_email;
		if(cks!=null){
			for(int i=0;i<cks.length;i++){
				if("insearch".equals(cks[i].getName())){
					autologin_check++;
					autologin_email=cks[i].getValue();
					System.out.println(autologin_email+" 자동로그인 함 ");
					session.setAttribute("email", autologin_email);
					break;
				}			
			}	 
		}
		if(autologin_check==0){
			mav.setViewName("user/login/login");
		}else{
			mav.setViewName("user/searchmap/searchmap");
		}
		return mav;
	}

	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		System.out.println("로그아웃");
		ModelAndView mav = new ModelAndView();
		
		Cookie[] cks = request.getCookies();
		if(cks!=null){
			for(int i=0;i<cks.length;i++){
				if("insearch".equals(cks[i].getName())){
					cks[i].setMaxAge(0);
					response.addCookie(cks[i]);
					break;
				}			
			}	 
		}
		session.removeAttribute("email");
		mav.setViewName("user/login/login");
		return mav;
	}
	
	
	
	
	@RequestMapping(value = "/searchmap", method = RequestMethod.GET)
	public ModelAndView searchmap() {
		System.out.println("로그인 완료 써치맵 이동 ");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/searchmap/searchmap");
		return mav;
	}
	
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(UserVO userdto,boolean autologin,HttpServletRequest request,HttpServletResponse response,HttpSession session) {
		System.out.println("로그인 실행 전 자동로그인 체크 : "+autologin);
		System.out.println(userdto.getEmail() + " // " + userdto.getPw());
		ModelAndView mav = new ModelAndView();
		
		UserVO userLogin = userService.userLogin(userdto.getEmail());
		
		if (userLogin.getEmail() == null) {
			mav.addObject("msg", "가입이 하지 않은 이메일 입니다.");
		} else if (!bcryptPasswordEncoder.matches(userdto.getPw(), userLogin.getPw())){
			mav.addObject("msg", "비밀번호가 틀렸습니다.");
		} else if (!userLogin.getEmailflag().equals("y")) {
			mav.addObject("msg", "이메일 인증을 완료하지 않았습니다.");
		}else{
			session.setAttribute("email", userdto.getEmail());
		}
	
		if(autologin){			
			Cookie[] cks = request.getCookies();
			int autologin_check=0;
			if(cks!=null){
				for(int i=0;i<cks.length;i++){
					if("insearch".equals(cks[i].getName())){
						autologin_check++;
						break;
					}			
				}	 
				if(autologin_check==0){
					Cookie ck1=new Cookie("insearch",userdto.getEmail());
				 	ck1.setMaxAge(60*60*24*30);
				 	response.addCookie(ck1);
				}
			}			 	
			
		}
		
		mav.setViewName("Json");
		return mav;
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public ModelAndView join(UserVO userdto) {
		System.out.println(userdto.getEmail() + " // " + userdto.getPw() + " // " + userdto.getGender() + " // "
				+ userdto.getAgerange());
		ModelAndView mav = new ModelAndView();
		
		String random="abcdefghijklmnopqrstuvwxyz0123456789";
		
		String emailflag="";
		for(int i=0;i<8;i++){
			int randomnum=(int)(Math.random()*random.length());
			emailflag+=random.substring(randomnum, randomnum+1);
		}
		System.out.println("emailflag"+emailflag);
		userdto.setEmailflag(emailflag);
		
		String pwd=userdto.getPw();
		System.out.println("패스워드 암호화 전"+pwd);
		
		String passwordSecret=bcryptPasswordEncoder.encode(pwd);			
		System.out.println("패스워드 암호화 확인1"+passwordSecret);
		
		userdto.setPw(passwordSecret);		
		
		int joinCheck = userService.join(userdto);
		
		System.out.println(emailflag);
		System.out.println("joincheck" + joinCheck);
		String content = "<a href='http://localhost:8080/emailAccept?email="+userdto.getEmail()+"&emailflag=" + emailflag+"'>이 곳을 클릭하면 인증이 완료 됩니다.</a>";
		MailSend.send_Email(userdto.getEmail(),content);
		
		mav.setViewName("user/emailready/emailready");
		return mav;
	}

	
	@RequestMapping(value = "/email", method = RequestMethod.GET)
	public ModelAndView emailCheck(@RequestParam String email) {
		ModelAndView mav = new ModelAndView();
		System.out.println("이메일 체크 들어옴 ");
		int emailCheck = userService.emailCheck(email);
		if (emailCheck > 0) {
			mav.addObject("msg", "이미 가입되어있는 이메일 입니다.");
		}
		mav.setViewName("Json");
		return mav;
	}

	@RequestMapping(value = "/emailAccept", method = RequestMethod.GET)
	public ModelAndView emailAccept(UserVO userdto) {
		System.out.println("이메일 인증 들어옴 ");
		System.out.println(userdto.getEmail()+" // "+ userdto.getEmailflag());
		ModelAndView mav = new ModelAndView();
		int emailAccept = userService.emailAccept(userdto.getEmail(), userdto.getEmailflag());
		if (emailAccept > 0) {
			mav.setViewName("user/emailaccept/emailaccept");
			System.out.println("이메일 인증완료");
		} else {
			mav.setViewName("user/emailfail/emailfail");
			System.out.println("정상적이지 않은 경로로 인증 시도 ");
		}
		return mav;
	}
	
	@RequestMapping(value="/pwChange_emailCheck",method =RequestMethod.GET)
	public ModelAndView emailSend_emailCheck(String email){
		System.out.println("비밀번호 변경 전 이메일체크 들어옴");
		ModelAndView mav = new ModelAndView();	
		UserVO userLogin = userService.userLogin(email);
		if (userLogin.getEmail() == null) {
			mav.addObject("msg", "이메일을 잘못 입력하셨습니다.");
		}
		mav.setViewName("Json");
		return mav;		
	}
	@RequestMapping(value="/pwChange",method =RequestMethod.GET)
	public ModelAndView emailSend(String email,HttpSession session){
		System.out.println("비밀번호 변경페이지로 이동 ");
		ModelAndView mav = new ModelAndView();	
		session.setAttribute("email_pwchange", email);
		
		mav.setViewName("user/pwchange/pwchange");
		return mav;	
	}
	
	@RequestMapping(value="/pwChange",method=RequestMethod.POST)
	public ModelAndView pwdChange(HttpSession session,String pw){
		System.out.println("비밀번호 변경 들어옴");
		ModelAndView mav = new ModelAndView();	
		String email=(String) session.getAttribute("email_pwchange");
		System.out.println(email+" // "+pw);
		String passwordSecret=bcryptPasswordEncoder.encode(pw);
		int result=userService.pwChange(email,passwordSecret);
		if(result>0){
			System.out.println("비밀번호 변경 성공");
		}
		
		mav.setViewName("user/login/login");
		return mav;	
	}
	
	
	@RequestMapping(value="/memberSecession", method=RequestMethod.GET)
	public ModelAndView memberSecession(HttpSession session){
		ModelAndView mav=new ModelAndView();
		String email=(String)session.getAttribute("email");
		int result=userService.memberSecession(email);
		if(result>0){
			System.out.println("회원탈퇴 성공");
		}else{
			System.out.println("회원탈퇴 실패");
		}
		mav.setViewName("user/login/login");
		return mav;
	}	
}