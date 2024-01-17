package com.dgames.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dgames.domain.OrderDetailGameVO;
import com.dgames.domain.OrderDetailInfoVO;
import com.dgames.domain.OrderVO;
import com.dgames.dto.Criteria;

public interface AdOrderMapper {

	List<OrderVO> order_list(@Param("cri") Criteria cri, @Param("start_date") String start_date, @Param("end_date") String end_date);
	
	int getTotalCount(@Param("cri") Criteria cri, @Param("start_date") String start_date, @Param("end_date") String end_date);
	
	List<OrderDetailInfoVO> orderDetailInfo1(Long ord_code);
	
	// 기존클래스 OrderDetailVO, GameVO 필드가 있는 클래스. myatis의 resultMap 사용
	List<OrderDetailGameVO> orderDetailInfo2(Long ord_code);
	
	void order_game_delete(@Param("ord_code") Long ord_code,@Param("game_id") Integer game_id);
}
