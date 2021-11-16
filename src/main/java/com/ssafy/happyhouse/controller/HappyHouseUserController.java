package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.HappyHouseUserService;


@Controller
public class HappyHouseUserController {
	@Autowired
	HappyHouseUserService service;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@PostMapping(value="/loginProcess")
	public String login(String id, String password,
			HttpSession session, HttpServletRequest req){
		MemberDto m = service.getProfile(id);
		if(passwordEncoder.matches(password, m.getPassword()) && m != null) {
			session.setAttribute("member", m); // ${m.mid}
		}else { // login fail
			req.setAttribute("msg", "id 또는 pass를 확인하세요");
			//throw new Exception();
		}
		return "index";
	}
	

	@GetMapping(value="/getProfileProcess")
	public MemberDto getProfile(String id, HttpSession session) {
		MemberDto m = service.getProfile(id);
		session.setAttribute("member", m);
		return m;
	}
	
	@GetMapping(value="/user/{id}")
	@ResponseBody
	public List<HouseInfoDto> getProfileList(@PathVariable("id") String id, HttpSession session) {
		MemberDto m = service.getProfile(id);
		session.setAttribute("member", m);
		return m.getHouseInfos();
	}
	
	@PostMapping(value="/signupProcess")
	public String signup(@ModelAttribute MemberDto m){	//@RequestBody: json->java	
		service.signup(m);
		
		return "index";
	}	
		
	@PostMapping(value="/profileModifyProcess")
	public String updateProfile(@ModelAttribute MemberDto m, HttpSession session){	//@RequestBody: json->java	
		service.updateProfile(m);
		Map<String, String> map = new HashMap<>();
		map.put("id", m.getId());
		map.put("password", m.getPassword());
		
		MemberDto n = service.login(map);
		session.setAttribute("member", n);
		
		return "index";
	}
	
	@GetMapping(value="/user/add/{aptCode}")
	@ResponseBody
	public void insertUserHouseInfo(@PathVariable("aptCode") String aptCode, HttpSession session){
		System.out.println(aptCode);
		MemberDto m = (MemberDto)session.getAttribute("member");
		String id = m.getId();
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("aptCode", aptCode);
		service.insertUserHouseInfo(map);
		
		m = service.getProfile(id);
		session.setAttribute("member", m);
	}
	
	@GetMapping(value="/removeProfileProcess")
	public String removeProfile(String id, HttpSession session) {
		service.removeProfile(id); 
		session.invalidate();
		
		return "index";
	}
	
	@DeleteMapping(value="/user/delete/house/{aptcode}")
	@ResponseBody
	public List<HouseInfoDto> removeHouseInfo(@PathVariable("aptcode") String aptCode, HttpSession session) {
		Map<String, String> map = new HashMap();
		MemberDto m = (MemberDto) session.getAttribute("member");
		String id = m.getId();
		map.put("id", id);
		map.put("aptCode", aptCode);
		service.removeHouseInfo(map);
		m = service.getProfile(id);
		return m.getHouseInfos();
	}
	
	@GetMapping(value = "/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		new SecurityContextLogoutHandler().logout(request, response, SecurityContextHolder.getContext().getAuthentication());
		return "redirect:/";
	}
}
