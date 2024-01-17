package com.dgames.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgames.domain.GenreVO;
import com.dgames.domain.PlatformVO;
import com.dgames.domain.PublisherVO;
import com.dgames.mapper.AdCategoryMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdCategoryServiceImpl implements AdCategoryService {

	private final AdCategoryMapper adCategoryMapper;
	/*
	@Override
	public List<CategoryVO> getCategoryList() {
		
		List<CategoryVO> getGenre = adCategoryMapper.getGenre();
		List<CategoryVO> getPlatform = adCategoryMapper.getPlatform();
		List<CategoryVO> getPublisher = adCategoryMapper.getPublisher();
		List<CategoryVO> getList = new ArrayList<CategoryVO>();
		getList.addAll(getGenre);
		getList.addAll(getPlatform);
		getList.addAll(getPublisher);		
		
		return getList;
	}
	*/
	@Override
	public List<GenreVO> getGenre() {
		return adCategoryMapper.getGenre();
	}

	@Override
	public List<PlatformVO> getPlatform() {
		return adCategoryMapper.getPlatform();
	}

	@Override
	public List<PublisherVO> getPublisher() {
		return adCategoryMapper.getPublisher();
	}
}
