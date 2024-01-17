package com.dgames.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgames.domain.OrderDetailGameVO;
import com.dgames.domain.OrderDetailInfoVO;
import com.dgames.domain.OrderVO;
import com.dgames.dto.Criteria;
import com.dgames.mapper.AdOrderMapper;

import lombok.RequiredArgsConstructor;

//구현클래스

@RequiredArgsConstructor
@Service
public class AdOrderServiceImpl implements AdOrderService {

	private final AdOrderMapper adOrderMapper;

	

	@Override
	public List<OrderDetailInfoVO> orderDetailInfo1(Long ord_code) {
		// TODO Auto-generated method stub
		return adOrderMapper.orderDetailInfo1(ord_code);
	}

	@Override
	public void order_game_delete(Long ord_code, Integer game_id) {
		// TODO Auto-generated method stub
		adOrderMapper.order_game_delete(ord_code, game_id);
	}

	// mybatis에서 resultMap 사용
	@Override
	public List<OrderDetailGameVO> orderDetailInfo2(Long ord_code) {
		// TODO Auto-generated method stub
		return adOrderMapper.orderDetailInfo2(ord_code);
	}

	@Override
	public List<OrderVO> order_list(Criteria cri, String start_date, String end_date) {
		// TODO Auto-generated method stub
		return adOrderMapper.order_list(cri, start_date, end_date);
	}

	@Override
	public int getTotalCount(Criteria cri, String start_date, String end_date) {
		// TODO Auto-generated method stub
		return adOrderMapper.getTotalCount(cri, start_date, end_date);
	}
}
