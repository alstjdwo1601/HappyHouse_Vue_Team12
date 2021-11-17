package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.QnaDto;
import com.ssafy.happyhouse.model.service.HappyHouseQnaService;

@CrossOrigin(origins = {"*"}, maxAge = 6000)
@RestController
public class HappyHouseQnaContoroller {

	@Autowired
	HappyHouseQnaService service;

	@GetMapping("/qna")
	public List<QnaDto> selectAll(){
		return service.selectAll();
	}

	@GetMapping("/qna/{num}")
	public QnaDto selectOne( @PathVariable String num){
		return service.selectOne(num);
	}

	@PostMapping("/qna")
	public void insert(@RequestBody QnaDto qna) {		
		service.insert(qna);
	}

	@DeleteMapping("/qna/{num}")
	public Map<String, String> delete(@PathVariable String num) {
		service.delete(num); 

		Map<String, String> map= new HashMap<String, String>();
		map.put("result", "삭제 성공");
		return map;
	}

	@PutMapping("/qna")
	public void update(@RequestBody QnaDto qna) { 
		service.update(qna);
	}
	
	@GetMapping(value="/qna/title/{title}")
	public List<QnaDto> findByTitle(@PathVariable String title){
		return service.findByTitle(title);
	}
	
	@GetMapping(value="/qna/name/{id}")
	public List<QnaDto> findById(@PathVariable String id){
		return service.findById(id);
	}
}
