/**
 * 
 */
package com.sharobi.webpos.adm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.ColorMaster;
import com.sharobi.webpos.adm.model.FmcgUnit;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.MenuFile;
import com.sharobi.webpos.adm.model.MenuItems;
import com.sharobi.webpos.adm.model.PrintKotMaster;
import com.sharobi.webpos.adm.model.SpecialNoteListContainer;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.multipart.MultiPart;


/**
 * @author habib
 *
 */
@Service
public class MenuMgntService {
	private final Logger logger=LogManager.getLogger(MenuMgntService.class);
	private final Gson gson=new Gson();
	
	public List<MenuCategory> getMenuCategoryByStoreId(int storeId)
	{
		List<MenuCategory> menucategoryList=new ArrayList<MenuCategory>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			menucategoryList=gson.fromJson(responseString, new TypeToken<List<MenuCategory>>() {}.getType());
			logger.debug("all menu category List fetched: {}", menucategoryList);
			return menucategoryList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public List<MenuCategory> getMenuCategoryExcludeSpclNoteByStoreId(int storeId)
	{
		List<MenuCategory> menucategoryList=new ArrayList<MenuCategory>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORYEXCLUDESPCLNOTE).replace("{1}",String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			menucategoryList=gson.fromJson(responseString, new TypeToken<List<MenuCategory>>() {}.getType());
			logger.debug("all menu category List fetched: {}", menucategoryList);
			return menucategoryList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String addMenuCategory(MenuCategory category)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_ADDCATEGORY_POST);
			//url=url.replaceAll(" ", "%20");
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(category));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String editMenuCategory(MenuCategory menuCategory)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_EDITCATEGORY);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuCategory));
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
	public String deleteMenuCategory(MenuCategory menuCategory)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_DELETECATEGORY);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuCategory));
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
	
	public List<MenuCategory> getMenuSubCategoryByStoreId(int storeId,int catId)
	{
		List<MenuCategory> menusubcategoryList=new ArrayList<MenuCategory>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_GETSUBCATEGORY).replace("{1}",String.valueOf(storeId)).replace("{2}",String.valueOf(catId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			menusubcategoryList=gson.fromJson(responseString, new TypeToken<List<MenuCategory>>() {}.getType());
			logger.debug("all menu sub category List fetched: {}", menusubcategoryList);
			return menusubcategoryList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String addMenuSubCategory(MenuCategory menuSubCategory)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_ADDSUBCATEGORY_POST);
			logger.debug("url....{}",url);
			//url=url.replaceAll(" ", "%20");
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuSubCategory));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String editMenuSubCategory(MenuCategory menuCategory)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_EDITSUBCATEGORY);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuCategory));
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
	public String deleteMenuSubCategory(MenuCategory menuCategory)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_DELETESUBCATEGORY);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuCategory));
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
	public MenuCategory getAllMenuTree(int storeId)
	{
		try{
		logger.debug("Input [store id]: {}", storeId);
		ClientResponse response=WebServiceClient.callGet(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENU_GETLISTALL).replace("{1}",String.valueOf(storeId)));
		String responseString=response.getEntity(String.class);
		//logger.debug("Response string in get all menu list: {}", responseString);
		MenuCategory menuCategory=gson.fromJson(responseString, MenuCategory.class);
		return menuCategory;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String addMenuItems(MenuItems menuItems)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_ADDMENUITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuItems));
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
	public String editMenuItems(MenuItems menuItems)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_EDITMENUITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuItems));
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
	public String deleteMenuItems(MenuItems menuItems)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_DELETEMENUITEM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(menuItems));
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
	
	public String getMenuSubCategoryListByStoreId(int storeId,int catId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SUBCATEROGY_GETSUBCATEGORY).replace("{1}",String.valueOf(storeId)).replace("{2}",String.valueOf(catId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			
			logger.debug("all menu sub category List fetched: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public MenuItems getItemDetailsById(int id,int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_GETITEMBYID).replace("{1}",String.valueOf(id)).replace("{2}",String.valueOf(storeId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			MenuItems menuItem=gson.fromJson(responseString, MenuItems.class);
			return menuItem;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public List<FmcgUnit> getFmcgUnitByStoreId(int storeId)
	{
		List<FmcgUnit> fmcgList=new ArrayList<FmcgUnit>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_GETFMCGUNIT).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			fmcgList=gson.fromJson(responseString, new TypeToken<List<FmcgUnit>>() {}.getType());
			logger.debug("all fmcg List fetched: {}", fmcgList);
			return fmcgList;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public List<ColorMaster> getallColor()
	{
		List<ColorMaster> colorList=new ArrayList<ColorMaster>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_SPECIALNOTE_GETCOLOR);
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			colorList=gson.fromJson(responseString, new TypeToken<List<ColorMaster>>() {}.getType());
			logger.debug("all fmcg List fetched: {}", colorList);
			return colorList;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public MenuCategory getAllSplNoteTree(int storeId,int itemId)
	{
		try{
		logger.debug("Input [store id],[item id]: {},{}", storeId,itemId);
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SPECIALNOTE_GETSPECIALNOTE).replace("{1}",String.valueOf(storeId)).replace("{2}", String.valueOf(itemId));
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		logger.debug("Response string in get all special note list: {}", responseString);
		MenuCategory menuCategory=gson.fromJson(responseString, MenuCategory.class);
		return menuCategory;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public MenuCategory getSpecialNoteforMgnt(int storeId)
	{
		MenuCategory menuspnote=new MenuCategory();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SPECIALNOTE_GETALLSPECIALNOTE).replace("{1}", String.valueOf(storeId));
			//logger.debug("get table list URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get table list: {}", responseString);
			menuspnote=gson.fromJson(responseString, MenuCategory.class);
			logger.debug("Special Note List fetched: {}", menuspnote);
			return menuspnote;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public MenuCategory getSpecialNoteByStore(int storeId)
	{
		MenuCategory menusplnote=new MenuCategory();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SPECIALNOTE_GETSPECIALNOTE_FORSTORE).replace("{1}", String.valueOf(storeId));
			//logger.debug("get table list URL: {}", url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get table list: {}", responseString);
			menusplnote=gson.fromJson(responseString, MenuCategory.class);
			logger.debug("Special Note List fetched: {}", menusplnote);
			return menusplnote;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	public String addSpecialNote(SpecialNoteListContainer specialNoteListContainer)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_SPECIALNOTE_ADDSPECIALNOTE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(specialNoteListContainer));
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
	public String getInstalledPrinters()
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_PRINT_GETALLINSTALLEDPRINTERS);
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("all installed printer List fetched: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String assignPrinter(PrintKotMaster kotMaster)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_PRINT_ASSIGNPRINTER);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(kotMaster));
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
	public String getAllServerPrinters(int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_PRINT_GETALLSERVERPRINTERS).replace("{1}",String.valueOf(storeId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("all server printer List fetched: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String assignPrinterToItem(int itemid,String printerList)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_PRINT_ASSIGNPRINTERTOITEM).replace("{1}",String.valueOf(itemid)).replace("{2}", String.valueOf(printerList));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
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
	public String uploadMenuItems(/*MenuFile file*/MultiPart multipart)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_MENUITEM_UPLOADFILE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPostData(url,multipart/*,multipart*/);
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
}
