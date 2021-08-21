package com.sharobi.webpos.rm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.rm.model.FgSaleOut;
import com.sharobi.webpos.rm.model.FgSaleOutItemsChild;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class FGStockoutService {
	private final static Logger logger = LogManager.getLogger(FGStockoutService.class);
	private final static Gson gson = new Gson();

	public List<FgSaleOutItemsChild> getFgStockoutByDate(	int storeId,
														String date) {
		try {
			List<FgSaleOutItemsChild> fgSaleoutitems = new ArrayList<FgSaleOutItemsChild>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_FGSTOCKOUT_GETFGSTOCKOUTBYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getFgStockoutByDate: {}", responseString);
			fgSaleoutitems = gson.fromJson(responseString, new TypeToken<List<FgSaleOutItemsChild>>() {}.getType());
			return fgSaleoutitems;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
	
	public String createFGStockOut(FgSaleOut fgSaleOut)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_RM_FGSTOCKOUT_CREATEFGSTOCKOUT);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(fgSaleOut));
			String responseString=response.getEntity(String.class);
			logger.debug("response string createFGStockOut...{}",responseString);
			return responseString;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;	
		}
	}
}
