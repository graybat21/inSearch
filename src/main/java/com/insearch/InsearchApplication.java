package com.insearch;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.PropertySource;

import springfox.documentation.swagger2.annotations.EnableSwagger2;

@SpringBootApplication
@PropertySource("config.properties")
@ComponentScan(basePackages = "com.insearch", excludeFilters = @Filter(type = FilterType.REGEX, pattern = "com.insearch.*.*Tests"))
@EnableSwagger2
public class InsearchApplication {

	public static void main(String[] args) {
		SpringApplication.run(InsearchApplication.class, args);
	}
}
