package com.dgames.service;

import com.dgames.domain.MemberVO;

public interface MemberService {

	String idCheck(String dgm_id);
	
	void regist(MemberVO vo);
}
