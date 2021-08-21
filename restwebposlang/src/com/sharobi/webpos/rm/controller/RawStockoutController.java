package com.sharobi.webpos.rm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.inv.model.InventoryStockOut;
import com.sharobi.webpos.inv.model.InventoryStockOutItems;
import com.sharobi.webpos.rm.model.EstimateDailyProd;
import com.sharobi.webpos.rm.model.Ingredient;
import com.sharobi.webpos.rm.service.RawStockoutService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/rawstockout")
public class RawStockoutController {
	private final static Logger logger = LogManager.getLogger(RawStockoutController.class);
	@Autowired RawStockoutService rawStockoutService;
	@Autowired MenuMgntService menumgntService;

	@RequestMapping(value = "/loadrawstockout",
					method = RequestMethod.GET)
	public ModelAndView loadRawStockOut(Model model,
										HttpSession session) {

		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			Date currDate = new Date();
			mav.addObject("today", currDate);
			List<EstimateDailyProd> edpList = rawStockoutService.getRawStockoutByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
			mav.addObject("edpList", edpList);
			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			session.setAttribute("menucategoryList", menucategoryList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_RAWSTOCKOUT_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/getrawstockoutbydateandstoreid",
					method = RequestMethod.POST)
	public ModelAndView getrequisitionbydateandstoreid(	@ModelAttribute("estimateDailyProd") EstimateDailyProd estimateDailyProd,
														Model model,
														HttpSession session) {
		System.out.println("estimateDailyProd.getDate()=" + estimateDailyProd.getDate());
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		String pattern = "yyyy-MM-dd";
		Date date = null;
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		try {
			date = format.parse(estimateDailyProd.getDate());
			System.out.println(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			List<EstimateDailyProd> edpList = rawStockoutService.getRawStockoutByDate(customer.getStoreId(), estimateDailyProd.getDate());
			mav.addObject("edpList", edpList);
			mav.addObject("today", date);
			//			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			//			mav.addObject("sescategoryList", menucategoryList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_RAWSTOCKOUT_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/getrawstockoutitems",
					method = RequestMethod.GET)
	public ModelAndView getIngredientsForEdp(	@RequestParam("edpid") String edpid,
												@RequestParam("rawstockoutid") String rawstockoutid,
												Model model,
												HttpSession session,
												HttpServletResponse response) throws IOException {

		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			
			List<InventoryStockOutItems> inventoryStockOutItems = rawStockoutService.getRawStockoutByID(customer.getStoreId(), edpid, rawstockoutid);
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			out.print(new Gson().toJson(inventoryStockOutItems).toString());
			return null;
		}
	}

	@RequestMapping(value = "/getrawstockoutitemswithstockoutidzero",
					method = RequestMethod.GET)
	public ModelAndView getrawstockoutitemswithstockoutidzero(	@RequestParam("edpid") String edpid,
																@RequestParam("rawstockoutid") String rawstockoutid,
																Model model,
																HttpSession session,
																HttpServletResponse response) throws IOException {

		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			
			List<Ingredient> ingredients = rawStockoutService.getRawStockoutByIDZero(customer.getStoreId(), edpid, rawstockoutid);
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			out.print(new Gson().toJson(ingredients).toString());
			return null;
		}
	}

	@RequestMapping(value = "/createstockout",
					method = RequestMethod.POST)
	public void createStockOut(	@RequestBody String invStockOut,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("in createstockout...{}", invStockOut);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			InventoryStockOut inventoryStockOut = gson.fromJson(invStockOut, new TypeToken<InventoryStockOut>() {}.getType());
			/*for (InventoryStockOutItems inventoryStockOutItem : inventoryStockOut.getInventoryStockOutItemList()) {
				InventoryItems inventoryItems = rawStockoutService.getInventoryItemDetails(customer.getStoreId(), inventoryStockOutItem.getInventoryItems().getCode().trim());
				inventoryStockOutItem.setInventoryItems(inventoryItems);
				inventoryStockOutItem.setStoreId(customer.getStoreId());
				//		inventoryStockOutItem.setTime(dateTime);
				inventoryStockOutItem.setCreatedBy(customer.getContactNo());
				//		inventoryStockOutItem.setCreatedDate(date);
				inventoryStockOutItem.setInventoryItems(inventoryItems);
				MetricUnit metricUnit = new MetricUnit();
				metricUnit.setId(inventoryStockOutItem.getUnitId());
				inventoryStockOutItem.setUnit(metricUnit);
			}*/
			//	inventoryStockOut.setDate(date);
			//	inventoryStockOut.setTime(dateTime);
			inventoryStockOut.setUserId(customer.getContactNo());
			inventoryStockOut.setStoreId(customer.getStoreId());
			inventoryStockOut.setCreatedBy(customer.getContactNo());
			//	inventoryStockOut.setCreatedDate(date);
			rawStockoutService.createNewRawStockOut(inventoryStockOut);
			out.print("success");
			out.flush();
		}
	}

