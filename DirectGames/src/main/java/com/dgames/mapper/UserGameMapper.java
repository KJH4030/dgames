package com.dgames.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dgames.domain.GameVO;
import com.dgames.domain.GenreVO;
import com.dgames.domain.PlatformVO;
import com.dgames.domain.PublisherVO;
import com.dgames.dto.Criteria;

public interface UserGameMapper {

	// 2차카테고리별 상품리스트(페이징정보사용, 검색제외)
	List<GameVO> game_list(Criteria cri);
	
	int getTotalCount();
	
	GameVO game_detail(Integer game_id);

	GenreVO getGenre(Integer genre_code);
	PublisherVO getPublisher(Integer publisher_code);
	PlatformVO getPlatform(Integer platfrom_code);
}
