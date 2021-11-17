package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.QnaDto;
import com.ssafy.happyhouse.model.mapper.HappyHouseQnaMapper;

@Service
public class HappyHouseQnaServiceImpl implements HappyHouseQnaService {
	
	@Autowired
	HappyHouseQnaMapper mapper;
	
	@Override
	public List<QnaDto> selectAll() {
		return mapper.selectAll();
	}

	@Override
	public QnaDto selectOne(String num) {
		return mapper.selectOne(num);
	}

	@Override
	public int insert(QnaDto c) {
		return mapper.insert(c);
	}

	@Override
	public int delete(String num) {
		return mapper.delete(num);
	}

	@Override
	public int update(QnaDto c) {
		return mapper.update(c);
	}

	@Override
	public List<QnaDto> findByTitle(String title) {
		return mapper.findByTitle(title);
	}

}
