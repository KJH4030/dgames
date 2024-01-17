package com.dgames.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgames.domain.ReviewVO;
import com.dgames.dto.Criteria;
import com.dgames.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReviewServiceImpl implements ReviewService {

	private final ReviewMapper reviewMapper;

	@Override
	public void review_insert(ReviewVO vo) {
		// TODO Auto-generated method stub
		reviewMapper.review_insert(vo);
	}

	@Override
	public List<ReviewVO> list(Integer game_id, Criteria cri) {
		// TODO Auto-generated method stub
		return reviewMapper.list(game_id, cri);
	}

	@Override
	public int listCount(Integer game_id) {
		// TODO Auto-generated method stub
		return reviewMapper.listCount(game_id);
	}

	@Override
	public void delete(Long rev_num) {
		// TODO Auto-generated method stub
		reviewMapper.delete(rev_num);
	}

	@Override
	public void review_modify(ReviewVO vo) {
		// TODO Auto-generated method stub
		reviewMapper.review_modify(vo);
	}
}
