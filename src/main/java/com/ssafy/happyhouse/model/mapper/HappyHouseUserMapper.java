package com.ssafy.happyhouse.model.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.MemberDto;

@Mapper
public interface HappyHouseUserMapper {
	public MemberDto login(Map<String, String> map);
	public MemberDto getProfile(String id);
	public String signup(MemberDto m);
	public String updateProfile(MemberDto m);
	public void removeProfile(String id);
	public void removeHouseInfo(Map<String, String> map);
	public void insertUserHouseInfo(Map<String, String> map);
}
