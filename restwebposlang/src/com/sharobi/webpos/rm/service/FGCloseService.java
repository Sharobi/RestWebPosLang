package com.sharobi.webpos.rm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.rm.model.FgClose;
import com.sharobi.webpos.rm.model.FgCloseChild;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

@Service
public class FGCloseService {
	private final static Logger logger = LogManager.getLogger(FGCloseService.class);
	private final static Gson gson = new Gson();

	public List<FgCloseChild> getFgCloseByDate(	int storeId,
														String date) {
		try {
			List<FgCloseChild> fgClose = new ArrayList<FgCloseChild>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_FGCLOSE_GETFGCLOSEBYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getFgCloseByDate: {}", responseString);
			fgClose = gson.fromJson(responseString, new TypeToken<List<FgCloseChild>>() {}.getType());
			return fgClose;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}

	public String createFGClose(FgClose fgClose) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_FGCLOSE_CREATEFGCLOSE);
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(fgClose));
			String responseString = response.getEntity(String.class);
			logger.debug("response string...{}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String approveFgClose(	String storeId,
									String fgcloseid,
									String approveBy,String updatedBy,String updatedDate) {
		try {
			logger.debug("Input [store id]: {},{},{},{},{}", storeId, fgcloseid, approveBy,updatedBy,updatedDate);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_FGCLOSE_APPROVEFGCLOSE).replace("{1}", storeId).replace("{2}", fgcloseid).replace("{3}", approveBy).replace("{4}", updatedBy).replace("{5}", updatedDate));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in approveFgClose: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
}
