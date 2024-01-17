package com.dgames.service;

import java.util.List;

import com.dgames.domain.ReviewVO;
import com.dgames.dto.Criteria;

public interface ReviewService {

	void review_insert(ReviewVO vo);
	
	void review_modify(ReviewVO vo);
	
	List<ReviewVO> list(Integer game_id, Criteria cri); //검색필드 사용안함
	
	int listCount(Integer game_id);
	
	void delete(Long rev_num);
}
