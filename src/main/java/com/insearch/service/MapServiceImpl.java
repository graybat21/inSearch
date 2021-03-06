package com.insearch.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.insearch.dao.MapDAO;
import com.insearch.vo.EvaluationVO;
import com.insearch.vo.StoreVO;

@Service
public class MapServiceImpl implements MapService {
	
	@Inject
	private MapDAO mapDao;
	
	@Override
	public int getStoreNo(StoreVO storeVo) throws Exception {
		return mapDao.getStoreNo(storeVo);
	}

	@Override
	public void registerStore(StoreVO storeVo) throws Exception {
		mapDao.registerStore(storeVo);
	}

	@Override
	public void registerComment(EvaluationVO evaluationVo) throws Exception {
		mapDao.registerComment(evaluationVo);
	}

	@Override
	public int selectCommentCnt(HashMap<String, Object> map) throws Exception {
		return mapDao.selectCommentCnt(map);
	}
	
	@Override
	public double selectAvgStar(int store_no) throws Exception {
		return mapDao.selectAvgStar(store_no);
	}
	
	@Override
	public int selectStoreListCnt(HashMap<String, Object> map) throws Exception {
		return mapDao.selectStoreListCnt(map);
	}
	
	@Override
	public StoreVO selectOneStore(int store_no) throws Exception {
		return mapDao.selectOneStore(store_no);
	}
	
	@Override
	public List<StoreVO> selectStoreList(HashMap<String, Object> map) throws Exception {
		return mapDao.selectStoreList(map);
	}
	
	@Override
	public List<HashMap<String, Object>> selectCommentList(HashMap<String, Object> commentMap) throws Exception {
		return mapDao.selectCommentList(commentMap);
	}
	
	@Override
	public void deleteComment(int evaluation_no) throws Exception {
		mapDao.deleteComment(evaluation_no);
	}
}
