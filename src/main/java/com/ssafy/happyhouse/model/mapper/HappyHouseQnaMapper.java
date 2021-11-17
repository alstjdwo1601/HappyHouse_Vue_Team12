package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.ssafy.happyhouse.model.QnaDto;

@Mapper
public interface HappyHouseQnaMapper {
	public List<QnaDto> selectAll();
	public QnaDto selectOne(String num);
	public int insert(QnaDto c);
	public int delete(String num);
	public int update(QnaDto c);
	
	public List<QnaDto> findByTitle(String title);
}
