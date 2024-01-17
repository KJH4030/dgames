package com.dgames.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dgames.domain.MemberVO;
import com.dgames.domain.ReviewVO;
import com.dgames.dto.Criteria;
import com.dgames.dto.PageDTO;
import com.dgames.service.ReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequiredArgsConstructor
@Log4j
@RequestMapping("/user/review/*")
@RestController // jsp파일을 사용 안함. @Controller + @ResponseBody
public class ReviewController {

	private final ReviewService reviewService;
	
	// @RequestBody : JSON 데이타를 ReviewVO객체로 변환해주는 기능.. 참고> 반대의미 어노테이션 @ResponseBody
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> review_insert(@RequestBody ReviewVO vo, HttpSession session) throws Exception {
		
		log.info("리뷰: " + vo);
		
		String dgm_id = ((MemberVO) session.getAttribute("loginStatus")).getDgm_id();
		vo.setDgm_id(dgm_id);
		
		ResponseEntity<String> entity = null;
		
		//db저장
		reviewService.review_insert(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	@PutMapping(value = "/modify", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> review_modify(@RequestBody ReviewVO vo, HttpSession session) throws Exception {
		
		log.info("리뷰수정: " + vo);
		
		String dgm_id = ((MemberVO) session.getAttribute("loginStatus")).getDgm_id();
		vo.setDgm_id(dgm_id);
		
		ResponseEntity<String> entity = null;
		
		//db저장
		reviewService.review_modify(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	// 전통적인 형태의 주소 list?game_id=10&page=1   -> Rest API개발형태 주소 list/47/1   
	@GetMapping("/list/{game_id}/{page}")
	public ResponseEntity<Map<String, Object>> list(@PathVariable("game_id") Integer game_id, @PathVariable("page") Integer page) throws Exception {
				
		// 리턴타입에 따른 구문
		// - select문
		// ResponseEntity<Map<String, Object>> : 1)상품후기목록 데이타 - List<ReviewVO> 2)페이징 데이타 - PageDTO  실제작업
		// ResponseEntity<List<ReviewVO>> : 상품후기목록 데이타 - List<ReviewVO>
		// ResponseEntity<PageDTO> : 페이징 데이타
		
		// - insert, delete, update
		// ResponseEntity<String>
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		//1)상품후기목록 데이타
		Criteria cri = new Criteria();
		cri.setAmount(5);
		cri.setPageNum(page);
		
		List<ReviewVO> list = reviewService.list(game_id, cri);
		
		//2)페이징 데이타
		
		int listCount = reviewService.listCount(game_id);
		PageDTO pageMaker = new PageDTO(cri, listCount);
		
		
		map.put("list", list); //  상품후기목록 데이타 - List<ReviewVO>
		map.put("pageMaker", pageMaker); //  - 페이징 데이타 - PageDTO
		
		
		// jackson-databind 라이브러리에 의하여 map -> json으로 변환되어 ajax호출한 쪽으로 리턴값이 보내진다.
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		
		return entity;
	}
	
	//상품후기 삭제
	@DeleteMapping("/delete/{rev_num}")   // /user/review/delete/1
	public ResponseEntity<String> delete(@PathVariable("rev_num") Long rev_num) throws Exception {
		ResponseEntity<String> entity = null;
		
		//db연동작업.
		reviewService.delete(rev_num);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	
}
