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
	public Long ntc_regist(NoticeVO noticeVO) {

		boardMapper.ntc_regist(noticeVO);
		return boardMapper.get_ntc_id();
		
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

	@Override
	public void ntc_modify(NoticeVO notice) {

		boardMapper.ntc_modify(notice);
		
	}

	@Override
	public void ntc_delete(Long ntc_id) {
		
		boardMapper.ntc_delete(ntc_id);
		
	}
	
}
