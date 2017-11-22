package com.insearch.service;

import java.util.HashMap;
import java.util.List;

import com.insearch.vo.EvaluationVO;
import com.insearch.vo.StoreVO;

public interface MapService {
	public int getStoreNo(StoreVO storeVo) throws Exception;
	public void registerStore(StoreVO storeVo) throws Exception;
	public void registerComment(EvaluationVO evaluationVo) throws Exception;
	public int selectCommentCnt(int store_no) throws Exception;
	public List<HashMap<String, Object>> selectCommentList(HashMap<String, Object> commentMap);
}
