package com.ssafy.happyhouse.model.service;

import java.util.Map;

import com.ssafy.happyhouse.model.MemberDto;

public interface HappyHouseUserService {
	
	public MemberDto login(Map<String, String> map);
	public MemberDto getProfile(String id);
	public String signup(MemberDto m);
	public String updateProfile(MemberDto m);
	public void removeProfile(String id);
	public void removeHouseInfo(Map<String, String> map);
	public void insertUserHouseInfo(Map<String, String> map);
	
	//token login
	public MemberDto loginToken(MemberDto memberDto) throws Exception;
}
