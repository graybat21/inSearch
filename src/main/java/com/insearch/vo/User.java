package com.insearch.vo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	@JsonProperty("no")
	@Setter @Getter
	public Integer no;
	@JsonProperty("id")
	@Setter @Getter
	public String id;
	@JsonProperty("pw")
	@Setter @Getter
	public String pw;
	@JsonProperty("email")
	@Setter @Getter
	public String email;
	@JsonProperty("agerange")
	@Setter @Getter
	public int agerange;
	@JsonProperty("gender")
	@Setter @Getter
	public int gender;
	@JsonProperty("emailflag")
	@Setter @Getter
	public int emailflag;
	
}
