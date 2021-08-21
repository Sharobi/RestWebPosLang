/**
 * 
 */
package com.sharobi.webpos.rm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.rm.model.EstimateDailyProd;
import com.sharobi.webpos.rm.model.EstimateDailyProdItem;
import com.sharobi.webpos.rm.model.Ingredient;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author habib
 *
 */
@Service
public class EDPService {
	private final static Logger logger = LogManager.getLogger(EDPService.class);
	private final static Gson gson = new Gson();
	
	public List<EstimateDailyProd> getAllEDPByDate(int storeId,String date) {
		try {
			List<EstimateDailyProd> edpList=new ArrayList<EstimateDailyProd>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_GETALLEDPBYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getAllEDPByDate: {}", responseString);
			edpList=gson.fromJson(responseString, new TypeToken<List<EstimateDailyProd>>() {}.getType());
			return edpList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}

	public List<EstimateDailyProdItem> getEstimateDailyProdByStoreIdAndId(int storeId,String id) {
		try {
			List<EstimateDailyProdItem> edpitemList=new ArrayList<EstimateDailyProdItem>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_GETEDPBYSTOREIDANDID).replace("{1}", String.valueOf(storeId)).replace("{2}", id));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getEstimateDailyProdByStoreIdAndId: {}", responseString);
			edpitemList = gson.fromJson(responseString, new TypeToken<List<EstimateDailyProdItem>>() {}.getType());
			return edpitemList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
	
	public List<Ingredient> getIngredientsForEdp(int storeId,String edpid) {
		try {
			List<Ingredient> edpinvList=new ArrayList<Ingredient>();
			logger.debug("Input [store id]: {},{}", storeId,edpid);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_GETINGREDIENTFOREDP).replace("{1}", String.valueOf(storeId)).replace("{2}", edpid));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getAllEDPByDate: {}", responseString);
			edpinvList=gson.fromJson(responseString, new TypeToken<List<Ingredient>>() {}.getType());
			return edpinvList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
	
	public String deleteEstimateDailyProdItem(int storeId,String id,String edpid) {
		try {
			logger.debug("Input [store id,id,edpid]: {},{},{}", storeId,id,edpid);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_DELETEEDPITEM).replace("{1}", String.valueOf(storeId)).replace("{2}", id).replace("{3}", edpid));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getAllEDPByDate: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
	
	public String createEDP(String estimateDailyProd)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_CREATEEDP);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, estimateDailyProd);
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;	
		}
	}
	
	public Menu getAllMenuLayoffListForRM(int storeId) {
		try {
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_MENU_GETLAYOFFLIST).replace("{1}", String.valueOf(storeId)));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get all menu layoff list: {}", responseString);
			Menu menu = gson.fromJson(responseString, Menu.class);
			return menu;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}

	}
	
	public String approveEDP(String storeId,String edpid,String approveBy) {
		try {
			logger.debug("Input [store id]: {},{},{}", storeId,edpid,approveBy);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_APPROVEEDP).replace("{1}", storeId).replace("{2}", edpid).replace("{3}", approveBy));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in approveEDP: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
	public String updateEDPItem(EstimateDailyProdItem estimateDailyProdItem)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_UPDATEEDPITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(estimateDailyProdItem));
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;	
		}
	}
	public String addEDPItem(EstimateDailyProdItem estimateDailyProdItem)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_ADDEDPITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(estimateDailyProdItem));
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;	
		}
	}
	public String deleteEDP(String storeId,String edpid) {
		try {
			logger.debug("Input [store id]: {},{}", storeId,edpid);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_DELETEEDP).replace("{1}", edpid).replace("{2}", storeId));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in deleteEDP: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
}
