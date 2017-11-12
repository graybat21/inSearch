package com.insearch.controller;

import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.net.URI;
import java.net.URL;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.client.RestTemplate;

import com.insearch.vo.UserVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations ={ "file:src/main/webapp/WEB-INF/spring/appServlet/test-context.xml"})
public class UserControllerTest {

//	@Autowired
//	private RestTemplate restTemplate;
	
	@Test
	public void userTest1() {
		RestTemplate restTemplate = new RestTemplate();
		// userTable CRUD test
		String testEmail = "insearch4aws@gmail.com";
		String testPw = "insearch11";
		int testAgerange = 1;
		int testGender = 1;
		String testEmailflag = "aaaaaaaaaaaaaaaaaaaaaa";
		UserVO userVO = new UserVO();
		userVO.setEmail(testEmail);
		userVO.setPw(testPw);
		userVO.setAgerange(testAgerange);
		userVO.setGender(testGender);
		userVO.setEmailflag(testEmailflag);
		
//		RequestEntity<UserVO> reqEntity1 = RequestEntity.post(URI.create("/join")).accept(MediaType.APPLICATION_JSON).body(userVO);			
		RequestEntity<UserVO> reqEntity1 = RequestEntity.post(URI.create("http://localhost:8080/join")).accept(MediaType.ALL).body(userVO);			
		ResponseEntity<String> resEntity1 = restTemplate.exchange(reqEntity1, String.class);
		
		
//		ResponseEntity<String> entity = restTemplate.postForEntity("http://localhost:8080/join", userVO, String.class);
//		ResponseEntity<String> entity = restTemplate.exchange("http://localhost:8080/join", userVO, String.class);
		assertEquals(HttpStatus.OK, resEntity1.getStatusCode());
	}
}


