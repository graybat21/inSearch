package com.insearch.service;
//package com.insearch.controller;
//
//import static org.junit.Assert.assertEquals;
//import static org.junit.Assert.assertNotNull;
//import static org.junit.Assert.assertNull;
//
//import org.junit.FixMethodOrder;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.junit.runners.MethodSorters;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
//import org.springframework.test.annotation.Rollback;
//import org.springframework.test.context.junit4.SpringRunner;
//import org.springframework.transaction.annotation.Transactional;
//
//import lombok.extern.slf4j.Slf4j;
//
///**
// * @author C.H.Lee
// */
//@Transactional
//@Rollback
//@RunWith(SpringRunner.class)
//@SpringBootTest(classes = Application.class, webEnvironment = WebEnvironment.RANDOM_PORT)
//@Slf4j
//@FixMethodOrder(MethodSorters.NAME_ASCENDING)
//public class UserServiceTests {
//	@Autowired
//	private UserDAO userDAO;
//	@Autowired
//	private LogDAO logDAO;
//	@Autowired
//	private UserService userService;
//	
//	@Test
//	public void test01UserDAO() {
//		User user = new User();
//
//		// 1. insert test
//		String uuid = userService.createUuid();
//		userDAO.insertUser(uuid);
//		user.setUuid(uuid);
//		assertEquals("insert test", uuid, userDAO.selectUser(uuid).getUuid());
//		assertEquals("insert test", "en", userDAO.selectUser(uuid).getLanguage());
//
//		// 2. emergency, so update language only
//		user.setLanguage("ko");
//		userDAO.updateUser(user);
//		User user3 = userDAO.selectUser(uuid);
//		user3.setCreateDate(null);
//		user3.setLastAccessDate(null);
//		assertEquals("update test2", user, user3);
//
//		// 3. after emergency in use, gender, birthyear update test
//		user.setBirthyear("1960");
//		user.setGender(2);
//		userDAO.updateUser(user);
//		User user4 = userDAO.selectUser(uuid);
//		user4.setCreateDate(null);
//		user4.setLastAccessDate(null);
//		assertEquals("update test1", user, user4);
//
//		// 5. delete test
//		userDAO.deleteUser(uuid);
//		assertNull(userDAO.selectUser(uuid));
//	}
//
//	@Test
//	public void test02LogDAO(){
//		
//		// gender, birthyear 가 null일 경우 insert test
//		Log log1 = new Log();
//		log1.setUuid(userService.createUuid());
//		log1.setLng("111.11111111");
//		log1.setLat("11.11111111");
//		logDAO.insert(log1);
//		assertNotNull(log1.getIdx());
//		Log log2 = logDAO.selectIdx(log1.getIdx());
//		log2.setCreateDate(null);
//		log.info(log2.toString());
//		assertEquals(log1, log2);
//		
//		// gender, birthyear 가 notNull 일 경우 insert test
//		log1.setBirthyear("2000");
//		log1.setGender(1);
//		logDAO.insert(log1);
//		assertNotNull(log1.getIdx());
//		Log log3 = logDAO.selectIdx(log1.getIdx());
//		log3.setCreateDate(null);
//		log.info(log3.toString());
//		assertEquals(log1, log3);
//		
//		// deleteAll test
//		assertNotNull(logDAO.selectIdx(log2.getIdx()));
//		assertNotNull(logDAO.selectIdx(log3.getIdx()));
//		logDAO.deleteAll();
//		assertNull(logDAO.selectIdx(log2.getIdx()));
//		assertNull(logDAO.selectIdx(log3.getIdx()));
//	}
//}