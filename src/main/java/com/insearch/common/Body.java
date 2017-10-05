package com.insearch.common;

import java.util.Collection;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@JsonInclude(JsonInclude.Include.NON_EMPTY)
@ToString
public class Body {
	@Getter
	@Setter
	private Collection<?> data;

	public Body(List<?> collection, int page, int size, int total) {
		data = collection;
		paging = new Paging(page, size, total);
	}

	@Getter
	@Setter
	private Paging paging;

	@Getter
	@Setter
	private Object additionalInfo;
}
