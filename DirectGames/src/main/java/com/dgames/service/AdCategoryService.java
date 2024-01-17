package com.dgames.service;

import java.util.List;

import com.dgames.domain.GenreVO;
import com.dgames.domain.PlatformVO;
import com.dgames.domain.PublisherVO;

public interface AdCategoryService {
	
	List<GenreVO> getGenre();
	List<PlatformVO> getPlatform();
	List<PublisherVO> getPublisher();
	
}
