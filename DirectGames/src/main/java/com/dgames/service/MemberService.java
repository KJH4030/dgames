package com.dgames.service;

import com.dgames.domain.MemberVO;

public interface MemberService {

	String idCheck(String dgm_id);
	
	void regist(MemberVO vo);
	
	MemberVO login(String dgm_id);
	
	void modify(MemberVO vo);
}
