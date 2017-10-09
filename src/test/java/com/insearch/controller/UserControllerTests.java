//package com.insearch.controller;
//
//import static org.junit.Assert.assertEquals;
//import static org.junit.Assert.assertNotNull;
//import static org.junit.Assert.assertNull;
//
//import java.net.URI;
//import java.util.Locale;
//
//import org.junit.FixMethodOrder;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.junit.runners.MethodSorters;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
//import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
//import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.boot.test.context.TestConfiguration;
//import org.springframework.boot.test.web.client.TestRestTemplate;
//import org.springframework.context.MessageSource;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.MediaType;
//import org.springframework.http.RequestEntity;
//import org.springframework.http.ResponseEntity;
//import org.springframework.test.annotation.Rollback;
//import org.springframework.test.context.junit4.SpringRunner;
//import org.springframework.transaction.annotation.EnableTransactionManagement;
//
//import com.insearch.InsearchApplication;
//import com.insearch.service.UserService;
//import com.jayway.jsonpath.JsonPath;
//
//import kr.co.chorocksoft.ehwa.rainbird.backend.common.CrError;
//import kr.co.chorocksoft.ehwa.rainbird.backend.restful.vo.User;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@RunWith(SpringRunner.class)
//@SpringBootTest(classes = InsearchApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
//@EnableAutoConfiguration(exclude = { DataSourceTransactionManagerAutoConfiguration.class,
//		DataSourceAutoConfiguration.class })
//@TestConfiguration
//@EnableTransactionManagement(proxyTargetClass = true)
//@FixMethodOrder(MethodSorters.NAME_ASCENDING)
//public class UserControllerTests {
//
//	@Autowired
//	private TestRestTemplate restTemplate;
//
//	@Autowired
//	private UserService userService;
//
//	@Test
//	@Rollback
//	public void test01UserCRUDTest() throws Exception {
//
//		// createUser 테스트
//		RequestEntity<Void> requestVoid = RequestEntity.post(uri("/users")).accept(MediaType.APPLICATION_JSON)
//				.header(HttpHeaders.ACCEPT_LANGUAGE, "en").build();
//		ResponseEntity<String> entity = this.restTemplate.exchange(requestVoid, String.class);
//		log.info(JsonPath.read(entity.getBody(), "$.body.result"));
//		String uuid = JsonPath.read(entity.getBody(), "$.body.result");
//		assertNotNull(uuid);
//		assertEquals(HttpStatus.OK, entity.getStatusCode());
//
//		// modifyUser 테스트 - language만 변경 - 개인정보 수집화면
//		User user = new User();
//		user.setLanguage("ko");
//		user.setUuid(uuid);
//		log.info(user.toString());
//		RequestEntity<User> userRequest = RequestEntity.put(uri("/users")).accept(MediaType.APPLICATION_JSON)
//				.body(user);
//		entity = this.restTemplate.exchange(userRequest, String.class);
//		assertEquals(HttpStatus.OK, entity.getStatusCode());
//		// 실제 불러와서 확인
//		// readUser 테스트 - uuid, language만 확인
//		requestVoid = RequestEntity.get(uri("/users?uuid=" + uuid)).build();
//		entity = this.restTemplate.exchange(requestVoid, String.class);
//		assertEquals(uuid, JsonPath.read(entity.getBody(), "$.body.result.uuid"));
//		assertEquals("ko", JsonPath.read(entity.getBody(), "$.body.result.language"));
//		assertNull(JsonPath.read(entity.getBody(), "$.body.result.gender"));
//		assertNull(JsonPath.read(entity.getBody(), "$.body.result.birthyear"));
//
//		// modifyUser 테스트2 - 성, 나이 변경 - 개인정보 수집화면
//		User user2 = new User();
//		String birthyear = "1999";
//		user2.setBirthyear(birthyear);
//		user2.setGender(1);
//		user2.setUuid(uuid);
//		log.info(user2.toString());
//		RequestEntity<User> userRequest2 = RequestEntity.put(uri("/users")).accept(MediaType.APPLICATION_JSON)
//				.body(user2);
//		entity = this.restTemplate.exchange(userRequest2, String.class);
//		assertEquals(HttpStatus.OK, entity.getStatusCode());
//		// 실제 불러와서 확인 - uuid, gender, birthyear만 확인
//		requestVoid = RequestEntity.get(uri("/users?uuid=" + uuid)).build();
//		entity = this.restTemplate.exchange(requestVoid, String.class);
//		assertEquals(uuid, JsonPath.read(entity.getBody(), "$.body.result.uuid"));
//		assertEquals((Integer) 1, JsonPath.read(entity.getBody(), "$.body.result.gender"));
//		assertEquals(birthyear, JsonPath.read(entity.getBody(), "$.body.result.birthyear"));
//
//		// readUser 언어별 에러메시지 테스트
//		String errorCode = CrError.ERROR_NO_DATA.name();
//
//		requestVoid = RequestEntity.get(uri("/users?uuid=aodfigh")).accept(MediaType.APPLICATION_JSON)
//				.header(HttpHeaders.ACCEPT_LANGUAGE, "en").build();
//		entity = this.restTemplate.exchange(requestVoid, String.class);
//		log.info(JsonPath.read(entity.getBody(), "$.header.message").toString());
//		String message = messageSource.getMessage(errorCode, null, Locale.ENGLISH);
//		assertEquals(message, JsonPath.read(entity.getBody(), "$.header.message"));
//
//		requestVoid = RequestEntity.get(uri("/users?uuid=aodfigh")).accept(MediaType.APPLICATION_JSON)
//				.header(HttpHeaders.ACCEPT_LANGUAGE, "ko").build();
//		entity = this.restTemplate.exchange(requestVoid, String.class);
//		log.info(JsonPath.read(entity.getBody(), "$.header.message").toString());
//		message = messageSource.getMessage(errorCode, null, Locale.KOREAN);
//		assertEquals(message, JsonPath.read(entity.getBody(), "$.header.message"));
//
//		requestVoid = RequestEntity.get(uri("/users?uuid=aodfigh")).accept(MediaType.APPLICATION_JSON)
//				.header(HttpHeaders.ACCEPT_LANGUAGE, "km").build();
//		entity = this.restTemplate.exchange(requestVoid, String.class);
//		log.info(JsonPath.read(entity.getBody(), "$.header.message").toString());
//		message = messageSource.getMessage(errorCode, null, new Locale("km", "kh"));
//		assertEquals(message, JsonPath.read(entity.getBody(), "$.header.message"));
//
//	}
//
//	private URI uri(String path) {
//		return restTemplate.getRestTemplate().getUriTemplateHandler().expand(path);
//	}
//}
