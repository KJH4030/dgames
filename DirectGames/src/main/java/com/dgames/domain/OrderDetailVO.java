package com.dgames.domain;

import lombok.Data;

@Data
public class OrderDetailVO {

	// 테이블의 컬럼명 : ord_code, pro_num, dt_amount, dt_price
	private	Long 	ord_code;
	private Integer game_id;
	private int 	dt_price;
}
