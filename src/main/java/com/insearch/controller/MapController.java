package com.insearch.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/map/*")
public class MapController {
	
	private static final Logger logger = LoggerFactory.getLogger(MapController.class);
	
	@RequestMapping(value = "/mapSearch", method = RequestMethod.GET)
	public ModelAndView map() throws Exception {
		ModelAndView mav = new ModelAndView("map/map/장소 검색");
		logger.info("MAP TEST");
		return mav;
	}
	
	@RequestMapping(value = "/placeDetail", method = RequestMethod.GET)
	public ModelAndView placeDetailTest(String placeId) throws Exception {
		ModelAndView mav = new ModelAndView("placeDetail");
		String detailsUrl = "https://maps.googleapis.com/maps/api/place/details/json"
				+ "?placeid=" + placeId + "&language=ko-KR&key=AIzaSyDAZo3REaAB8Ev8AhAsaaB3XgKVTrrA8Es";
		
		JSONObject jsonPlaceObject = readJsonFromUrl(detailsUrl).getJSONObject("result");
		String placeAddress = jsonPlaceObject.getString("formatted_address");
		System.out.println(placeAddress);
		return mav;
	}
	
	private String jsonReadAll(Reader reader) throws IOException {
		StringBuilder sb = new StringBuilder();
		int cp;
		while ((cp = reader.read()) != -1) {
			sb.append((char) cp);
		}
		return sb.toString();
	}
	
	private JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
		InputStream is = new URL(url).openStream();
		
		try 
		{
			BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			String jsonText = jsonReadAll(rd);
			JSONObject json = new JSONObject(jsonText);
			return json;
		} 
		finally 
		{
			is.close();
		}
	}
}
