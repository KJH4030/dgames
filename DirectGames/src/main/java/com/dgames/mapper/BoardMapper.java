package com.dgames.mapper;

import java.util.List;

import com.dgames.domain.NoticeVO;
import com.dgames.dto.Criteria;

public interface BoardMapper {

	void ntc_regist(NoticeVO noticeVO);
	
	Long get_ntc_id();

	List<NoticeVO> ntc_list(Criteria cri);
	
	int ntc_count(Criteria cri);
	
	NoticeVO ntc_get(Long ntc_id);
	
	void ntc_viewcount(Long ntc_id);
	
	void ntc_modify(NoticeVO notice);
	
	void ntc_delete(Long ntc_id);
	
	
}
