package com.insearch.service;

import com.insearch.vo.EvaluationVO;
import com.insearch.vo.StoreVO;

public interface MapService {
	public int getStoreNo(StoreVO storeVo) throws Exception;
	public void registerStore(StoreVO storeVo) throws Exception;
	public void registerComment(EvaluationVO evaluationVo) throws Exception;
}
