package com.dgames.controller;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.dgames.domain.GenreVO;
import com.dgames.domain.PlatformVO;
import com.dgames.domain.PublisherVO;
import com.dgames.service.AdCategoryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

/*
 지정한 패키지(com.docmall.controller)에서 반복적으로 사용하는 Model 데이터작업을
 아래 클래스헤서 한번만 정의해서 사용할 때
 매번 요청이 발생될 때 마다 클래스가 동작된다(중요)
*/
@Log4j
@RequiredArgsConstructor
@ControllerAdvice(basePackages = {"com.dgames.controller"})
public class GlobalControllerAdvice {
	
	
	private final AdCategoryService adCategoryService;
	
	@ModelAttribute
	public void getFirstCategoryList(Model model) {
		
		log.info("1차카테고리 리스트");		

		List<GenreVO> getGenre = adCategoryService.getGenre();
		List<PlatformVO> getPlatform = adCategoryService.getPlatform();
		List<PublisherVO> getPublisher = adCategoryService.getPublisher();
		model.addAttribute("getGenre", getGenre);
		model.addAttribute("getPlatform", getPlatform);
		model.addAttribute("getPublisher", getPublisher);
		
	}
	
	
	
}
