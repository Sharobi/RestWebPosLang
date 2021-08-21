package com.sharobi.webpos.rm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.inv.model.InventoryStockOut;
import com.sharobi.webpos.inv.model.InventoryStockOutItems;
import com.sharobi.webpos.rm.model.EstimateDailyProd;
import com.sharobi.webpos.rm.model.Ingredient;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
@Service
public class RawStockoutService {
	private final static Logger logger = LogManager.getLogger(RawStockoutService.class);
	private final static Gson gson = new Gson();

	public List<EstimateDailyProd> getRawStockoutByDate(int storeId,
														String date) {
		try {
			List<EstimateDailyProd> edpList = new ArrayList<EstimateDailyProd>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RAWSTOCKOUT_GETRAWSTOCKOUTBYDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getRawStockoutByDate: {}", responseString);
			edpList = gson.fromJson(responseString, new TypeToken<List<EstimateDailyProd>>() {}.getType());
			return edpList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}

	public List<InventoryStockOutItems> getRawStockoutByID(	int storeId,
															String edpid,
															String rawstockoutid) {
		try {
			List<InventoryStockOutItems> edpList = new ArrayList<InventoryStockOutItems>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RAWSTOCKOUT_GETRAWSTOCKOUTBYID).replace("{1}", String.valueOf(storeId)).replace("{2}", edpid).replace("{3}", rawstockoutid));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getRawStockoutByID: {}", responseString);
			edpList = gson.fromJson(responseString, new TypeToken<List<InventoryStockOutItems>>() {}.getType());
			return edpList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}

	public List<Ingredient> getRawStockoutByIDZero(	int storeId,
													String edpid,
													String rawstockoutid) {
		try {
			List<Ingredient> ingredients = new ArrayList<Ingredient>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RAWSTOCKOUT_GETRAWSTOCKOUTBYID).replace("{1}", String.valueOf(storeId)).replace("{2}", edpid).replace("{3}", rawstockoutid));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getRawStockoutByID: {}", responseString);
			ingredients = gson.fromJson(responseString, new TypeToken<List<Ingredient>>() {}.getType());
			return ingredients;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}

	public String createNewRawStockOut(InventoryStockOut inventoryStockOut) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKOUT_CREATE_NEW));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(inventoryStockOut));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.error("Exception", e);

			return null;
		}
	}

	public void updateExistingStockOUT(InventoryStockOutItems inventoryStockOutItems) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RAWSTOCKOUT_UPDATERAWSTOCKOUTITEM));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(inventoryStockOutItems));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}

	public String getApproveRawStockout(String rawstockoutd,
										String storeid,
										String approveby,
										String updatedBy,
										String updatedDate) {
		try {
			logger.debug("Input [store id]: {},{},{},{},{}", rawstockoutd, storeid, approveby, updatedBy, updatedDate);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RAWSTOCKOUT_APPROVERAWSTOCKOUT).replace("{1}", String.valueOf(rawstockoutd)).replace("{2}", storeid).replace("{3}", approveby).replace("{4}", updatedBy).replace("{5}", updatedDate));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getRawStockoutByID: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}

	public String deleteRawStockoutItem(String stockOutId,String stockOutItemId,String storeId) {
		try {
			logger.debug("Input [store id]: {},{},{}",stockOutId,stockOutItemId, storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RAWSTOCKOUT_DELETERAWSTOCKOUT).replace("{1}", stockOutId).replace("{2}", stockOutItemId).replace("{3}", storeId));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in deleteRawStockoutItem: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
}
