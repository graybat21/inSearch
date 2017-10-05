package com.insearch.common;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

import lombok.extern.slf4j.Slf4j;


public class ResponseBuilder {

	private HttpServletResponse httpResponse;
	private Response responseObj;
	private Object body;
	private int status = HttpServletResponse.SC_OK;
	private String message;

	public ResponseBuilder(HttpServletResponse response) {
		httpResponse = response;
		httpResponse.setContentType(MediaType.APPLICATION_JSON_VALUE);
		httpResponse.setCharacterEncoding("UTF-8");
	}

	public ResponseBuilder build() {
		responseObj = new Response();
		responseObj.setDoc(new Doc());
		responseObj.getDoc().setHeader(new Header());
		if (status == HttpServletResponse.SC_OK) {
			responseObj.getDoc().getHeader().setMessage("success");
		} else {
			httpResponse.setStatus(status);
			responseObj.getDoc().getHeader().setMessage(message);
		}
		if (body != null) {
			responseObj.getDoc().setBody(body);
		}
		return this;
	}

	public void flush() {
		String jsonString;
		try {
			jsonString = Jackson2ObjectMapperBuilder.json().build().writeValueAsString(responseObj);
//			log.info(jsonString);
			httpResponse.getWriter().write(jsonString);
			httpResponse.getWriter().flush();
			httpResponse.getWriter().close();
		} catch (RuntimeException e) {
//			log.info(e.getMessage());
			throw e;
		} catch (Exception e) {
			new RuntimeException(e);
//			log.info(e.getMessage());
		}
	}

	public ResponseBuilder setBody(Object obj) {
		body = obj;
		return this;
	}

	public ResponseBuilder setStatus(int scCode) {
		status = scCode;
		return this;
	}

	public ResponseBuilder setHeaderMessage(String message) {
		this.message = message;
		return this;
	}
}
