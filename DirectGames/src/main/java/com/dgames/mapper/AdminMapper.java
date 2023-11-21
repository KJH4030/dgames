package com.dgames.mapper;

import com.dgames.domain.AdminVO;

public interface AdminMapper {

	AdminVO admin_ok(String admin_id);
	
	void login_date(String admin_id);
	
}
