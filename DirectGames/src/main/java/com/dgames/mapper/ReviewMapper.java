package com.dgames.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dgames.domain.ReviewVO;
import com.dgames.dto.Criteria;

public interface ReviewMapper {

	void review_insert(ReviewVO vo);
	
	void review_modify(ReviewVO vo);
	
	List<ReviewVO> list(@Param("game_id") Integer game_id, @Param("cri") Criteria cri); //검색필드 사용안함
	
	int listCount(Integer game_id);
	
	void delete(Long rev_num);
}
