package com.dgames.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dgames.domain.CartVO;
import com.dgames.domain.MemberVO;
import com.dgames.dto.CartDTOList;
import com.dgames.service.CartService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequiredArgsConstructor
@RequestMapping("/member/cart/*")
@Controller
public class CartController {

	private final CartService cartService;
	
	// 메인및썸네일 이미지업로드 폴더경로 주입작업
	@Resource(name = "uploadPath") // servlet-context.xml 의 uploadPath bean이름 참조를 해야 함.
	private String uploadPath;
	
//	@ResponseBody
	@PostMapping("/cart_add")
	public ResponseEntity<String> cart_add(CartVO vo, HttpSession session) throws Exception {

		
		ResponseEntity<String> entity = null;
		String Dgm_id = ((MemberVO) session.getAttribute("loginStatus")).getDgm_id();
		System.out.println("Dgm_id : " + Dgm_id);
		
		
		if(cartService.cart_check(vo.getGame_id(), Dgm_id) == null){

			log.info("장바구니: " + vo);
			
			// ajax방식에서 상품코드,수량 2개정보만 전송되어옴. (로그인한 사용자의 아이디정보추가작업)
			vo.setDgm_id(Dgm_id);
			
			cartService.cart_add(vo);
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);			
			
		}else if(cartService.cart_check(vo.getGame_id(), Dgm_id) != null){
			
			entity = new ResponseEntity<String>("failed2", HttpStatus.OK);
		}else if(Dgm_id == null) {

			entity = new ResponseEntity<String>("failed1", HttpStatus.OK);
		}
		System.out.println("entity" + entity);
		return entity;
	}
	
	//장바구니 목록
	@GetMapping("/cart_list") 
	public void cart_list(HttpSession session, Model model) throws Exception {
		
		String Dgm_id = ((MemberVO) session.getAttribute("loginStatus")).getDgm_id();
		
		List<CartDTOList> cart_list = cartService.cart_list(Dgm_id);
		
		int cart_total_price = 0;
		
		for(int i=0; i<cart_list.size(); i++) {
			CartDTOList vo = cart_list.get(i);
			
			vo.setImg_up_folder(vo.getImg_up_folder().replace("\\", "/"));
			
			cart_total_price += (vo.getGame_price());
		}
		
		
		model.addAttribute("cart_list", cart_list);
		model.addAttribute("cart_total_price", cart_total_price);
		
	}
	
	//장바구니 이미지
	//상품리스트에서 보여줄 이미지.  <img src="매핑주소">
	@ResponseBody
	@GetMapping("/imageDisplay") // /user/product/imageDisplay?dateFolderName=값1&fileName=값2
	public ResponseEntity<byte[]> imageDisplay(String dateFolderName, String fileName) throws Exception {
		
		return FileUtils.getFile(uploadPath + dateFolderName, fileName);
	}
	
	//장바구니 목록에서 개별삭제(ajax용)
	@PostMapping("/cart_list_del")
	public ResponseEntity<String> cart_list_del(Long cart_code) throws Exception {
		ResponseEntity<String> entity = null;
		
		cartService.cart_list_del(cart_code);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	
	}
	
	//장바구니 목록에서 개별삭제(non-ajax용)
	@GetMapping("/cart_list_del")
	public String cart_list_del2(Long cart_code) throws Exception {
		
		cartService.cart_list_del(cart_code);
		
		return "redirect:/member/cart/cart_list";
	}
	
	//장바구니 선택삭제
	@PostMapping("/cart_sel_delete")
	public ResponseEntity<String> cart_sel_delete(@RequestParam("cart_code_arr[]") List<Long> cart_code_arr) {
		ResponseEntity<String> entity = null;
		
		//방법1. 하나씩 반복적으로 삭제.
		/*
		for(int i=0; i<cart_code_arr.size(); i++) {
			cartService.cart_delete(cart_code_arr.get(i));
		}
		*/
		
		//방법2. mybatis foreach : https://java119.tistory.com/85
		cartService.cart_sel_delete(cart_code_arr);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//장바구니 비우기
	@GetMapping("/cart_empty")
	public String cart_empty() throws Exception{		
		
		cartService.cart_empty();
		
		return "redirect:/member/cart/cart_list";
		
	}
	
}
