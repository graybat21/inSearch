package com.insearch.service;

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

}
