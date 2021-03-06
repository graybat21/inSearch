package com.insearch.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.insearch.service.MapService;
import com.insearch.service.UserService;
import com.insearch.vo.StoreVO;
import com.insearch.vo.UserVO;

@Controller
@RequestMapping("/map/*")
public class MapController {
	
	private static final Logger logger = LoggerFactory.getLogger(MapController.class);
	
	@Inject
	private MapService mapService;
	
	@Inject
	private UserService userService;
	
	@RequestMapping(value = "/mapSearch", method = RequestMethod.GET)
	public ModelAndView map() throws Exception {
		ModelAndView mav = new ModelAndView("map/map/장소 검색");
		logger.info("MAP TEST");
		return mav;
	}
	
	@RequestMapping(value = "/map2Search", method = RequestMethod.GET)
	public ModelAndView map2() throws Exception {
		ModelAndView mav = new ModelAndView("map/map2/장소 검색");
		logger.info("MAP2 TEST");
		return mav;
	}
	
	@RequestMapping(value = "/placeDetail/{placeId}", method = RequestMethod.GET)
	public ModelAndView placeDetail(@PathVariable("placeId") String placeId,
			HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("map/placeDetail/장소 상세");
		String detailsUrl = "https://maps.googleapis.com/maps/api/place/details/json"
				+ "?placeid=" + placeId + "&key=AIzaSyDAZo3REaAB8Ev8AhAsaaB3XgKVTrrA8Es";
		
		JSONObject jsonPlaceObject = readJsonFromUrl(detailsUrl).getJSONObject("result");
		StoreVO storeVo = new StoreVO();
		
		String name = jsonPlaceObject.getString("name");
		String address = jsonPlaceObject.getString("formatted_address");
		
		JSONObject locationObject = jsonPlaceObject.getJSONObject("geometry").getJSONObject("location");
		
		double lat = Double.parseDouble(String.format("%.8f", locationObject.getDouble("lat")));
		double lng = Double.parseDouble(String.format("%.8f", locationObject.getDouble("lng")));
		
		storeVo.setName(name);
		storeVo.setAddress(address);
		storeVo.setLat(lat);
		storeVo.setLng(lng);
		
		String loginEmail = (String) session.getAttribute("email");
		UserVO loginUser = userService.selectOneUser(loginEmail);
		int userNo = loginUser.getNo();
		
		mav.addObject("storeVo", storeVo);
		mav.addObject("placeId", placeId);
		mav.addObject("userNo", userNo);
		
		int storeNo = mapService.getStoreNo(storeVo);
		
		mav.addObject("storeNo", storeNo);
		
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
