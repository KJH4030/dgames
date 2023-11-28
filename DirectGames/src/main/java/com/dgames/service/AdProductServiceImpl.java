package com.dgames.service;

import org.springframework.stereotype.Service;

import com.dgames.domain.GameVO;
import com.dgames.mapper.AdProductMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdProductServiceImpl implements AdProductService {

	private final AdProductMapper adProductMapper;

	@Override
	public void game_insert(GameVO vo) {

		adProductMapper.game_insert(vo);
		
	}
}
