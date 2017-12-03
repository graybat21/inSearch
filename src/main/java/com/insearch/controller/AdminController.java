package com.insearch.controller;

import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.insearch.config.PageMaker;
import com.insearch.service.MapService;
import com.insearch.service.UserService;
import com.insearch.vo.EvaluationVO;
import com.insearch.vo.StoreVO;
import com.insearch.vo.UserVO;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	private UserService userService;
	
	@Inject
	private MapService mapService;
	
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
		
		int totalCnt = userService.selectUserListCnt(map); 

		int countPerPage = 3;
		int countPerPaging = 3;

		int first = ((pageMaker.getPage() - 1) * countPerPage) + 1;
		int last = first + countPerPage - 1;
		map.put("first", first);
		map.put("last", last);
		
		List<UserVO> list = userService.selectUserList(map);
		pageMaker.setCount(totalCnt, countPerPage, countPerPaging);
		mav.addObject("userList", list);
		mav.addObject("pageMaker", pageMaker);
		
		mav.setViewName("user/userList");

		logger.info(list.toString());
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteUser", method = RequestMethod.POST)
	public ResponseEntity<String> deleteUser(@RequestBody UserVO userdto) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		try 
		{
			String email = userdto.getEmail();
			logger.info("DELETE TO E-mail = " + email);
			userService.deleteUser(email);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}
		catch ( Exception e ) 
		{
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "storeList", method = RequestMethod.GET)
	public ModelAndView storeList(PageMaker pageMaker, 
			@RequestParam(value = "q", required = false) String query) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> map = new HashMap<>();
		int page = ( pageMaker.getPage() != null ) ? pageMaker.getPage() : 1;
		pageMaker.setPage(page);	
		
		if ( query != null ) {		// 장소 검색어가 존재하는 경우
			String[] searchKeywordArr = query.split("=");
			String searchStoreKeyword = searchKeywordArr[1];
			map.put("searchStoreKeyword", searchStoreKeyword);
			mav.addObject("searchStoreKeyword", searchStoreKeyword);
		}
		
		int totalCnt = mapService.selectStoreListCnt(map); 

		int countPerPage = 10;
		int countPerPaging = 10;

		int first = ((pageMaker.getPage() - 1) * countPerPage) + 1;
		int last = first + countPerPage - 1;
		map.put("first", first);
		map.put("last", last);
		
		List<StoreVO> list = mapService.selectStoreList(map);
		pageMaker.setCount(totalCnt, countPerPage, countPerPaging);
		mav.addObject("storeList", list);
		mav.addObject("pageMaker", pageMaker);
		
		mav.setViewName("store/storeList");

		logger.info(list.toString());
		return mav;
	}
	
	@RequestMapping(value = "comments/store_no/{store_no}", method = RequestMethod.GET)
	public ModelAndView commentList(PageMaker pageMaker, @PathVariable int store_no,
			@RequestParam(value = "q", required = false) String query) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		StoreVO storeVo = mapService.selectOneStore(store_no);
		double avgStar = mapService.selectAvgStar(store_no);
		
		mav.addObject("store_no", store_no);
		mav.addObject("storeVo", storeVo);
		mav.addObject("avgStar", avgStar);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("store_no", store_no);	
		
		if ( query != null ) {		// 한줄평 검색어가 존재하는 경우
			String pattern = "type=(comment|email),keyword=(.*)";
			Pattern r = Pattern.compile(pattern);
			Matcher m = r.matcher(query);

			m.find();
			String searchType = m.group(1);
			String searchKeyword = m.group(2);
			
			map.put("searchType", searchType);
			map.put("searchKeyword", searchKeyword);
			mav.addObject("searchType", searchType);
			mav.addObject("searchKeyword", searchKeyword);
		}
		
		int totalCnt = mapService.selectCommentCnt(map); 
		
		int page = ( pageMaker.getPage() != null ) ? pageMaker.getPage() : 1;
		pageMaker.setPage(page);

		int pagecnt = 5;
		int countPerPaging = 10;
		int start = (page - 1) * pagecnt;

		map.put("start", start);
		map.put("pagecnt", pagecnt);
		
		List<HashMap<String, Object>> list = mapService.selectCommentList(map);
		pageMaker.setCount(totalCnt, pagecnt, countPerPaging);
		mav.addObject("commentList", list);
		mav.addObject("pageMaker", pageMaker);
		
		mav.setViewName("store/storeDetail");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteComment", method = RequestMethod.POST)
	public ResponseEntity<String> deleteComment(@RequestBody EvaluationVO evaluationdto) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		try 
		{
			int evaluationNo = evaluationdto.getNo();
			mapService.deleteComment(evaluationNo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}
		catch ( Exception e ) 
		{
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
