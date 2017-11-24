package com.insearch.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.insearch.config.PageMaker;
import com.insearch.service.MapService;
import com.insearch.service.UserService;
import com.insearch.vo.EvaluationVO;
import com.insearch.vo.StoreVO;

@RestController
@RequestMapping("/comment")
public class CommentController {
	
	private static final Logger logger = LoggerFactory.getLogger(CommentController.class);
	
	@Inject
	private MapService mapService;
	
	@RequestMapping(value = "registerStore", method = RequestMethod.POST) 
	public ResponseEntity<?> registerStore(@RequestBody StoreVO storeVo) {
		ResponseEntity<?> entity = null;
		
		int no;
		
		try {
			mapService.registerStore(storeVo);
			no = mapService.getStoreNo(storeVo);
			
			entity = new ResponseEntity<Integer>(no, HttpStatus.OK);
		}
		catch ( Exception e ) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "registerComment", method = RequestMethod.POST) 
	public ResponseEntity<String> registerComment(@RequestBody EvaluationVO evaluationVo) {
		ResponseEntity<String> entity = null;
		
		try {
			mapService.registerComment(evaluationVo);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}
		catch ( Exception e ) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{store_no}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(
			@PathVariable("store_no") Integer store_no, @PathVariable("page") Integer page) {
		ResponseEntity<Map<String, Object>> entity = null;
		
		try
		{
			PageMaker pageMaker = new PageMaker();
			
			int pagecnt = 5;		// 상세페이지를 로드할 때, 가장 최근에 작성한 다섯개의 리뷰만 보여지도록 함.
			int countPerPaging = 10;
			int start = (page - 1) * pagecnt;
			
			pageMaker.setPage(page);

			int totalCommentCnt = mapService.selectCommentCnt(store_no);
			double avgStar = mapService.selectAvgStar(store_no);
			
			logger.info("totalCommentCnt = " + totalCommentCnt);
			logger.info("avgStar = " + avgStar);
			pageMaker.setCount(totalCommentCnt, pagecnt, countPerPaging);
			
			HashMap<String, Object> commentMap = new HashMap<>();
			
			commentMap.put("store_no", store_no);
			commentMap.put("start", start);
			commentMap.put("pagecnt", pagecnt);
			
			List<HashMap<String, Object>> commentList = mapService.selectCommentList(commentMap);
			
			commentMap.put("commentList", commentList);
			commentMap.put("totalCommentCnt", totalCommentCnt);
			commentMap.put("avgStar", avgStar);
			commentMap.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<Map<String, Object>>(commentMap, HttpStatus.OK);
		}
		catch ( Exception e )
		{
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
