/**
 * 
 */
package com.sharobi.webpos.base.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.MenuItem;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author habib
 *
 */
@Service
public class MenuService {
	private final static Logger logger=LogManager.getLogger(MenuService.class);
	private final static Gson gson=new Gson();
	
	public Menu getAllMenuList(int storeId, String lang)
	{
		try{
		logger.debug("Input [store id]: {},{}", storeId,lang);
		ClientResponse response=WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENU_GETLIST).replace("{1}",String.valueOf(storeId)).replace("{2}",lang));
		String responseString=response.getEntity(String.class);
		logger.debug("Response string in get all menu list: {}", responseString);
		Menu menu=gson.fromJson(responseString, Menu.class);
		return menu;
		}catch (Exception e) {
			logger.debug("Exception:",e);
			return null;
		}
		
	}
	
	public List<MenuItem> getMenuItems(Menu menuTree,int subcatId)
	{
		if(menuTree!=null && CollectionUtils.isNotEmpty(menuTree.getMenucategory()))
		{
			List<Menu> allMenuCat=menuTree.getMenucategory();
			Iterator<Menu> allMenuCatItr=allMenuCat.iterator();
			
			if(subcatId==0){
			  List<MenuItem> items = new ArrayList<MenuItem>();
			  while(allMenuCatItr.hasNext())
            {  
			       Menu menu=allMenuCatItr.next();
			         for(Menu ob:menu.getMenucategory()){
			              for(MenuItem itm:ob.getItems()){
			                items.add(itm);
			              }
			            }
			       }
			  //System.out.println("Items::::"+items.toString());
			  return items;
			
			}else{
			  while(allMenuCatItr.hasNext())
	      {
	        Menu menu=allMenuCatItr.next();
	        //System.out.println("sub cat:"+menu);
	        if (menu.getId() == subcatId) {
	          logger.debug("menu Id: {}", menu.getId());
	          logger.debug("menu items:{}",menu.getItems());
	          return menu.getItems();
	        }else
	        {
	          List<MenuItem> menuItem=this.getMenuItems(menu, subcatId);
	          //logger.debug("in else menu items:{}",menuItem);
	          if(CollectionUtils.isNotEmpty(menuItem))
	          {
	            return menuItem;
	          }
	        }
	      }
			  
			}
			
			
		}
		return null;
	}
	
	public String getMenuitemByBarcode(String code,int storeId, String lang)
	{
		try{
		logger.debug("Input [store id]: {},{},{}",code, storeId,lang);
		ClientResponse response=WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENU_GETITEM_BYCODE).replace("{1}",String.valueOf(code.trim())).replace("{2}",String.valueOf(storeId)).replace("{3}",String.valueOf(lang)));
		String responseString=response.getEntity(String.class);
		logger.debug("Response string in get  menu by barcode: {}", responseString);
//		MenuItem menuitem=gson.fromJson(responseString, MenuItem.class);
//		return menuitem;
		return responseString;
		}catch (Exception e) {
			logger.debug("Exception:",e);
			return null;
		}
		
	}
}
