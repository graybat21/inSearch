package com.insearch.common;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
public class Paging implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Getter
	@Setter
	private int previous;

	public Paging(int page, int size, int total) {
		this.page = page;
		this.size = size;
		this.total = total;
		if (page <= 1) {
			this.previous = 1;
		} else {
			this.previous = page - 1;
		}

		if (size * page >= total) {
			this.next = page;
		} else {
			this.next = page + 1;
		}

	}

	@Getter
	@Setter
	private int next;
	@Getter
	@Setter
	private int page;
	@Getter
	@Setter
	private int size;
	@Getter
	@Setter
	private int total;
}
