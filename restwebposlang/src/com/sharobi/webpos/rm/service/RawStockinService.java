package com.sharobi.webpos.rm.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
@Service
public class RawStockinService {
	private final static Logger logger = LogManager.getLogger(RawStockinService.class);
	private final static Gson gson = new Gson();
}
