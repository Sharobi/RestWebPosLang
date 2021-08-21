/**
 * 
 */
package com.sharobi.webpos.rm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.model.MenuItems;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.MenuItem;
import com.sharobi.webpos.rm.model.EstimateDailyProd;
import com.sharobi.webpos.rm.model.EstimateDailyProdItem;
import com.sharobi.webpos.rm.model.Ingredient;
import com.sharobi.webpos.rm.service.EDPService;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

/**
 * @author habib
 *
 */

@Controller
@RequestMapping("/edp")
public class EDPController {
	
	private final static Logger logger = LogManager.getLogger(EDPController.class);
	@Autowired EDPService edpService ;
	@Autowired MenuMgntService menumgntService ;
	
	@RequestMapping(value = "/loadedp",method = RequestMethod.GET)
	public ModelAndView loadRecipeIngredients(	Model model,HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			Date currDate = new Date();
			List<EstimateDailyProd> edpList=edpService.getAllEDPByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
			mav.addObject("edpList", edpList);
			mav.addObject("today", currDate);
			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			mav.addObject("menucategoryList", menucategoryList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_EDP_PAGE);
			return mav;
		}
	}
	@RequestMapping(value = "/getedpbydateandstoreid",method = RequestMethod.POST)
public ModelAndView getedpbydateandstoreid(	@ModelAttribute("estimateDailyProd") EstimateDailyProd estimateDailyProd,
												Model model,
												HttpSession session) {
		logger.info("estimateDailyProd.getDate()=" + estimateDailyProd.getDate());
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		String pattern = "yyyy-MM-dd";
		Date date = null;
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		try {
			date = format.parse(estimateDailyProd.getDate());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			List<EstimateDailyProd> edpList = edpService.getAllEDPByDate(customer.getStoreId(), estimateDailyProd.getDate());
			mav.addObject("edpList", edpList);
			mav.addObject("today", date);
			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			mav.addObject("menucategoryList", menucategoryList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_EDP_PAGE);
			return mav;
		}
	}	
	@RequestMapping(value = "/getedpbystoreidandid",method = RequestMethod.GET)
	public ModelAndView getEstimateDailyProdByStoreIdAndId(@RequestParam("edpid") String edpid,	Model model,HttpSession session,HttpServletResponse response) throws IOException {
		
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			
			List<EstimateDailyProdItem> edpListitem=edpService.getEstimateDailyProdByStoreIdAndId(customer.getStoreId(), edpid);
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			out.print(new Gson().toJson(edpListitem).toString());
			return null;
		}
	}
	
	@RequestMapping(value = "/getingredientsforedp",method = RequestMethod.GET)
	public ModelAndView getIngredientsForEdp(@RequestParam("edpid") String edpid,	Model model,HttpSession session,HttpServletResponse response) throws IOException {
		
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			
			List<Ingredient> ingredients=edpService.getIngredientsForEdp(customer.getStoreId(), edpid);
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			out.print(new Gson().toJson(ingredients).toString());
			return null;
		}
	} 
	
	@RequestMapping(value = "/deleteedpitem",method = RequestMethod.GET)
	public ModelAndView deleteEstimateDailyProdItem(@RequestParam("id") String id,@RequestParam("edpid") String edpid,	Model model,HttpSession session,HttpServletResponse response) throws IOException {
		
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			String s=edpService.deleteEstimateDailyProdItem(customer.getStoreId(),id, edpid);
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			out.print(s);
			return null;
		}
	}
	
	@RequestMapping(value="/getallmenuitems",method=RequestMethod.GET)
	public List<MenuItems> getAllmenuItems(HttpSession session,HttpServletResponse response) throws IOException
	
	{
		
		Menu menuCategory=(Menu) session.getAttribute(Constants.SES_ALL_MENU_RECEIPE);
		List<MenuItem> itemList=new ArrayList<MenuItem>();
		List<Menu> allMenuCat=menuCategory.getMenucategory();
		Iterator<Menu> allMenuCatItr=allMenuCat.iterator();
		while(allMenuCatItr.hasNext())
		{
			Menu submenuCat=allMenuCatItr.next();
			List<Menu> allsubMenuCat=submenuCat.getMenucategory();
			Iterator<Menu> allsubMenuCatItr=allsubMenuCat.iterator();
			while(allsubMenuCatItr.hasNext())
			{
				Menu menuItems=allsubMenuCatItr.next();
				List<MenuItem> allItems=menuItems.getItems();
				Iterator<MenuItem> allitemCatItr=allItems.iterator();
				while(allitemCatItr.hasNext())
				{
					MenuItem items=allitemCatItr.next();
					items.setCategoryId(submenuCat.getId());
					items.setCategoryName(submenuCat.getMenuCategoryName());
					items.setSubCategoryId(menuItems.getId());
					items.setSubCategoryName(menuItems.getMenuCategoryName());
					itemList.add(items);
				}
			}
		}
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson=new Gson();
		out.print(gson.toJson(itemList));
		return null;
	}
	
	@RequestMapping(value="/getallmenuitemslayoff",method=RequestMethod.GET)
	public List<MenuItems> getAllmenuItemslayoff(HttpSession session,HttpServletResponse response) throws IOException
	
	{
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			return null;
		}
		Menu menuCategory=edpService.getAllMenuLayoffListForRM(customer.getStoreId());
		List<MenuItem> itemList=new ArrayList<MenuItem>();
		List<Menu> allMenuCat=menuCategory.getMenucategory();
		Iterator<Menu> allMenuCatItr=allMenuCat.iterator();
		while(allMenuCatItr.hasNext())
		{
			Menu submenuCat=allMenuCatItr.next();
			List<Menu> allsubMenuCat=submenuCat.getMenucategory();
			Iterator<Menu> allsubMenuCatItr=allsubMenuCat.iterator();
			while(allsubMenuCatItr.hasNext())
			{
				Menu menuItems=allsubMenuCatItr.next();
				List<MenuItem> allItems=menuItems.getItems();
				Iterator<MenuItem> allitemCatItr=allItems.iterator();
				while(allitemCatItr.hasNext())
				{
					MenuItem items=allitemCatItr.next();
					items.setCategoryId(submenuCat.getId());
					items.setCategoryName(submenuCat.getMenuCategoryName());
					items.setSubCategoryId(menuItems.getId());
					items.setSubCategoryName(menuItems.getMenuCategoryName());
					itemList.add(items);
				}
			}
		}
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson=new Gson();
		out.print(gson.toJson(itemList));
		return null;
	}
	
	@RequestMapping(value="/autocomplete",method=RequestMethod.GET)
	public List<MenuItems> getAutocompleteList(@RequestParam String tagName,HttpSession session,HttpServletResponse response) throws IOException
	
	{
		System.out.println("in edp autocomplete.."+tagName);
		Menu menuCategory=(Menu) session.getAttribute(Constants.SES_ALL_MENU_RECEIPE);
		List<MenuItem> itemList=new ArrayList<MenuItem>();
		List<Menu> allMenuCat=menuCategory.getMenucategory();
		Iterator<Menu> allMenuCatItr=allMenuCat.iterator();
		while(allMenuCatItr.hasNext())
		{
			Menu submenuCat=allMenuCatItr.next();
			List<Menu> allsubMenuCat=submenuCat.getMenucategory();
			Iterator<Menu> allsubMenuCatItr=allsubMenuCat.iterator();
			while(allsubMenuCatItr.hasNext())
			{
				Menu menuItems=allsubMenuCatItr.next();
				List<MenuItem> allItems=menuItems.getItems();
				Iterator<MenuItem> allitemCatItr=allItems.iterator();
				while(allitemCatItr.hasNext())
				{
					MenuItem items=allitemCatItr.next();
					items.setCategoryId(submenuCat.getId());
					items.setCategoryName(submenuCat.getMenuCategoryName());
					items.setSubCategoryId(menuItems.getId());
					items.setSubCategoryName(menuItems.getMenuCategoryName());
					itemList.add(items);
				}
			}
		}
		//System.out.println("menu Items List size:"+itemList);
		//session.setAttribute("totalitemList", itemList);
		List<MenuItem> newItemList=new ArrayList<MenuItem>();
		for(MenuItem items:itemList)
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
	
	@RequestMapping(value = "/createedp",
			method = RequestMethod.POST)
	public void createNewEDP(	@RequestBody String estimateDailyProd,
							HttpSession session,
							HttpServletResponse response) throws IOException {
		logger.debug("in createedp...{}", estimateDailyProd);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			//response.setContentType("text/plain");
//			
//			EstimateDailyProd estimateDailyProd1 = CommonResource.GSON.fromJson(estimateDailyProd, new TypeToken<EstimateDailyProd>() {}.getType());
			String s=edpService.createEDP(estimateDailyProd);
			out.print(s);
			out.flush();
		}
	}
	
	@RequestMapping(value = "/approveEDP",
			method = RequestMethod.GET)
		public ModelAndView approvedEDP(	@RequestParam String storeId,
							@RequestParam String edpid,
							@RequestParam String approveBy,
							Model model,
							HttpSession session,
							HttpServletRequest request,
							HttpServletResponse response) throws IOException {
		logger.debug("In approvedEDP......{},{},{}", storeId, edpid, approveBy);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		String s=edpService.approveEDP(storeId, edpid, approveBy);
		out.print(s);
		out.flush();
		return null;
	}
	@RequestMapping(value = "/updateedpitem",
			method = RequestMethod.POST)
	public void updateEdpItem(	@RequestBody String estimateDailyProdItem,
							HttpSession session,
							HttpServletResponse response) throws IOException {
		logger.debug("in updateedpitem...{}", estimateDailyProdItem);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			EstimateDailyProdItem estimateDailyProdItem1 = CommonResource.GSON.fromJson(estimateDailyProdItem, new TypeToken<EstimateDailyProdItem>() {}.getType());
			String s=edpService.updateEDPItem(estimateDailyProdItem1);
			out.print(s);
			out.flush();
		}
	}
	@RequestMapping(value = "/addedpitem",
			method = RequestMethod.POST)
	public void addEdpItem(	@RequestBody String estimateDailyProdItem,
							HttpSession session,
							HttpServletResponse response) throws IOException {
		logger.debug("in addedpitem...{}", estimateDailyProdItem);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			EstimateDailyProdItem estimateDailyProdItem1 = CommonResource.GSON.fromJson(estimateDailyProdItem, new TypeToken<EstimateDailyProdItem>() {}.getType());
			System.out.println("edpitem:"+estimateDailyProdItem1.toString());
			String s=edpService.addEDPItem(estimateDailyProdItem1);
			out.print(s);
			out.flush();
		}
	}
	@RequestMapping(value = "/deleteedp",
			method = RequestMethod.GET)
		public ModelAndView deleteEDP(	@RequestParam String storeId,
							@RequestParam String edpid,
							Model model,
							HttpSession session,
							HttpServletRequest request,
							HttpServletResponse response) throws IOException {
		logger.debug("In deleteedp......{},{}", storeId, edpid);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		String s=edpService.deleteEDP(storeId, edpid);
		out.print(s);
		out.flush();
		return null;
	}
	
	@RequestMapping(value = "/getoldedpbystoreid",method = RequestMethod.GET)
	public ModelAndView getoldEstimateDailyProdByStoreId(@RequestParam("oldedpdate") String oldedpdate,	Model model,HttpSession session,HttpServletResponse response) throws IOException {
		
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			
			List<EstimateDailyProd> edpList = edpService.getAllEDPByDate(customer.getStoreId(), oldedpdate);
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			out.print(new Gson().toJson(edpList).toString());
			return null;
		}
	}
}

