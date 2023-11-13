package com.dgames.service;

import org.springframework.stereotype.Service;

import com.dgames.domain.NoticeVO;
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
	
}
