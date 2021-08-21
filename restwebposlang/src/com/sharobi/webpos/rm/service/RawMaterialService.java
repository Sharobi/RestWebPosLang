package com.sharobi.webpos.rm.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
@Service
public class RawMaterialService {
	private final static Logger logger=LogManager.getLogger(RawMaterialService.class);
	private final static Gson gson=new Gson();
	
}
