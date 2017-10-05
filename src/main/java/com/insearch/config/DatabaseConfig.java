package com.insearch.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.tomcat.jdbc.pool.DataSource;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@PropertySource("config.properties")
@Configuration
@EnableTransactionManagement
@MapperScan(basePackages = "com.insearch")
@Component
public class DatabaseConfig {
	@Autowired
	ApplicationContext context;

	@Value("${mybatis.datasource.driver-class-name}")
	private String dbDriverClassName;

	@Value("${mybatis.datasource.url}")
	private String dbUrl;

	@Value("${mybatis.datasource.username}")
	private String dbUserName;

	@Value("${mybatis.datasource.password}")
	private String dbPw;

	protected void configureDataSource(org.apache.tomcat.jdbc.pool.DataSource dataSource) {
		dataSource.setDriverClassName(dbDriverClassName);
		dataSource.setUrl(dbUrl);
		dataSource.setUsername(dbUserName);
		dataSource.setPassword(dbPw);
		// dataSource.setMaxActive(masterDatabaseProperties.getMaxActive());
		// dataSource.setMaxIdle(masterDatabaseProperties.getMaxIdle());
		// dataSource.setMinIdle(masterDatabaseProperties.getMinIdle());
		// dataSource.setMaxWait(masterDatabaseProperties.getMaxWait());
		// dataSource.setTestOnBorrow(false);
		// dataSource.setTestOnReturn(false);
	}

	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		org.apache.tomcat.jdbc.pool.DataSource dataSource = new org.apache.tomcat.jdbc.pool.DataSource();
		configureDataSource(dataSource);
		return dataSource;
	}

	@Bean
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(dataSource());
		transactionManager.setGlobalRollbackOnParticipationFailure(false);
		return transactionManager;
	}

	@Bean
	public SqlSessionFactory sqlSessionFatory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
		sqlSessionFactory.setDataSource(dataSource());
		sqlSessionFactory.setConfigLocation(context.getResource("classpath:mybatis/configuration.xml"));
		sqlSessionFactory.setMapperLocations(context.getResources("classpath:mybatis/mysql/*.xml"));
		return (SqlSessionFactory) sqlSessionFactory.getObject();
	}
}