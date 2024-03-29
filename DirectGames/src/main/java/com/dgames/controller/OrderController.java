package com.dgames.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dgames.domain.CartVO;
import com.dgames.domain.MemberVO;
import com.dgames.domain.OrderVO;
import com.dgames.domain.PaymentVO;
import com.dgames.dto.CartDTOList;
import com.dgames.kakaopay.ApproveResponse;
import com.dgames.kakaopay.ReadyResponse;
import com.dgames.service.CartService;
import com.dgames.service.KakaoPayServiceImpl;
import com.dgames.service.OrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/member/order/*")
public class OrderController {
	
	private final CartService cartService;
	
	private final OrderService orderService;
	
	private final KakaoPayServiceImpl kakaoPayServiceImpl;
	
	
	
	//주문정보페이지
	@GetMapping("/order_info")
	public void order_info(HttpSession session, Model model) throws Exception {
		
		// 주문정보
		String dgm_id = ((MemberVO) session.getAttribute("loginStatus")).getDgm_id();
		
		List<CartDTOList> order_info = cartService.cart_list(dgm_id);
		
		int order_price = 0;
		
//		cart_list.forEach(vo -> {
//			vo.setimg_up_folder(vo.getImg_up_folder().replace("\\", "/"));
//			
//			// // 금액 = (판매가 - (판매가 * 할인율)) * 수량
//			//cart_total_price += ((double)vo.getGame_price() - (vo.getGame_price() * vo.getPro_discount() * 1/100 )) * (double) vo.getCart_amount();
//		});
		
		for(int i=0; i<order_info.size(); i++) {
			CartDTOList vo = order_info.get(i);
			
			vo.setImg_up_folder(vo.getImg_up_folder().replace("\\", "/"));
			
//			vo.setPro_discount(vo.getPro_discount() * 1/100);
			order_price += (vo.getGame_price());
		}
		
		
		model.addAttribute("order_info", order_info);
		model.addAttribute("order_price", order_price);
	}
	
	
	// 상품상세에서 주문하기.
	@GetMapping("/order_ready")
	public String order_ready(CartVO vo, HttpSession session) throws Exception {
		
		
		log.info("상세주문하기: " + vo);
		
		String dgm_id = ((MemberVO) session.getAttribute("loginStatus")).getDgm_id();
		vo.setDgm_id(dgm_id);
		
		cartService.cart_add(vo);
		
		return "redirect:/member/order/order_info"; //주문정보페이지.
	}
	
	// 결제선택 : 카카오페이
	// 1)결제준비요청
	@GetMapping(value = "/orderPay", produces = "application/json")
	public @ResponseBody ReadyResponse payReady(String paymethod,OrderVO o_vo , PaymentVO p_vo, int totalprice, HttpSession session) throws Exception {
		
		
		/*
		 * 1)주문정보구성
		    -주문테이블(OrderVO) : odr_status, payment_status 정보존재 안함.
		    -주문상세테이블(OrderDetailVO) :
		       - 장바구니테이블에서 데이터를 참조
            -결제테이블 : 보류

          2)카카오페이 결제에 필요한 정보구성.
                   스프링에서 처리할수 있는 부분 
		 */
		
		String dgm_id = ((MemberVO) session.getAttribute("loginStatus")).getDgm_id();
		o_vo.setDgm_id(dgm_id); // 아이디 저장.
		
		// 시퀀스를 주문번호로 사용 : 동일한 주문번호값이 사용.
		Long ord_code = (long) orderService.getOrderSeq();
		o_vo.setOrd_code(ord_code); // 주문번호 저장
		
		
		
		
		p_vo.setOrd_code(ord_code);
		p_vo.setDgm_id(dgm_id);
		p_vo.setPay_method("카카오페이");
		p_vo.setPay_tot_price(totalprice);
		
		o_vo.setOrd_status("주문완료");
		o_vo.setPayment_status("결제완료");

		System.out.println("orderPay 호출 성공");
		System.out.println("결제방법: " +  paymethod);
		System.out.println("주문정보: " + o_vo);
		System.out.println("결제정보: " + p_vo);
		
		
		List<CartDTOList> cart_list = cartService.cart_list(dgm_id);

		System.out.println("장바구니 정보: " + cart_list);
		String itemName = cart_list.get(0).getGame_title() + "외 " + String.valueOf(cart_list.size() - 1) + " 건";
		
		
		orderService.order_insert(o_vo, p_vo); // 주문,주문상세 정보저장, 장바구니 삭제, 결제정보 저장
		System.out.println("cart_list.size() : " + cart_list.size());
		
		
		//1)Kakao Pay 결제준비요청
		ReadyResponse readyResponse = kakaoPayServiceImpl.payReady(o_vo.getOrd_code(), itemName, cart_list.size(), dgm_id, totalprice);

		System.out.println("payready 호출 성공 : " + readyResponse);
		log.info("결제고유번호:" + readyResponse.getTid());
		log.info("결제요청URL: " + readyResponse.getNext_redirect_pc_url());
		
		//카카오페이 결제승인요청작업에 필요한 정보준비
		session.setAttribute("tid", readyResponse.getTid());
		session.setAttribute("ord_code", o_vo.getOrd_code());
		
		return readyResponse;
	}
	
	// 결제승인요청작업.  http://localhost:9091/member/order/orderApproval
	@GetMapping("/orderApproval") 
	public String orderApproval(@RequestParam("pg_token") String pg_token, HttpSession session) {
		
		System.out.println("orderApproval 호출 성공");
		
		// 2) Kakao Pay 결제승인요청작업
		Long ord_code = (Long) session.getAttribute("ord_code");
		String tid = (String) session.getAttribute("tid");
		String dgm_id = ((MemberVO) session.getAttribute("loginStatus")).getDgm_id();
		
		ApproveResponse approveResponse  = kakaoPayServiceImpl.payApprove(ord_code, tid, pg_token, dgm_id);
		
		
		session.removeAttribute("ord_code");
		session.removeAttribute("tid");
		
		return "redirect:/member/order/orderComplete";
		
	}
	
	
	// 결제 완료페이지  http://localhost:9091/member/order/orderComplete
	@GetMapping("/orderComplete") 
	public void orderComplete() {
		
	}
	
	
	// 결제 취소시  http://localhost:9091/member/order/orderCancel
	@GetMapping("/orderCancel") 
	public void orderCancel() {
		
	}
	
	// 결제 실패시  http://localhost:9091/member/order/orderFail
	@GetMapping("/orderFail") 
	public void orderFail() {
		
	}
	
	
	//걸제선택: 무통장 입금
	@GetMapping("/nobank")
	public ResponseEntity<String> nobank(String paymethod,OrderVO o_vo , PaymentVO p_vo, int totalprice, HttpSession session) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		String dgm_id = ((MemberVO) session.getAttribute("loginStatus")).getDgm_id();
		o_vo.setDgm_id(dgm_id); // 아이디 저장.
		
		// 시퀀스를 주문번호로 사용 : 동일한 주문번호값이 사용.
		Long ord_code = (long) orderService.getOrderSeq();
		o_vo.setOrd_code(ord_code); // 주문번호 저장
		
		o_vo.setOrd_status("주문완료");
		o_vo.setPayment_status("결제완료");
		
		p_vo.setPay_method("무통장입금");
		p_vo.setOrd_code(ord_code);
		p_vo.setDgm_id(dgm_id);
		p_vo.setPay_tot_price(totalprice);
		p_vo.setPay_nobank_price(totalprice);
		
		log.info("결제방법: " +  paymethod);
		log.info("주문정보: " + o_vo);
		log.info("결제정보: " + p_vo);
		
				
		orderService.order_insert(o_vo, p_vo); // 주문,주문상세 정보저장, 장바구니 삭제
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		
		return entity;
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
