package com.insearch.vo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	@JsonProperty("id")
	@Setter @Getter
	private String id;
	@JsonProperty("pw")
	@Setter @Getter
	private String pw;
	@JsonProperty("email")
	@Setter @Getter
	private String email;
	@JsonProperty("agerange")
	@Setter @Getter
	private Integer agerange;
	@JsonProperty("gender")
	@Setter @Getter
	private Integer gender;
	@JsonProperty("emailflag")
	@Setter @Getter
	private Integer emailflag;
	
	
}
