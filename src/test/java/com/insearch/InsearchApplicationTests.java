package com.insearch;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.mysql.jdbc.Connection;

//@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest(classes = InsearchApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@EnableAutoConfiguration(exclude = { DataSourceTransactionManagerAutoConfiguration.class,
		DataSourceAutoConfiguration.class })
@TestConfiguration
@EnableTransactionManagement(proxyTargetClass = true)
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class InsearchApplicationTests {

	@Autowired
	private DataSource ds;

	@Test
	public void testConection() throws Exception {

		try (java.sql.Connection con = (Connection) ds.getConnection()) {

			System.out.println("Connection : " + con);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void contextLoads() {
	}

}
