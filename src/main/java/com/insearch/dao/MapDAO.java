package com.insearch.dao;

import com.insearch.vo.EvaluationVO;
import com.insearch.vo.StoreVO;

public interface MapDAO {
	public int getStoreNo(StoreVO storeVo) throws Exception;
	public void registerStore(StoreVO storeVo) throws Exception;
	public void registerComment(EvaluationVO evaluationVo) throws Exception;
}
