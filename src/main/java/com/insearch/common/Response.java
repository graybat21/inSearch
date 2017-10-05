package com.insearch.common;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
@ApiModel(description="Response")
@JsonInclude(Include.NON_NULL)
public class Response  {
	@Getter @Setter private Doc doc;
}
