package com.insearch.common;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Getter;
import lombok.Setter;
@JsonInclude(Include.NON_NULL)
public class Doc {

	@Getter
	@Setter
	private Header header;

	@Getter
	@Setter
	private Object body;

}