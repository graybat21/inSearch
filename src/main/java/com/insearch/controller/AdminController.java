package com.insearch.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.insearch.config.PageMaker;
import com.insearch.service.UserService;
import com.insearch.vo.UserVO;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	private UserService userService;
	
	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String mainForm() {
		return "main/base";
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String loginForm() {
		return "login/loginAdmin";
	}

	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout() {
		return "login/logoutAdmin";
	}
	
	@RequestMapping(value = "userList", method = RequestMethod.GET)
	public ModelAndView userList(PageMaker pageMaker, 
			@RequestParam(value = "q", required = false) String query) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> map = new HashMap<>();
		int page = ( pageMaker.getPage() != null ) ? pageMaker.getPage() : 1;
		pageMaker.setPage(page);	
		
		if ( query != null ) {		// E-mail 검색어가 존재하는 경우
			String[] searchKeywordArr = query.split("=");
			String searchEmailKeyword = searchKeywordArr[1];
			map.put("searchEmailKeyword", searchEmailKeyword);
			mav.addObject("searchEmailKeyword", searchEmailKeyword);
		}
		
		int totalCnt = userService.selectListCnt(map); 

		int countPerPage = 3;
		int countPerPaging = 3;

		int first = ((pageMaker.getPage() - 1) * countPerPage) + 1;
		int last = first + countPerPage - 1;
		map.put("first", first);
		map.put("last", last);
		
		List<UserVO> list = userService.userList(map);
		pageMaker.setCount(totalCnt, countPerPage, countPerPaging);
		mav.addObject("userList", list);
		mav.addObject("pageMaker", pageMaker);
		
		mav.setViewName("user/userList");

		logger.info(list.toString());
		return mav;
	}
	
	
}
