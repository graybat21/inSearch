package com.insearch.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.insearch.vo.EvaluationVO;
import com.insearch.vo.StoreVO;

@Repository
public class MapDAOImpl implements MapDAO {
	
	private static String namespace = "com.insearch.mappers.mapMapper";
	
	@Inject
	private SqlSession session;
	
	@Override
	public int getStoreNo(StoreVO storeVo) throws Exception {
		return session.selectOne(namespace + ".getStoreNo", storeVo);
	}

	@Override
	public void registerStore(StoreVO storeVo) throws Exception {
		session.insert(namespace + ".registerStore", storeVo);
	}

	@Override
	public void registerComment(EvaluationVO evaluationVo) throws Exception {
		session.insert(namespace + ".registerComment", evaluationVo);
	}
}
