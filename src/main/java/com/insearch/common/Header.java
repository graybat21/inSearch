package com.insearch.common;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

public class Header implements Serializable {
	private static final long serialVersionUID = 1L;
	@Getter @Setter private String message;
}