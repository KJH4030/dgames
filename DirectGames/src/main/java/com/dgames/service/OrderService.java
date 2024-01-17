package com.dgames.service;

import com.dgames.domain.OrderVO;
import com.dgames.domain.PaymentVO;

public interface OrderService {

	int getOrderSeq();
	
	// 주문하기
	void order_insert(OrderVO o_vo, PaymentVO p_vo);
}
