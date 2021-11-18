package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.HappyHouseUserService;
import com.ssafy.happyhouse.model.service.JwtServiceImpl;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

import com.ssafy.happyhouse.controller.HappyHouseUserController;

//@Controller
@RestController
@RequestMapping("/user")
@Api("사용자 컨트롤러  API V1")
public class HappyHouseUserController {
	public static final Logger logger = LoggerFactory.getLogger(HappyHouseUserController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	
	
	@Autowired
	HappyHouseUserService service;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private JwtServiceImpl jwtService;
	
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
	
	
	
	
	//-------------------------------------Token Login------------------------------------------------------//
	
	
	@ApiOperation(value = "로그인", notes = "Access-token과 로그인 결과 메세지를 반환한다.", response = Map.class)
	@PostMapping("/login")
	public ResponseEntity<Map<String, Object>> login(
			@RequestBody @ApiParam(value = "로그인 시 필요한 회원정보(아이디, 비밀번호).", required = true) MemberDto memberDto) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		try {
			MemberDto loginUser = service.loginToken(memberDto);
			if (loginUser != null) {
				String token = jwtService.create("userid", loginUser.getId(), "access-token");// key, data, subject
				logger.debug("로그인 토큰정보 : {}", token);
				resultMap.put("access-token", token);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			} else {
				resultMap.put("message", FAIL);
				status = HttpStatus.ACCEPTED;
			}
		} catch (Exception e) {
			logger.error("로그인 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	@ApiOperation(value = "회원인증", notes = "회원 정보를 담은 Token을 반환한다.", response = Map.class)
	@GetMapping("/info/{userid}")
	public ResponseEntity<Map<String, Object>> getInfo(
			@PathVariable("userid") @ApiParam(value = "인증할 회원의 아이디.", required = true) String userid,
			HttpServletRequest request) {
//		logger.debug("userid : {} ", userid);
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		if (jwtService.isUsable(request.getHeader("access-token"))) {
			logger.info("사용 가능한 토큰!!!");
			try {
//				로그인 사용자 정보.
				MemberDto memberDto = service.getProfile(userid);
				resultMap.put("userInfo", memberDto);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			} catch (Exception e) {
				logger.error("정보조회 실패 : {}", e);
				resultMap.put("message", e.getMessage());
				status = HttpStatus.INTERNAL_SERVER_ERROR;
			}
		} else {
			logger.error("사용 불가능 토큰!!!");
			resultMap.put("message", FAIL);
			status = HttpStatus.ACCEPTED;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
}
