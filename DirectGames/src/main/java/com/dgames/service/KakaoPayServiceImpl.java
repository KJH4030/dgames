package com.dgames.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.dgames.kakaopay.ApproveResponse;
import com.dgames.kakaopay.ReadyResponse;


//카카오페이 API서버에 실제요청하는 작업
/*
 - HttpURLConnection 를 이용한 HTTP통신방법 
 - RestTemplate를 이용한 HTTP통신방법(스프링에서 권장).  https://minkwon4.tistory.com/178
  설명: RestTemplate은 Spring 3.0 부터 지원하는 템플릿으로 Spring에서 HTTP 통신을 RESTful 형식에 맞게 손쉬운 사용을 제공해주는 템플릿이다
 */

@Service
public class KakaoPayServiceImpl {

	
	// HttpHeaders 클래스 : 헤더정보를 구성할 때 사용.
	/*
	 2)헤더정보 
	 Authorization: KakaoAK ${SERVICE_APP_ADMIN_KEY}
	 Content-type: application/x-www-form-urlencoded;charset=utf-8 
	 
	 */
	
	private HttpHeaders getHeaderInfo() {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK fd59dfc342278768b772391d2f8355a6");
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		return headers;
	}
	
	
	
	/*
	 1)결제 준비하기 - 첫번째 요청
	 1)요청주소 : https://kapi.kakao.com/v1/payment/ready
	  POST /v1/payment/ready
	  Host kapi.kakao.com
	 2)헤더정보 
	 Authorization: KakaoAK ${SERVICE_APP_ADMIN_KEY}
	 Content-type: application/x-www-form-urlencoded;charset=utf-8
	*/
	
	public ReadyResponse payReady(Long ord_code, String itemName, int quantity, String dgm_id, int totalAmount) {
		
		System.out.println("payReady 호출 성공");
		
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		
		parameters.add("cid", "TC0ONETIME"); // 가맹점 코드, 10자
		parameters.add("partner_order_id", String.valueOf(ord_code)); // 가맹점 주문번호(쇼핑몰 상품주문번호), 최대 100자
		parameters.add("partner_user_id", dgm_id); // 가맹점 회원 id, 최대 100자
		parameters.add("item_name", itemName);// 상품명, 최대 100자.   예> A상품외 2건
		parameters.add("quantity", String.valueOf(quantity)); // 상품 수량
		parameters.add("total_amount", String.valueOf(totalAmount)); // 상품 총액
		parameters.add("tax_free_amount", "0"); // 상품 비과세 금액
		
		System.out.println("partner_order_id : " + String.valueOf(ord_code)); // 가맹점 주문번호(쇼핑몰 상품주문번호), 최대 100자
		System.out.println("partner_user_id : " + dgm_id); // 가맹점 회원 id, 최대 100자
		System.out.println("item_name : " + itemName);// 상품명, 최대 100자.   예> A상품외 2건
		System.out.println("quantity : " + String.valueOf(quantity)); // 상품 수량
		System.out.println("total_amount : " + String.valueOf(totalAmount)); // 상품 총액
		System.out.println("tax_free_amount : " + "0"); // 상품 비과세 금액
		
		parameters.add("approval_url", "http://localhost:9091/member/order/orderApproval"); // 결제 성공 시 redirect url, 최대 255자
		parameters.add("cancel_url", "http://localhost:9091/member/order/orderCancel"); // 결제 취소 시 redirect url, 최대 255자
		parameters.add("fail_url", "http://localhost:9091/member/order/orderFail"); // 결제 실패 시 redirect url, 최대 255자
		
		
		// https://jung-story.tistory.com/132
		
		//헤더와 파라미터정보를 구성하는 작업
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String,String>>(parameters, this.getHeaderInfo());
		
		System.out.println("requestEntity : " + requestEntity);
		
		//Kakao API 서버와 통신
		RestTemplate template = new RestTemplate();
		
		System.out.println("template : " + template);
		
		String kakaoReadyUrl = "https://kapi.kakao.com/v1/payment/ready"; 
		
		// 응답받은 데이터
		ReadyResponse readyResponse = template.postForObject(kakaoReadyUrl, requestEntity, ReadyResponse.class);
		
		System.out.println("readyResponse" + readyResponse);
		
		return readyResponse;
	}
	
	/*
	 2)결제 요청하기 - 두번째 요청
	 1)요청주소 : https://kapi.kakao.com/v1/payment/approve
	  POST /v1/payment/approve
	  Host kapi.kakao.com
	 2)헤더정보 
	 Authorization: KakaoAK ${SERVICE_APP_ADMIN_KEY}
	 Content-type: application/x-www-form-urlencoded;charset=utf-8
	*/
	
	public ApproveResponse payApprove(Long ord_code, String tid, String pgToken, String dgm_id) {
		
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		
		parameters.add("cid", "TC0ONETIME");
		parameters.add("tid", tid);
		parameters.add("partner_order_id", String.valueOf(ord_code));
		parameters.add("partner_user_id", dgm_id);
		parameters.add("pg_token", pgToken);
		
		//헤더와 파라미터정보를 구성하는 작업
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String,String>>(parameters, this.getHeaderInfo());
		
		//Kakao API 서버와 통신
		RestTemplate template = new RestTemplate();
		
		String kakaoApproveUrl = "https://kapi.kakao.com/v1/payment/approve"; 
		
		// 응답받은 데이터
		ApproveResponse approveResponse = template.postForObject(kakaoApproveUrl, requestEntity, ApproveResponse.class);
		
		return approveResponse;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
