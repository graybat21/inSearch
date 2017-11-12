package com.insearch.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
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

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public ModelAndView checkDB() {
		ModelAndView mav = new ModelAndView();
		UserVO userVO = userService.selectList();
		mav.addObject(userVO);
		mav.setViewName("user/check/check");
		System.out.println(userVO.toString());
		return mav;
	}

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView index() {
		System.out.println("인덱스 들어옴");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/index/title");
		return mav;
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginGo() {
		System.out.println("로그인화면 들어옴");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/login/login");
		return mav;
	}

	//
	// @RequestMapping(value="/logincheck", method=RequestMethod.GET)
	// public ModelAndView login(UserVO userdto){
	// System.out.println(userdto.getEmail()+" // "+userdto.getPwd());
	// ModelAndView mav = new ModelAndView();
	// UserVO userLogin=userDao.userLogin(userdto.getEmail());
	// if(userLogin==null){
	// mav.addObject("msg","가입이 하지 않은 이메일 입니다.");
	// }else if(userdto.getPwd()!=userLogin.getPwd()){
	// mav.addObject("msg","비밀번호가 틀렸습니다.");
	// }else if(userLogin.getEmailflag()>0){
	// mav.addObject("msg","이메일 인증을 완료하지 않았습니다.");
	// }
	// mav.setViewName("Json");
	// return mav;
	// }
	//
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public ModelAndView join(HttpServletRequest req, UserVO userdto) {
		System.out.println(userdto.getEmail() + " // " + userdto.getPw() + " // " + userdto.getGender() + " // "
				+ userdto.getAgerange());
		ModelAndView mav = new ModelAndView();

		String emailflag = getUUID();
		userdto.setEmailflag(emailflag);

		int joinCheck = userService.join(userdto);
		System.out.println(emailflag);
		System.out.println("joincheck" + joinCheck);
		String getHost = req.getRequestURL().toString();
		getHost = getHost.replaceAll("/join", "");
		System.out.println("getHost : " + getHost);
		MailSend.send_Email(userdto.getEmail(), emailflag, getHost);
		mav.setViewName("user/emailready/emailready");
		return mav;
	}

	//
	@RequestMapping(value = "/email", method = RequestMethod.GET)
	public ModelAndView emailcheck(@RequestParam String email) {
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
	public ModelAndView emailAccept(@RequestParam String email, @RequestParam String emailflag) {

		ModelAndView mav = new ModelAndView();
		int emailAccept = userService.emailAccept(email, emailflag);
		if (emailAccept > 0) {
			mav.setViewName("user/emailaccept/이메일 인증완료");
			System.out.println("이메일 인증완료");
		} else {
			mav.setViewName("user/emailfail/이메일 인증실패");
			System.out.println("정상적이지 않은 경로로 인증 시도 ");
		}
		return mav;
	}
	
	private String getUUID() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

}