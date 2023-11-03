package com.dgames.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {


	private String dgm_id;
	private String dgm_name;
	private String dgm_email;
	private String dgm_password;
	private String dgm_zipcode;
	private String dgm_addr;
	private String dgm_dtaddr;
	private String dgm_phone;
	
	private int point;
	
	private Date dgm_lastlogin;
	private Date dgm_datesub;
	private Date dgm_updatedate;
	
}
