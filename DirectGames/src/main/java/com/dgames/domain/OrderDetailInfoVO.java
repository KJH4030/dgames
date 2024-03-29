package com.dgames.domain;

import lombok.Data;


// 관리자기능
// 주문상세정보 저장목적.(주문상세테이블과 상품테이블 조인 결과)
// OT.ORD_CODE, OT.PRO_NUM, OT.DT_AMOUNT, P.PRO_NUM, P.PRO_NAME, P.PRO_PRICE, P.PRO_UP_FOLDER, P.PRO_IMG

@Data
public class OrderDetailInfoVO {

	private	Long 	ord_code;
	private Integer game_id;
	private	String	game_title;
	private	int		game_price;
	private int 	dt_amount;
	
	private	int		ord_price;  // 주문금액(pro_price * dt_amount)
	
	private	String	img_up_folder;
	private	String	game_img;
	
	
	
	
	
}
