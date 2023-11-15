package com.dgames.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgames.domain.NoticeVO;
import com.dgames.dto.Criteria;
import com.dgames.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {

	private final BoardMapper boardMapper;

	@Override
	public void ntc_regist(NoticeVO noticeVO) {

		boardMapper.ntc_regist(noticeVO);
	}

	@Override
	public List<NoticeVO> ntc_list(Criteria cri) {

		return boardMapper.ntc_list(cri);
	}

	@Override
	public int ntc_count(Criteria cri) {

		return boardMapper.ntc_count(cri);
	}

	@Override
	public NoticeVO ntc_get(Long ntc_id) {

		return boardMapper.ntc_get(ntc_id);
	}
	
}
