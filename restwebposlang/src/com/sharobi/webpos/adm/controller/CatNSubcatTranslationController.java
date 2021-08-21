/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.MenuCategoryLangMap;
import com.sharobi.webpos.adm.model.MenuItemLangMap;
import com.sharobi.webpos.adm.model.MenuItems;
import com.sharobi.webpos.adm.service.CatNSubcatTranslationService;
import com.sharobi.webpos.base.service.LanguageService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Language;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;


/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/catNSubcattranslation")
public class CatNSubcatTranslationController {
	private final static Logger logger=LogManager.getLogger(CatNSubcatTranslationController.class);
	@Autowired CatNSubcatTranslationService catnsubcatTranslationService;
	@Autowired LanguageService languageService;
	
	@RequestMapping(value="/loadmenucatnsubcattotranslatewithlang",method=RequestMethod.GET)
	public ModelAndView loadmenucatnsubcattotranslatewithlang(@RequestParam String lang, HttpSession session,Model model)
	{
		List<MenuCategoryLangMap> catnSubcattotranslate = new ArrayList<MenuCategoryLangMap>();
		List<Language> languages = new ArrayList<>();		
		logger.debug("in loadmenucatnsubcattotranslatewithlang...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		catnSubcattotranslate = catnsubcatTranslationService.getAllCatnSubcatforTranslation(customer.getStoreId(), lang);
		languages=languageService.getLanguageListByStoreId(customer.getStoreId());

		logger.debug("all language List fetched: {}", languages);
		mav.addObject("Language",lang);
		mav.addObject("alllanguage",languages);
		//languages.stream().collect(Collectors.toMap(Language::getLanguage, x -> x));
		mav.addObject("langselected", languages.stream().collect(
                Collectors.toMap(x -> x.getLanguage().toLowerCase(), x -> x)).get(lang.toLowerCase()));
		mav.addObject("allcatnsubcatTree",catnSubcattotranslate);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_MENU_CATNSUBCAT_TRANSLATION_PAGE);
		return mav;
	}
	@RequestMapping(value="/loadmenuitemtotranslate",method=RequestMethod.GET)
	public ModelAndView loadmenuitemtotranslate(HttpSession session)
	{
		List<MenuItemLangMap> menutranslatinItem = new ArrayList<MenuItemLangMap>();
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
		//menutranslatinItem=catnsubcatTranslationService.getAllMenuItemforTranslation(customer.getStoreId(),selLang);
		mav.addObject("allmenuTree",menutranslatinItem);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_MENU_ITEMS_TRANSLATION_PAGE);
		
		return mav;
	}
	
	@RequestMapping(value="/translatecatnsubcat",method=RequestMethod.POST)
	public void addMenuItems(@RequestBody String translatecatnsubcatString,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In translatecatnsubcat......{}",translatecatnsubcatString);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			MenuCategoryLangMap translateMenuCatnSubcat =gson.fromJson(translatecatnsubcatString, new TypeToken<MenuCategoryLangMap>() {
			}.getType());
			
			//MenuItems menuItems=new MenuItems();
			//menuItems.setStoreId(customer.getStoreId());
			String res=catnsubcatTranslationService.translateMenuItem(translateMenuCatnSubcat);
			//System.out.println("res:"+res);
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
			MenuItems res=catnsubcatTranslationService.getItemDetailsById(id,storeId);
			Gson gson = new Gson();
			String gresponse=gson.toJson(res);
			System.out.println("res:"+gresponse);
			out.print(gresponse);
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
		//System.out.println("menu Items List :"+newItemList);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson=new Gson();
		out.print(gson.toJson(newItemList));
		return null;
	}

}