	@RequestMapping(value = "/updaterawstockout",
					method = RequestMethod.POST)
	public void updaterawstockout(	@RequestBody String invStockOutitems,
									HttpSession session,
									HttpServletResponse response) throws IOException {
		logger.debug("in updaterawstockout...{}", invStockOutitems);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			InventoryStockOutItems inventoryStockOutItems = gson.fromJson(invStockOutitems, new TypeToken<InventoryStockOutItems>() {}.getType());
			/*for (InventoryStockOutItems inventoryStockOutItem : inventoryStockOut.getInventoryStockOutItemList()) {
				InventoryItems inventoryItems = rawStockoutService.getInventoryItemDetails(customer.getStoreId(), inventoryStockOutItem.getInventoryItems().getCode().trim());
				inventoryStockOutItem.setInventoryItems(inventoryItems);
				inventoryStockOutItem.setStoreId(customer.getStoreId());
				//		inventoryStockOutItem.setTime(dateTime);
				inventoryStockOutItem.setCreatedBy(customer.getContactNo());
				//		inventoryStockOutItem.setCreatedDate(date);
				inventoryStockOutItem.setInventoryItems(inventoryItems);
				MetricUnit metricUnit = new MetricUnit();
				metricUnit.setId(inventoryStockOutItem.getUnitId());
				inventoryStockOutItem.setUnit(metricUnit);
			}*/
			//	inventoryStockOut.setDate(date);
			//	inventoryStockOut.setTime(dateTime);
			inventoryStockOutItems.setStoreId(customer.getStoreId());
			inventoryStockOutItems.setCreatedBy(customer.getContactNo());
			//	inventoryStockOut.setCreatedDate(date);
			rawStockoutService.updateExistingStockOUT(inventoryStockOutItems);
			out.print("success");
			out.flush();
		}
	}

	@RequestMapping(value = "/approverawstockout",
					method = RequestMethod.GET)
	public ModelAndView approveRawStockout(	@RequestParam("rawstockoutid") String rawstockoutid,
											@RequestParam("storeid") String storeid,
											@RequestParam("approveby") String approveby,
											@RequestParam("updatedby") String updatedby,
											@RequestParam("updateddate") String updateddate,
											Model model,
											HttpSession session,
											HttpServletResponse response) throws IOException {

		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			String s = rawStockoutService.getApproveRawStockout(rawstockoutid, storeid, approveby, updatedby, updateddate);
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			out.print(s);
			return null;
		}
	}

	@RequestMapping(value = "/deleterawstockout",
					method = RequestMethod.GET)
	public ModelAndView deleteRawStockout(	@RequestParam("rawstockoutid") String rawstockoutid,
	                                      	@RequestParam("rawstockoutitemid") String rawstockoutitemid,
											@RequestParam("storeid") String storeid,
											Model model,
											HttpSession session,
											HttpServletResponse response) throws IOException {

		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			String s = rawStockoutService.deleteRawStockoutItem(rawstockoutid, rawstockoutitemid, storeid);
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			out.print(s);
			return null;
		}
	}
}
