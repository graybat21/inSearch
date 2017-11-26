package com.insearch.dao;

import java.util.HashMap;
import java.util.List;

import com.insearch.vo.EvaluationVO;
import com.insearch.vo.StoreVO;

public interface MapDAO {
	public int getStoreNo(StoreVO storeVo) throws Exception;
	public void registerStore(StoreVO storeVo) throws Exception;
	public void registerComment(EvaluationVO evaluationVo) throws Exception;
	public void deleteCommentByEmail(int user_no) throws Exception;
	public int selectCommentCnt(HashMap<String, Object> map) throws Exception;
	public double selectAvgStar(int store_no) throws Exception;
	public int selectStoreListCnt(HashMap<String, Object> map) throws Exception;
	public StoreVO selectOneStore(int store_no) throws Exception;
	public List<StoreVO> selectStoreList(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectCommentList(HashMap<String, Object> commentMap) throws Exception;
	public void deleteComment(int evaluation_no) throws Exception;
}
