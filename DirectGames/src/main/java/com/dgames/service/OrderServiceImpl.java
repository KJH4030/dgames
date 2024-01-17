package com.dgames.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dgames.domain.OrderVO;
import com.dgames.domain.PaymentVO;
import com.dgames.mapper.OrderMapper;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class OrderServiceImpl implements OrderService {
	
	private final OrderMapper orderMapper;

	@Override
	public int getOrderSeq() {
		// TODO Auto-generated method stub
		return orderMapper.getOrderSeq();
	}

	@Transactional // 트랜잭션 적용.(중요) . root-context.xml 에서 트랜잭션 설정이 되어 있어야, 기능이 동작된다.
	@Override
	public void order_insert(OrderVO o_vo, PaymentVO p_vo) {
		
		orderMapper.order_insert(o_vo);
		orderMapper.order_detail_insert(o_vo.getOrd_code(), o_vo.getDgm_id());
		orderMapper.cart_del(o_vo.getDgm_id());
		orderMapper.payment_insert(p_vo);
	}
}
