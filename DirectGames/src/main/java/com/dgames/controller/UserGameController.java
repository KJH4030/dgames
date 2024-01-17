package com.dgames.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dgames.domain.GameVO;
import com.dgames.domain.GenreVO;
import com.dgames.domain.PlatformVO;
import com.dgames.domain.PublisherVO;
import com.dgames.dto.Criteria;
import com.dgames.dto.PageDTO;
import com.dgames.service.UserGameService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequiredArgsConstructor
@RequestMapping("/board/game/*")
@Log4j
@Controller
public class UserGameController {
	
	private final UserGameService userGameService;
	
	//메인 및 썸네일 이미지 업로드 폴더경로 주입작업
	@Resource(name="uploadPath") //servlet-context.xml bean id참조
	private String uploadPath;
	

	@ResponseBody
	@GetMapping("/imageDisplay") // /admin/product/imageDisplay 가 <img src="매핑주소">에 삽입
	public ResponseEntity<byte[]> imageDisplay(String dateFolderName, String fileName) throws Exception{
		
		return FileUtils.getFile(uploadPath + dateFolderName,fileName);
	}

	@GetMapping("/game_list")
	public String game_list(Criteria cri, Model model) throws Exception{
		

		cri.setAmount(9);
		
		List<GameVO> game_list = userGameService.game_list(cri);
		
		//날짜 폴더의 역슬래시를 슬래시로 바꾸는 작업. 역슬래시로 되어있는 정보가 스프링으로 보내는 요청데이터에 사용되면 에러발생
		game_list.forEach(vo -> {
			vo.setImg_up_folder(vo.getImg_up_folder().replace("\\", "/"));
		});
		model.addAttribute("game_list", game_list);
		
		int totalCount = userGameService.getTotalCount();
		model.addAttribute("pageMaker", new PageDTO(cri,totalCount));	
		
		return "/board/game/game_list";
	}
	
	
	//상품상세, 하단 상품후기 포함.
	@GetMapping("/game_detail")
	public void game_detail(Criteria cri, Integer game_id, Model model) throws Exception {
		
		log.info("페이징정보 : " + cri);
		log.info("상품코드 : " + game_id);
		
		
		

		//db연동작업
		GameVO gameVO = userGameService.game_detail(game_id);
		gameVO.setImg_up_folder(gameVO.getImg_up_folder().replace("\\", "/"));

		//장르,플랫폼,퍼블리셔 가져오기
		GenreVO genreVO = userGameService.getGenre(gameVO.getGenre_code());
		PublisherVO publisherVO = userGameService.getPublisher(gameVO.getPublisher_code());
		PlatformVO platformVO = userGameService.getPlatform(gameVO.getPlatform_code());
		
		System.out.println("genreVO : " + genreVO);
		
		model.addAttribute("gameVO", gameVO);
		model.addAttribute("genreVO", genreVO);
		model.addAttribute("publisherVO", publisherVO);
		model.addAttribute("platformVO", platformVO);
		
		
	}
}
