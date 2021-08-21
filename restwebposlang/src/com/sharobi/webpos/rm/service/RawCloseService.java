package com.sharobi.webpos.rm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.rm.model.RawClose;
import com.sharobi.webpos.rm.model.RawCloseChild;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;;
@Service
public class RawCloseService {

	public static final Logger logger = LogManager.getLogger(RawCloseService.class);
	public static final Gson gson = new Gson();

	public List<RawCloseChild> getRawCloseItemsByDate(	String storeid,
														String date) {
		try {
			List<RawCloseChild> rawCloseChilds = new ArrayList<RawCloseChild>();
			logger.debug("getRawCloseItemsByDate {},{}",storeid,date);
			ClientResponse response=WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RAWCLOSE_GETRAWCLOSEBYDATE).replace("{1}", storeid).replace("{2}", date));
			String responseString=response.getEntity(String.class);
			logger.debug("getRawCloseItemsByDate responseString {}",responseString);
			rawCloseChilds=gson.fromJson(responseString, new TypeToken<List<RawCloseChild>>(){}.getType());
			return rawCloseChilds;
		} catch (Exception ex) {
			return null;
		}

	}
	
	public String createRawClose(RawClose rawClose) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RAWCLOSE_CREATERAWCLOSE);
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(rawClose));
			String responseString = response.getEntity(String.class);
			logger.debug("response string...{}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
	
	public String approveRawClose(	String rawcloseid,
									String storeId,
									String approveBy,String updatedBy,String updatedDate) {
		try {
			logger.debug("Input [store id]: {},{},{},{},{}", rawcloseid, storeId, approveBy,updatedBy,updatedDate);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RAWCLOSE_APPROVERAWCLOSE).replace("{1}", storeId).replace("{2}", rawcloseid).replace("{3}", approveBy).replace("{4}", updatedBy).replace("{5}", updatedDate));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in approveRawClose: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}

}
