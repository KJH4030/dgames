package com.dgames.domain;

import lombok.Data;

@Data
public class OrderDetailGameVO {

	// 기존클래스를 필드로 사용.  mybatis에서는 resultMap 사용해야 한다.
	private OrderDetailVO orderDetailVO;  // collection 으로 표현
	private GameVO gameVO;  // collection 으로 표현
}
