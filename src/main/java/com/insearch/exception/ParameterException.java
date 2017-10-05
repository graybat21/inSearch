package com.insearch.exception;

import javax.servlet.http.HttpServletResponse;

public class ParameterException extends CrException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ParameterException(String string) {
		super(HttpServletResponse.SC_NOT_FOUND, string);
	}
}
