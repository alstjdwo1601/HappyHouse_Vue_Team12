package com.ssafy.happyhouse.model;

import java.util.List;

public class MemberDto {
	private String id;
	private String password;
	private String name;
	private String address;
	private String phone;
	private List<HouseInfoDto> houseInfos;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public List<HouseInfoDto> getHouseInfos() {
		return houseInfos;
	}

	public void setHouseInfos(List<HouseInfoDto> houseInfos) {
		this.houseInfos = houseInfos;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", password=" + password + ", name=" + name + ", address=" + address + ", phone="
				+ phone + "]";
	}
}
