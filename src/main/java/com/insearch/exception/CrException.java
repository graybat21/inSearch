package com.insearch.exception;

import lombok.Getter;

public class CrException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Getter
	private final int status;

	public CrException(int status, String message) {
		super(message);
		this.status = status;
	}

	public CrException(int status) {
		super();
		this.status = status;
	}
}
