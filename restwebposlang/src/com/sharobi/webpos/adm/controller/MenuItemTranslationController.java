/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.ws.rs.core.MediaType;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.ColorMaster;
import com.sharobi.webpos.adm.model.FmcgUnit;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.MenuFile;
import com.sharobi.webpos.adm.model.MenuItemLangMap;
import com.sharobi.webpos.adm.model.MenuItemNotes;
import com.sharobi.webpos.adm.model.MenuItems;
import com.sharobi.webpos.adm.model.PrintKotMaster;
import com.sharobi.webpos.adm.model.SpecialNoteListContainer;
import com.sharobi.webpos.adm.service.MenuItemTranslationService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Language;
import com.sharobi.webpos.base.service.LanguageService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataMultiPart;
import com.sun.jersey.multipart.MultiPart;
import com.sun.jersey.multipart.file.FileDataBodyPart;


/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/menutranslation")
public class MenuItemTranslationController {
	private final static Logger logger=LogManager.getLogger(MenuItemTranslationController.class);
	@Autowired MenuItemTranslationService menuItemTranslationService;
	@Autowired LanguageService languageService;
	@RequestMapping(value="/viewmenutranslation",method=RequestMethod.GET)
	public ModelAndView loadMenuMgnt(Model model,HttpSession session)
	{
		logger.debug("In viewmenutranslation......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuCategory> menucategoryList=menuItemTranslationService.getMenuCategoryByStoreId(customer.getStoreId());
		session.setAttribute("sescategoryList", menucategoryList);
		mav.addObject("menucategorylist",menucategoryList);
		//mav.addObject("menucatid",menucategoryList.get(0).getId());
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_MENU_MGNT_PAGE);
		return mav;
	}
	//posting
	@RequestMapping(value="/addmenucategory",method=RequestMethod.POST)
	public void addMenuCategory(@RequestBody String menuItemString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addmenucategory......{}",menuItemString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			//response.setCharacterEncoding("UTF-8");
			//request.setCharacterEncoding("UTF-8");
			//MenuCategory category=new MenuCategory();
			Gson gson = new GsonBuilder().create();
			MenuCategory category =gson.fromJson(menuItemString, new TypeToken<MenuCategory>() {
			}.getType());
			//category.setMenuCategoryName(catName);
			//category.setBgColor(bgColor);
			category.setStoreId(customer.getStoreId());
			String res=menuItemTranslationService.addMenuCategory(category);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	//posting
	@RequestMapping(value="/editmenucategory",method=RequestMethod.POST)
	public void editMenuCategory(@RequestBody String menuCategoryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In editmenucategory......{}",menuCategoryString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuCategory category =gson.fromJson(menuCategoryString, new TypeToken<MenuCategory>() {
			}.getType());
			String res=menuItemTranslationService.editMenuCategory(category);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/deletemenucategory",method=RequestMethod.POST)
	public void deleteMenuCategory(@RequestBody String menuCategoryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deleteMenuCategory......{}",menuCategoryString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuCategory category =gson.fromJson(menuCategoryString, new TypeToken<MenuCategory>() {
			}.getType());
			String res=menuItemTranslationService.deleteMenuCategory(category);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	
	@RequestMapping(value="/loadsubcategory",method=RequestMethod.GET)
	public ModelAndView loadsubCategoryPage(Model model,HttpSession session)
	{
		logger.debug("in loadsubcategory...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuCategory> menuCatList=(List<MenuCategory>) session.getAttribute("sescategoryList");
		MenuCategory menucategory = null;
		/*for(MenuCategory menucat:menuCatList){
			if(menucat.getId()==NumberUtils.toInt(menucatid))
			{
				menucategory=menucat;
			}
			}*/
		menucategory=menuCatList.get(0);
		List<MenuCategory> menusubcategoryList=menuItemTranslationService.getMenuSubCategoryByStoreId(customer.getStoreId(),menucategory.getId());
		mav.addObject("catList",menuCatList);
		//mav.addObject("menucategory",menucategory);
		//model.addAttribute("printKotMaster", new PrintKotMaster());
		mav.addObject("menusubcategorylist",menusubcategoryList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_MENU_SUB_CAT_PAGE);
		return mav;
	}
	@RequestMapping(value="/loadsubcategorybyid",method=RequestMethod.GET)
	public ModelAndView loadsubCategoryPageById(@RequestParam String menucatid,HttpSession session)
	{
		logger.debug("in loadsubcategory...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuCategory> menuCatList=(List<MenuCategory>) session.getAttribute("sescategoryList");
		MenuCategory menucategory = null;
		for(MenuCategory menucat:menuCatList){
			if(menucat.getId()==NumberUtils.toInt(menucatid))
			{
				menucategory=menucat;
			}
			}
		//menucategory=menuCatList.get(0);
		List<MenuCategory> menusubcategoryList=menuItemTranslationService.getMenuSubCategoryByStoreId(customer.getStoreId(),NumberUtils.toInt(menucatid));
		mav.addObject("catList",menuCatList);
		mav.addObject("menucategory",menucategory);
		mav.addObject("menusubcategorylist",menusubcategoryList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_MENU_SUB_CAT_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/loadmenuitemtotranslatewithlang",method=RequestMethod.GET)
	public ModelAndView loadmenuitemtotranslatewithlang(@RequestParam String lang,HttpSession session,Model model)
	{
		List<MenuItemLangMap> menutranslatinItem = new ArrayList<>();
		List<Language> languages = new ArrayList<>();
		logger.debug("in loadsubcategory...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		//menucategory=menuCatList.get(0);
		menutranslatinItem=menuItemTranslationService.getAllMenuItemforTranslation(customer.getStoreId(),lang);
		languages = languageService.getLanguageListByStoreId(customer.getStoreId());
		mav.addObject("Language",lang);
		mav.addObject("langselected", languages.stream().collect(
                Collectors.toMap(x -> x.getLanguage().toLowerCase(), x -> x)).get(lang.toLowerCase()));
		mav.addObject("alllanguage",languages);
		mav.addObject("allmenuTree",menutranslatinItem);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_MENU_ITEMS_TRANSLATION_PAGE);
		return mav;
	}
	@RequestMapping(value="/addmenusubcategory",method=RequestMethod.POST)
	public void addMenuSubCategory(@RequestBody String menuSubcategoryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addmenusubcategory......{}",menuSubcategoryString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");	
			Gson gson = new GsonBuilder().create();
			MenuCategory subcategory =gson.fromJson(menuSubcategoryString, new TypeToken<MenuCategory>() {
			}.getType());
			//MenuCategory menuSubCategory=new MenuCategory();
			//menuSubCategory.setMenuCategoryName(subcatName);
			//menuSubCategory.setBgColor(subcatbgColor);
			subcategory.setStoreId(customer.getStoreId());
			//menuSubCategory.setParentCatId(""+catId);
			//System.out.println("catId:"+catId);
			String res=menuItemTranslationService.addMenuSubCategory(subcategory);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/editmenusubcategory",method=RequestMethod.POST)
	public void editSubMenuCategory(@RequestBody String menuSubCategoryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In editmenusubcategory......{}",menuSubCategoryString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new GsonBuilder().create();
			MenuCategory Subcategory =gson.fromJson(menuSubCategoryString, new TypeToken<MenuCategory>() {
			}.getType());
			/*MenuCategory menuCategory=new MenuCategory();
			menuCategory.setId(id);
			menuCategory.setMenuCategoryName(name);
			menuCategory.setBgColor(color);
			menuCategory.setStoreId(customer.getStoreId());
			menuCategory.setCategoryId(""+catId);*/
			String res=menuItemTranslationService.editMenuSubCategory(Subcategory);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/deletemenusubcategory",method=RequestMethod.POST)
	public void deleteSubMenuCategory(@RequestBody String menuCategoryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deletemenusubcategory......{}",menuCategoryString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");			
			Gson gson = new GsonBuilder().create();
			MenuCategory category =gson.fromJson(menuCategoryString, new TypeToken<MenuCategory>() {
			}.getType());
			/*MenuCategory menuCategory=new MenuCategory();
			menuCategory.setId(id);
			menuCategory.setMenuCategoryName(name);
			menuCategory.setBgColor(color);
			menuCategory.setStoreId(customer.getStoreId());
			menuCategory.setCategoryId(""+catId);*/
			String res=menuItemTranslationService.deleteMenuSubCategory(category);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/loadmenuitemtotranslate",method=RequestMethod.GET)
	public ModelAndView loadmenuitemtotranslate(HttpSession session)
	{
		List<MenuItemLangMap> menutranslatinItem = new ArrayList<>();
		List<Language> languages = new ArrayList<>();
		String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);	
		System.out.println("selLang="+selLang);
		logger.debug("in loadmenuitemtotranslate...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		menutranslatinItem=menuItemTranslationService.getAllMenuItemforTranslation(customer.getStoreId(),selLang);
		languages=languageService.getLanguageListByStoreId(customer.getStoreId());
		mav.addObject("allmenuTree",menutranslatinItem);
		mav.addObject(Constants.ADMIN,"Y");
		mav.addObject("alllanguage",languages);
		mav.addObject("langselected", languages.stream().collect(
                Collectors.toMap(x -> x.getLanguage().toLowerCase(), x -> x)).get(selLang.toLowerCase()));
		mav.setViewName(ForwardConstants.VIEW_MENU_ITEMS_TRANSLATION_PAGE);
		
		return mav;
	}
	
	/*@RequestMapping(value="/loadmenuitemtotranslatewithlang/{lang}",method=RequestMethod.GET)
	public ModelAndView loadmenuitemtotranslatewithlang(@PathVariable("lang") String lang,HttpSession session,HttpServletResponse response)
	{
		List<MenuItemLangMap> menutranslatinItem = new ArrayList<MenuItemLangMap>();
		String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);	
		System.out.println("selLang="+lang);
		logger.debug("in loadmenuitemtotranslatewithlang...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		menutranslatinItem=menuItemTranslationService.getAllMenuItemforTranslation(customer.getStoreId(),lang);
		session.setAttribute("categoryTree", menutranslatinItem);
		//List<MenuCategory> menuCatList=(List<MenuCategory>) session.getAttribute("sescategoryList");
		//MenuCategory menucategory = null;
		//menucategory=menuCatList.get(0);
		//List<MenuCategory> menusubcategoryList=menuItemTranslationService.getMenuSubCategoryByStoreId(customer.getStoreId(),menucategory.getId());
		//List<FmcgUnit> fmcgList=menuItemTranslationService.getFmcgUnitByStoreId(customer.getStoreId());
		//mav.addObject("menucatid",menuCatList.get(0).getId());
		//mav.addObject("menucatList",menuCatList);
		//mav.addObject("menusubcatList",menusubcategoryList);
		mav.addObject("allmenuTree",menutranslatinItem);
		//mav.addObject("fmcgList",fmcgList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_MENU_ITEMS_TRANSLATION_PAGE);
		
		return mav;
	}*/
/*	@RequestMapping(value="/addmenuitems",method=RequestMethod.POST)
	public void addMenuItems(@RequestBody String menuItemString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addmenuitems......{}",menuItemString);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuItems menuItem =gson.fromJson(menuItemString, new TypeToken<MenuItems>() {
			}.getType());
			MenuCategory menuCategory=new MenuCategory();
			menuCategory.setId(catId);
			MenuItems menuItems=new MenuItems();
			menuItems.setMenucategory(menuCategory);
			menuItems.setName(name);
			menuItems.setDescription(desc);
			menuItems.setPrice(price);
			menuItems.setVat(vat);
			menuItems.setServiceTax(stax);
			menuItems.setVeg(type);
			menuItems.setSpicy(spicy);
			menuItems.setPromotionFlag(promo);
			menuItems.setPromotionDesc(promodesc);
			menuItems.setPromotionValue(promovalue);
			menuItems.setStoreId(customer.getStoreId());
			menuItems.setCookingTimeInMins(cookingtime);
			menuItems.setUnit(unit);
			String res=menumgntService.addMenuItems(menuItem);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}*/
	
	//addmenuitempost
	@RequestMapping(value="/addmenuitems",method=RequestMethod.POST)
	public void addMenuItems(@RequestBody String menuItemString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addMenuItems......{}",menuItemString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");	
			Gson gson = new GsonBuilder().create();
			MenuItems menuItem =gson.fromJson(menuItemString, new TypeToken<MenuItems>() {
			}.getType());
			menuItem.setStoreId(customer.getStoreId());
			String res=menuItemTranslationService.addMenuItems(menuItem);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/addsplnote",method=RequestMethod.POST)
	public void addsplnote(@RequestBody String MenusplItem,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In addmenuitems......{}",MenusplItem);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			//String bgc="#"+bgColor;
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuItems menuItem =gson.fromJson(MenusplItem, new TypeToken<MenuItems>() {
			}.getType());
			
			/*MenuItems menuItems=new MenuItems();
			menuItems.setStoreId(customer.getStoreId());*/
			String res=menuItemTranslationService.addMenuItems(menuItem);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/translatemenuitems",method=RequestMethod.POST)
	public void addMenuItems(@RequestBody String translatemenuitemString,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In translatemenuitems......{}",translatemenuitemString);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuItemLangMap translateMenu =gson.fromJson(translatemenuitemString, new TypeToken<MenuItemLangMap>() {
			}.getType());
			
			//MenuItems menuItems=new MenuItems();
			//menuItems.setStoreId(customer.getStoreId());
			String res=menuItemTranslationService.translateMenuItem(translateMenu);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	
	/*@RequestMapping(value="/editsplnote",method=RequestMethod.POST)
	public void editsplnote(@RequestBody String menuSplItemEditString,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In editmenuitems......{}",menuSplItemEditString);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			//String bgc="#"+bgColor;
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuItems menuItem =gson.fromJson(menuSplItemEditString, new TypeToken<MenuItems>() {
			}.getType());
			
			MenuItems menuItems=new MenuItems();
			menuItems.setStoreId(customer.getStoreId());
			String res=menuItemTranslationService.translateMenuItem(menuItem);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}*/
	@RequestMapping(value="/deletemenuitems",method=RequestMethod.POST)
	public void deleteMenuItems(@RequestBody String MenuItemsString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deletemenuitems......{}",MenuItemsString);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuItems menuItems =gson.fromJson(MenuItemsString, new TypeToken<MenuItems>() {
			}.getType());
			/*MenuCategory menuCategory=new MenuCategory();
			menuCategory.setId(subcatId);
			MenuItems menuItems=new MenuItems();
			menuItems.setId(id);
			menuItems.setMenucategory(menuCategory);*/
			
			menuItems.setStoreId(customer.getStoreId());
			String res=menuItemTranslationService.deleteMenuItems(menuItems);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/deleteSplNote/{id}",method=RequestMethod.GET)
	public void deleteSplNote(@PathVariable("id") int id,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In deletemenuitems......{}",id);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			//MenuCategory menuCategory=new MenuCategory();
			//menuCategory.setId(subcatId);
			MenuItems menuItems=new MenuItems();
			menuItems.setId(id);
			//menuItems.setMenucategory(menuCategory);
			
			menuItems.setStoreId(customer.getStoreId());
			String res=menuItemTranslationService.deleteMenuItems(menuItems);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/getItemDetailsById/{id}/{storeId}",method=RequestMethod.GET)
	public void getItemDetailsById(@PathVariable("id") int id,@PathVariable("storeId") int storeId,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In getItemDetailsById......{},{}",id,storeId);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			//MenuCategory menuCategory=new MenuCategory();
			//menuCategory.setId(subcatId);
			MenuItems menuItems=new MenuItems();
			menuItems.setId(id);
			//menuItems.setMenucategory(menuCategory);
			
			menuItems.setStoreId(customer.getStoreId());
			MenuItems res=menuItemTranslationService.getItemDetailsById(id,storeId);
			Gson gson = new Gson();
			String gresponse=gson.toJson(res);
			System.out.println("res:"+gresponse);
			out.print(gresponse);
			out.flush();
		}
	}
	@RequestMapping(value="/getsubcategorylistbycategory/{catid}",method=RequestMethod.GET)
	public void deleteMenuItems(@PathVariable("catid") int catid,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In getsubcategorylistbycategory......{}",catid);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(menuItemTranslationService.getMenuSubCategoryListByStoreId(customer.getStoreId(), catid));
			out.flush();
		}
	}
	
	@RequestMapping(value="/autocomplete",method=RequestMethod.GET)
	public List<MenuItems> getAutocompleteList(@RequestParam String tagName,HttpSession session,HttpServletResponse response) throws IOException
	
	{
		System.out.println("in autocomplete.."+tagName);
		MenuCategory menuCategory=(MenuCategory) session.getAttribute("categoryTree");
		List<MenuItems> itemList=new ArrayList<MenuItems>();
		List<MenuCategory> allMenuCat=menuCategory.getMenucategory();
		Iterator<MenuCategory> allMenuCatItr=allMenuCat.iterator();
		while(allMenuCatItr.hasNext())
		{
			MenuCategory submenuCat=allMenuCatItr.next();
			List<MenuCategory> allsubMenuCat=submenuCat.getMenucategory();
			Iterator<MenuCategory> allsubMenuCatItr=allsubMenuCat.iterator();
			while(allsubMenuCatItr.hasNext())
			{
				MenuCategory menuItems=allsubMenuCatItr.next();
				List<MenuItems> allItems=menuItems.getItems();
				Iterator<MenuItems> allitemCatItr=allItems.iterator();
				while(allitemCatItr.hasNext())
				{
					MenuItems items=allitemCatItr.next();
					items.setMenucatId(submenuCat.getId());
					items.setMenucatName(submenuCat.getMenuCategoryName());
					items.setSubmenucatId(menuItems.getId());
					items.setSubmenucatName(menuItems.getMenuCategoryName());
					itemList.add(items);
					//System.out.println("menu Items :"+items);
				}
			}
		}
		System.out.println("menu Items List size:"+itemList);
		session.setAttribute("totalitemList", itemList);
		List<MenuItems> newItemList=new ArrayList<MenuItems>();
		for(MenuItems items:itemList)
		{
			if(StringUtils.startsWithIgnoreCase(items.getName(), tagName))
			{
				newItemList.add(items);
			}
		}
		System.out.println("menu Items List :"+newItemList);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson=new Gson();
		out.print(gson.toJson(newItemList));
		return null;
	}
	@RequestMapping(value="/loadmenuitemsbyid",method=RequestMethod.GET)
	public ModelAndView loadMenuItemsById(@RequestParam int itemid,HttpSession session)
	{
		logger.debug("in loadmenuitemsbyid...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<MenuItems> itemList=(List<MenuItems>) session.getAttribute("totalitemList");
		for(MenuItems items:itemList)
		{
			if(items.getId()==itemid)
			{
				mav.addObject("singleMenuItem",items);
			}
		}
		List<MenuCategory> menuCatList=(List<MenuCategory>) session.getAttribute("sescategoryList");
		//MenuCategory menuCategory=(MenuCategory) session.getAttribute("categoryTree");
		//mav.addObject("allmenuTreeforSingle",menuCategory);
		//mav.addObject("menucatid",menuCatList.get(0).getId());
		MenuCategory menucategory = null;
		menucategory=menuCatList.get(0);
		List<MenuCategory> menusubcategoryList=menuItemTranslationService.getMenuSubCategoryByStoreId(customer.getStoreId(),menucategory.getId());
		List<FmcgUnit> fmcgList=menuItemTranslationService.getFmcgUnitByStoreId(customer.getStoreId());
		//mav.addObject("menucatid",menuCatList.get(0).getId());
		mav.addObject("menucatList",menuCatList);
		mav.addObject("menusubcatList",menusubcategoryList);
		mav.addObject("fmcgList",fmcgList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_MENU_ITEMS_PAGE);
		
		return mav;
	}
	
	@RequestMapping(value="/loadspecialnotes",method=RequestMethod.GET)
	public ModelAndView loadSpecialNotes(@RequestParam String itemid,@RequestParam String itemname,HttpSession session)
	{
		logger.debug("in loadspecialnotes...{},{} ",itemid,itemname);
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		MenuCategory menuCategory=menuItemTranslationService.getAllSplNoteTree(customer.getStoreId(), NumberUtils.toInt(itemid));
		mav.addObject("allsplnoteTree",menuCategory);
		mav.addObject("itemidforspnote",itemid);
		mav.addObject("itemnameforspnote",itemname);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_SPECIAL_NOTE_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/loadallspecialnotes",method=RequestMethod.GET)
	public ModelAndView loadallspecialnotes(HttpSession session)
	{
		logger.debug("in loadallspecialnotes...{},{} ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		MenuCategory menuCategory=menuItemTranslationService.getSpecialNoteforMgnt(customer.getStoreId());
		MenuCategory menuCategory1=menuItemTranslationService.getAllMenuTree(customer.getStoreId());
		session.setAttribute("categoryTree", menuCategory1);
		List<MenuCategory> menuCatList=(List<MenuCategory>) session.getAttribute("sescategoryList");
		MenuCategory menucategory = null;
		MenuCategory menucatsplnote=menuItemTranslationService.getSpecialNoteByStore(customer.getStoreId());
		logger.debug("in loadallspecialnotes...{}",menucatsplnote);
		menucategory=menuCatList.get(0);
		List<MenuCategory> menusubcategoryList=menuItemTranslationService.getMenuSubCategoryByStoreId(customer.getStoreId(),menucategory.getId());
		List<FmcgUnit> fmcgList=menuItemTranslationService.getFmcgUnitByStoreId(customer.getStoreId());
		List<ColorMaster> colorList=menuItemTranslationService.getallColor();
		//mav.addObject("menucatid",menuCatList.get(0).getId());
		mav.addObject("menucatList",menuCatList);
		mav.addObject("colorList",colorList);
		mav.addObject("menusubcatList",menusubcategoryList);
		mav.addObject("allmenuTree",menuCategory);
		mav.addObject("splnote",menucatsplnote);
		mav.addObject("fmcgList",fmcgList);
		/*----------*/
		mav.addObject("allsplnoteTree",menuCategory);
		/*mav.addObject("itemidforspnote",itemid);*/
		//mav.addObject("itemnameforspnote",itemname);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_ALL_SPECIAL_NOTE_PAGE);
		return mav;
	}
	@RequestMapping(value="/addspecialnote/{itemid}/{spnotearr}",method=RequestMethod.GET)
	public void addSpecialNote(@PathVariable("itemid") String itemid,@PathVariable("spnotearr") String[] spnotearr,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In addspecialnote......{},{}",itemid,spnotearr.toString());
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<MenuItemNotes> menuitemnoteList=new ArrayList<MenuItemNotes>();
			for(int i=0;i<spnotearr.length;i++)
			{
				MenuItemNotes itemNotes=new MenuItemNotes();
				MenuItems menuItem=new MenuItems();
				menuItem.setId(NumberUtils.toInt(spnotearr[i]));
				itemNotes.setStoreId(customer.getStoreId());
				itemNotes.setFoodItemIds(NumberUtils.toInt(itemid));
				itemNotes.setMenuItem(menuItem);
				menuitemnoteList.add(itemNotes);
			}
			SpecialNoteListContainer splnotelistContainer=new SpecialNoteListContainer();
			splnotelistContainer.setMenuItemNotes(menuitemnoteList);
			splnotelistContainer.setItemId(NumberUtils.toInt(itemid));
			splnotelistContainer.setStoreId(customer.getStoreId());
			
			String res=menuItemTranslationService.addSpecialNote(splnotelistContainer);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/getallinstalledprinters",method=RequestMethod.GET)
	public void getallInstalledPrinters(HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In getallinstalledprinters......{}");
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(menuItemTranslationService.getInstalledPrinters());
			out.flush();
		}
	}
	@RequestMapping(value="/assignkotprinter/{cuisineid}/{printerloc}/{printername}/{kitchenname}",method=RequestMethod.GET)
	public void assignKotPrinters(@PathVariable("cuisineid") int cuisineid,@PathVariable("printerloc") String printerloc,@PathVariable("printername") String printername,@PathVariable("kitchenname") String kitchenname,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In assignkotprinter......{},{},{},{}",cuisineid,printerloc,printername,kitchenname);
		printerloc=StringUtils.replace(printerloc, "|", "\\");
		System.out.println("printerloc:"+printerloc);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			PrintKotMaster kotMaster=new PrintKotMaster();
			kotMaster.setPrinterIp(printerloc);
			kotMaster.setCuisineTypeId(cuisineid);
			kotMaster.setName(printername);
			kotMaster.setKitchenLocation(kitchenname);
			kotMaster.setStoreId(customer.getStoreId());
			String res=menuItemTranslationService.assignPrinter(kotMaster);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/getallserverprinters",method=RequestMethod.GET)
	public void getallSeverPrinters(HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In getallserverprinters......{}");
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(menuItemTranslationService.getAllServerPrinters(customer.getStoreId()));
			out.flush();
		}
	}
	@RequestMapping(value="/assignkotprintertoitem/{itemid}/{printerloc1}/{printerloc2}/{printerloc3}",method=RequestMethod.GET)
	public void assignKotPrintersToItem(@PathVariable("itemid") int itemid,@PathVariable("printerloc1") String printerloc1,@PathVariable("printerloc2") String printerloc2,@PathVariable("printerloc3") String printerloc3,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In assignkotprintertoitem......{},{},{},{}",itemid,printerloc1,printerloc2,printerloc3);
		
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String printerList="";
			printerList=printerloc1+"~"+printerloc2+"~"+printerloc3;
			System.out.println("printerList:"+printerList);
			//String res="success";
			String res=menuItemTranslationService.assignPrinterToItem(itemid, printerList);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	/*@RequestMapping(value="/assignkotprinter",method=RequestMethod.POST)
	public void assignKotPrinters(@ModelAttribute("printKotMaster") PrintKotMaster prinMaster,HttpSession session,HttpServletResponse response) throws IOException
	{
		//logger.debug("In assignkotprinter......{},{},{},{}",cuisineid,printerloc,printername,kitchenname);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			PrintKotMaster kotMaster=new PrintKotMaster();
			kotMaster.setPrinterIp(prinMaster.getPrinterIp());
			kotMaster.setCuisineTypeId(prinMaster.getCuisineTypeId());
			kotMaster.setName(prinMaster.getName());
			kotMaster.setKitchenLocation(prinMaster.getKitchenLocation());
			kotMaster.setStoreId(customer.getStoreId());
			String res=menumgntService.assignPrinter(kotMaster);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}*/
	@RequestMapping(value="/viewmenuitemupload",method=RequestMethod.GET)
	public ModelAndView loadMenuItemUpload(Model model,HttpSession session)
	{
		logger.debug("In viewmenuitemupload......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_UPLOAD_MENU_ITEM_PAGE);
		return mav;
	}
	@RequestMapping(value="/uploadmenuitem",method=RequestMethod.POST)
	public ModelAndView uploadMenuItem(@Valid @ModelAttribute("menufile") MenuFile menuFile, @RequestParam MultipartFile fileUpload,HttpSession session,HttpServletResponse response,HttpServletRequest request,BindingResult result)
	{
		logger.debug("in uploadmenuitem...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		InputStream inputFile = null;
		byte[] byteArr=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		if (fileUpload != null && fileUpload.getSize() > 0) {
			try{
				System.out.println("file name:"+fileUpload.getName());
				System.out.println("original file name:"+fileUpload.getOriginalFilename());
				System.out.println("file size:"+fileUpload.getSize());
				inputFile=fileUpload.getInputStream();
				byteArr=fileUpload.getBytes();
				System.out.println("inputsterm:"+inputFile);
				System.out.println("byte arr:"+byteArr);
				String uploadsDir = "/uploads/";
                String realPathtoUploads =  request.getServletContext().getRealPath(uploadsDir);
                if(! new File(realPathtoUploads).exists())
                {
                    new File(realPathtoUploads).mkdir();
                }
				
				System.out.println("path:"+realPathtoUploads);
				String orgName = fileUpload.getOriginalFilename();
                String filePath = realPathtoUploads +"/"+ orgName;
                File dest = new File(filePath);
                fileUpload.transferTo(dest);
				
				//MenuFile menuFile=new MenuFile();
				menuFile.setStoreId(customer.getStoreId());
				menuFile.setFileName(fileUpload.getOriginalFilename());
				
				FileDataBodyPart filePart = new FileDataBodyPart("file", new File(filePath));
				filePart.setContentDisposition(FormDataContentDisposition.name("file").fileName(fileUpload.getOriginalFilename()).build());
				MultiPart multipartEntity = new FormDataMultiPart().field("menuFile", new Gson().toJson(menuFile), MediaType.APPLICATION_JSON_TYPE).bodyPart(filePart);   
				
				String res=menuItemTranslationService.uploadMenuItems(menuFile,multipartEntity);
				System.out.println("result:"+res);
				mav.addObject("msg",res);
				//inputFile.close();
			}catch (Exception e) {
				logger.error("File uploading problem: ", e);
			}
		}
		else
		{
			result.reject("NotEmpty.menuitemupload.file");
		}
		mav.setViewName(ForwardConstants.VIEW_UPLOAD_MENU_ITEM_PAGE);
		return mav;
	}
}