package com.dgames.service;

import java.util.List;

import com.dgames.domain.NoticeVO;
import com.dgames.dto.Criteria;

public interface BoardService {

	Long ntc_regist(NoticeVO noticeVO);
	

	List<NoticeVO> ntc_list(Criteria cri);
	
	int ntc_count(Criteria cri);

	NoticeVO ntc_get(Long ntc_id);
	
	void ntc_modify(NoticeVO notice);
	
	void ntc_delete(Long ntc_id);
	
	
	
}
