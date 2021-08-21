package com.sharobi.webpos.rm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.rm.model.CookingUnit;
import com.sharobi.webpos.rm.model.Ingredient;
import com.sharobi.webpos.rm.model.IngredientList;
import com.sharobi.webpos.rm.model.MetricUnit;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
@Service
public class RecipeService {
	private final static Logger logger = LogManager.getLogger(RecipeService.class);
	private final static Gson gson = new Gson();

	public Menu getAllMenuListForRM(int storeId,String lang) {
		try {
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_GETLIST).replace("{1}", String.valueOf(storeId)).replace("{2}", lang));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get all menu list: {}", responseString);
			Menu menu = gson.fromJson(responseString, Menu.class);
			return menu;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}

	}

	public String getAllIndredientOfMenuItem(	int storeId,
											int itemId) {
		try {
			logger.debug("Input [store id,itemId,]: {}", storeId, itemId);
//			List<RecipeIngredient> recipeIngredientList=new ArrayList<RecipeIngredient>();
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_GETINGREDIENTLIST).replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(itemId));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get all ingredient list of menu: {}", responseString);
//			recipeIngredientList=gson.fromJson(responseString, new TypeToken<List<RecipeIngredient>>() {}.getType());
			return responseString;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}

	}
	
	public List<MetricUnit> getAllMetricsUnits(int storeId) {
		try {
			List<MetricUnit> unitList=new ArrayList<MetricUnit>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_GETALLMETRICUNITS));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get all menu list: {}", responseString);
			unitList=gson.fromJson(responseString, new TypeToken<List<MetricUnit>>() {}.getType());
			return unitList;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}

	}
	
	public List<CookingUnit> getAllCookingUnits(int storeId) {
		try {
			List<CookingUnit> cookingUnit=new ArrayList<CookingUnit>();
			logger.debug("Input [store id]: {}", storeId);
			ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_GETALLCOOKINGUNITS).replace("{1}", String.valueOf(storeId)));
			String responseString = response.getEntity(String.class);
			logger.debug("Response string in get all menu list: {}", responseString);
			cookingUnit=gson.fromJson(responseString, new TypeToken<List<CookingUnit>>() {}.getType());
			return cookingUnit;
		} catch (Exception e) {
			logger.debug("Exception:", e);
			return null;
		}

	}
	
	public void createNewReceipe(IngredientList ingredientList) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_ADDINGREDIENT));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(ingredientList));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}
	
	public void deleteEachReceipeItem(	String storeId,
										String rceipeingid
										) {

		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_DELETEINGREDIENT).replace("{1}", storeId).replace("{2}", rceipeingid));
		logger.debug("URL :: {}", url);
		ClientResponse response = WebServiceClient.callGet(url);
		logger.debug("Response : {}", response);
		String responseString = response.getEntity(String.class);
		logger.debug("Response string: {}", responseString);
	}
	
	public String metrictUnitConVersionFactor(String storeId,String fromUnitId,String toUnitId) {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_GETMETRICUNITCONVERSIONFACTOR).replace("{1}", storeId).replace("{2}", fromUnitId).replace("{2}", toUnitId));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			logger.debug("Response : {}", response);
			String responseString = response.getEntity(String.class);
			logger.debug("Response string: {}", responseString);
			return responseString;
	}
	
	public String updateEachReceipeItem(Ingredient ingredient) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_UPDATEINGREDIENT));
			logger.debug("URL :: {}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(ingredient));
			String responseString = response.getEntity(String.class);
			logger.debug("Response :: {}", responseString);
			return responseString;
		} catch (Exception e) {
			logger.error("Exception", e);
			return "failure";
		}
	}

  public List<MetricUnit> getUnitsByType(String type) {
    try {
      List<MetricUnit> cookingUnit=new ArrayList<MetricUnit>();
      ClientResponse response = WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_RECIPE_MENU_GETALLMETRICUNITS_BYTYPE).replace("{1}", type));
      String responseString = response.getEntity(String.class);
      logger.debug("Response string in get all unit list: {}", responseString);
      cookingUnit=gson.fromJson(responseString, new TypeToken<List<MetricUnit>>() {}.getType());
      return cookingUnit;
    } catch (Exception e) {
      logger.debug("Exception:", e);
      return null;
    }
  }
}
