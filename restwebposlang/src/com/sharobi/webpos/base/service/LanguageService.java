package com.sharobi.webpos.base.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Language;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
@Service
public class LanguageService {

	private final static Logger logger=LogManager.getLogger(LanguageService.class);
	private final static Gson gson=new Gson();
	
	
	public List<Language> getLanguageListByStoreId(int storeId){
		
		
		try{
			List<Language> language = new ArrayList<>();
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_LANGUAGE).replace("{1}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			
			language= gson.fromJson(responseString, new TypeToken<List<Language>>() {}.getType());
			return language;
			
		}catch (Exception e) {
			logger.error("Exception: ", e);
			return null;
		}
}
	

	
}