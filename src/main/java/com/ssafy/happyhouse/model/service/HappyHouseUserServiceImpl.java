package com.ssafy.happyhouse.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.mapper.HappyHouseUserMapper;

@Service
public class HappyHouseUserServiceImpl implements HappyHouseUserService {
	
	@Autowired
	HappyHouseUserMapper mapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public MemberDto login(Map<String, String> map) {
		return mapper.login(map);
	}
	
	
	//token login
	@Override
	public MemberDto loginToken(MemberDto memberDto) throws Exception {
		return mapper.loginToken(memberDto);
	}
	

	@Override
	public MemberDto getProfile(String id) {
		return mapper.getProfile(id);
	}

	@Override
	public String signup(MemberDto m) {
		m.setPassword(passwordEncoder.encode(m.getPassword()));
		return mapper.signup(m);
	}

	@Override
	public String updateProfile(MemberDto m) {
		m.setPassword(passwordEncoder.encode(m.getPassword()));
		return mapper.updateProfile(m);
	}

	@Override
	public void removeProfile(String id) {
		mapper.removeProfile(id);
	}

	@Override
	public void removeHouseInfo(Map<String, String> map) {
		mapper.removeHouseInfo(map);		
	}

	@Override
	public void insertUserHouseInfo(Map<String, String> map) {
		mapper.insertUserHouseInfo(map);
		
	}

	

}
