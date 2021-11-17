package com.ssafy.happyhouse.model.service;

import java.util.List;
import com.ssafy.happyhouse.model.QnaDto;

public interface HappyHouseQnaService {
	public List<QnaDto> selectAll();
	public QnaDto selectOne(String num);
	public int insert(QnaDto c);
	public int delete(String num);
	public int update(QnaDto c);
	
	public List<QnaDto> findByTitle(String title);
}
