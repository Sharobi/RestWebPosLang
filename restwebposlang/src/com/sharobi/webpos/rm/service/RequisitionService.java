package com.sharobi.webpos.rm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrder;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrderItems;
import com.sharobi.webpos.rm.model.EstimateDailyProd;
import com.sharobi.webpos.rm.model.Ingredient;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
@Service
public class RequisitionService {
	private final static Logger logger = LogManager.getLogger(RequisitionService.class);
	private final static Gson gson = new Gson();
	
	public List<EstimateDailyProd> getRequisitionByDate(int storeId,String date) {
		try {
			List<EstimateDailyProd> edpList=new ArrayList<EstimateDailyProd>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_REQUISITION_GETREQUISITIONBYSTOREIDANDDATE).replace("{1}", String.valueOf(storeId)).replace("{2}", date));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getRequisitionByDate: {}", responseString);
			edpList=gson.fromJson(responseString, new TypeToken<List<EstimateDailyProd>>() {}.getType());
			return edpList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
	
	public List<InventoryPurchaseOrderItems> getRequisitionByIds(int storeId,String edpid,String poid) {
		try {
			List<InventoryPurchaseOrderItems> edpItemList=new ArrayList<InventoryPurchaseOrderItems>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_REQUISITION_GETREQUISITIONBYIDS).replace("{1}", String.valueOf(storeId)).replace("{2}", edpid).replace("{3}", poid));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getRequisitionByDate: {}", responseString);
			edpItemList=gson.fromJson(responseString, new TypeToken<List<InventoryPurchaseOrderItems>>() {}.getType());
			return edpItemList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
	
	public List<Ingredient> getRequisitionByIdsAndPoidZero(int storeId,String edpid,String poid) {
		try {
			List<Ingredient> edpItemList=new ArrayList<Ingredient>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_REQUISITION_GETREQUISITIONBYIDS).replace("{1}", String.valueOf(storeId)).replace("{2}", edpid).replace("{3}", poid));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getRequisitionByDate: {}", responseString);
			edpItemList=gson.fromJson(responseString, new TypeToken<List<Ingredient>>() {}.getType());
			return edpItemList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}

	public List<InventoryPurchaseOrder> newgetRequisitionByIds(int storeId, String edpid, String poId) {
		try {
			List<InventoryPurchaseOrder> poList=new ArrayList<InventoryPurchaseOrder>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_REQUISITION_GETREQUISITIONBYIDS_NEW).replace("{1}", String.valueOf(storeId)).replace("{2}", edpid).replace("{3}", poId));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in getRequisitionByDate: {}", responseString);
			poList=gson.fromJson(responseString, new TypeToken<List<InventoryPurchaseOrder>>() {}.getType());
			return poList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}
	}
}
