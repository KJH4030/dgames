package com.dgames.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgames.domain.GameVO;
import com.dgames.domain.GenreVO;
import com.dgames.domain.PlatformVO;
import com.dgames.domain.PublisherVO;
import com.dgames.dto.Criteria;
import com.dgames.mapper.UserGameMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserGameServiceImpl implements UserGameService {

	private final UserGameMapper userGameMapper;
	
	@Override
	public List<GameVO> game_list(Criteria cri) {

		return userGameMapper.game_list(cri);
	}

	@Override
	public int getTotalCount() {
		return userGameMapper.getTotalCount();
	}

	@Override
	public GameVO game_detail(Integer game_id) {
		return userGameMapper.game_detail(game_id);
	}

	@Override
	public GenreVO getGenre(Integer genre_code) {
		return userGameMapper.getGenre(genre_code);
	}

	@Override
	public PublisherVO getPublisher(Integer publisher_code) {
		return userGameMapper.getPublisher(publisher_code);
	}

	@Override
	public PlatformVO getPlatform(Integer platfrom_code) {
		return userGameMapper.getPlatform(platfrom_code);
	}
}
