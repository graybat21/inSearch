package com.insearch.controller;
//
//import static org.junit.Assert.assertEquals;
//import static org.junit.Assert.assertNotNull;
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
//import com.jayway.jsonpath.JsonPath;
//
//import kr.co.chorocksoft.ehwa.rainbird.backend.Application;
//import kr.co.chorocksoft.ehwa.rainbird.backend.common.CrError;
//import kr.co.chorocksoft.ehwa.rainbird.backend.restful.user.UserService;
//import kr.co.chorocksoft.ehwa.rainbird.backend.restful.vo.MyRisk;
//import kr.co.chorocksoft.ehwa.rainbird.backend.restful.vo.Risk;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@RunWith(SpringRunner.class)
//@SpringBootTest(classes = Application.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
//@EnableAutoConfiguration(exclude = { DataSourceTransactionManagerAutoConfiguration.class,
//		DataSourceAutoConfiguration.class })
//@TestConfiguration
//@EnableTransactionManagement(proxyTargetClass = true)
//@FixMethodOrder(MethodSorters.NAME_ASCENDING)
//public class UserControllerTests {
//
//	@Autowired
//	private MessageSource messageSource;
//
//	@Autowired
//	private TestRestTemplate restTemplate;
//
//	@Autowired
//	private UserService userService;
//
//	@Test
//	@Rollback
//	public void test01MyRiskContollerTest() throws Exception {
//
//		// createMyRisk 테스트
//		// 먼저 외래키로 묶여있는 user, risk 를 하나씩 만든다
//		ResponseEntity<String> entity = this.restTemplate.exchange(RequestEntity.post(uri("/users")).build(),
//				String.class);
//		log.info(JsonPath.read(entity.getBody(), "$.body.result"));
//		String uuid = JsonPath.read(entity.getBody(), "$.body.result");
//		assertNotNull(uuid);
//		assertEquals(HttpStatus.OK, entity.getStatusCode());
//
//		Risk risk = new Risk();
//		risk.setLat("90.55555555");
//		risk.setLng("361.99999999");
//		risk.setRiskcode(5);
//		risk.setUserUuid(uuid);
//		riskService.insertRisk(risk);
//		log.info(risk.getIdx().toString());
//		int idx = risk.getIdx();
//
//		// 주어진 uuid, idx 를 이용해서 myrisk 에 입력한다.
//		MyRisk myrisk = new MyRisk();
//		myrisk.setRiskIdx(idx);
//		myrisk.setUserUuid(uuid);
//		RequestEntity<MyRisk> req1 = RequestEntity.post(uri("/myrisk")).accept(MediaType.APPLICATION_JSON).body(myrisk);
//		entity = this.restTemplate.exchange(req1, String.class);
//		log.info(JsonPath.read(entity.getBody(), "$.header.message"));
//		assertEquals("success", JsonPath.read(entity.getBody(), "$.header.message"));
//		
//		// createMyRisk 테스트2 - 같은 데이터 중복입력시
//		RequestEntity<MyRisk> req2 = RequestEntity.post(uri("/myrisk")).accept(MediaType.APPLICATION_JSON).header(HttpHeaders.ACCEPT_LANGUAGE, "en").body(myrisk);
//		entity = this.restTemplate.exchange(req2, String.class);
//		log.info(JsonPath.read(entity.getBody(), "$.header.message"));
//		String message1 = messageSource.getMessage(CrError.ERROR_UNKNOWN.name(), null, Locale.ENGLISH);
//		assertEquals(message1, JsonPath.read(entity.getBody(), "$.header.message"));
//		
//		// createMyRisk 테스트3 - idx, uuid 가 null 일 경우
//		MyRisk myrisk3 = new MyRisk();
//		myrisk3.setRiskIdx(idx);
//		RequestEntity<MyRisk> req3 = RequestEntity.post(uri("/myrisk")).accept(MediaType.APPLICATION_JSON).header(HttpHeaders.ACCEPT_LANGUAGE, "km").body(myrisk3);
//		entity = this.restTemplate.exchange(req3, String.class);
//		log.info(JsonPath.read(entity.getBody(), "$.header.message"));
//		String message2 = messageSource.getMessage(CrError.ERROR_PARAM.name(), null, Locale.forLanguageTag("km"));
//		assertEquals(message2, JsonPath.read(entity.getBody(), "$.header.message"));
//		
//	}
//
//	private URI uri(String path) {
//		return restTemplate.getRestTemplate().getUriTemplateHandler().expand(path);
//	}
//
//}
