package com.dgames.service;

import java.util.List;

import com.dgames.domain.OrderDetailGameVO;
import com.dgames.domain.OrderDetailInfoVO;
import com.dgames.domain.OrderVO;
import com.dgames.dto.Criteria;

public interface AdOrderService {

	List<OrderVO> order_list(Criteria cri, String start_date, String end_date);
	
	int getTotalCount(Criteria cri, String start_date, String end_date);
	
	List<OrderDetailInfoVO> orderDetailInfo1(Long ord_code);
	
	List<OrderDetailGameVO> orderDetailInfo2(Long ord_code);
	
	void order_game_delete(Long ord_code, Integer game_id);
}
