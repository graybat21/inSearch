package com.insearch.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import lombok.extern.slf4j.Slf4j;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Slf4j
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/**");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception { 
		
	}
//		http.authorizeRequests()
//				// 어드민 권한으로만 접근할 수 있는 경로.
//				.antMatchers("/admin/**").access("ROLE_ADMIN");
//		http.authorizeRequests()
//			// 회원가입과 처리부분이 추가
//			.antMatchers("/login", "/create", "/createProcessing").permitAll()
//			.antMatchers("/**").authenticated();
//		
//		http
//			.formLogin()
//			// 로그인 처리 페이지
//			.loginProcessingUrl("/loginProcessing")
//			// 로그인 페이지
//			.loginPage("/login")
//			.failureUrl("/login?error");
//		
//		http
//			.logout()
//			// /logout 을 호출할 경우 로그아웃
//			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
//			// 로그아웃이 성공했을 경우 이동할 페이지
//			.logoutSuccessUrl("/");
//		}

	
	
	
	
	// @Autowired
	// private RestAuthenticationEntryPoint unauthorizedHandler;
	//
	// @Autowired
	// private UserService userService;
	//
	// @Override
	// protected void configure(HttpSecurity http) throws Exception {
	// http.csrf().disable().exceptionHandling().authenticationEntryPoint(unauthorizedHandler).and()
	// .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and().authorizeRequests()
	// .antMatchers("/**").permitAll()
	// // // .antMatchers("/myymjm").hasAuthority("USER")
	// .antMatchers(HttpMethod.POST, "/v1/auth/login").permitAll()
	// .antMatchers(HttpMethod.GET,
	// "/v1/auth/logout").permitAll().antMatchers(HttpMethod.OPTIONS, "/**")
	// .permitAll().and().logout().permitAll();
	// http.addFilterBefore(authenticationTokenFilterBean(),
	// UsernamePasswordAuthenticationFilter.class);
	// http.headers().cacheControl();
	// }
	//
	// @Autowired
	// public void configureAuthentication(AuthenticationManagerBuilder
	// authenticationManagerBuilder) {
	// try {
	// authenticationManagerBuilder.authenticationProvider(authProvider());
	// } catch (Exception e) {
	// log.debug("ConfigrationException", e);
	// }
	// }
	//
	// @Bean
	// public DaoAuthenticationProvider authProvider() {
	// DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
	// authProvider.setUserDetailsService(userService);
	// authProvider.setPasswordEncoder(passwordEncoder());
	// return authProvider;
	// }
	//
	// @Bean
	// public PasswordEncoder passwordEncoder() {
	// return new BCryptPasswordEncoder();
	// }
	//
	// @Bean
	// public JwtAuthenticationTokenFilter authenticationTokenFilterBean() {
	// return new JwtAuthenticationTokenFilter();
	// }
	//
	// @Bean(name = BeanIds.AUTHENTICATION_MANAGER)
	// @Override
	// public AuthenticationManager authenticationManagerBean() throws Exception
	// {
	// return super.authenticationManagerBean();
	// }
}