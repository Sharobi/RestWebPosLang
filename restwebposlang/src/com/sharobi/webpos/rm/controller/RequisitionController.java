package com.sharobi.webpos.rm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrder;
import com.sharobi.webpos.inv.model.InventoryPurchaseOrderItems;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.rm.model.EstimateDailyProd;
import com.sharobi.webpos.rm.model.Ingredient;
import com.sharobi.webpos.rm.service.RequisitionService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/requisition")
public class RequisitionController {
	private final static Logger logger = LogManager.getLogger(RequisitionController.class);
	@Autowired RequisitionService requisitionService;
	@Autowired InventoryService inventoryService;
	@Autowired InventoryMgntService inventorymgntService;

	@RequestMapping(value = "/loadrequisition",
					method = RequestMethod.GET)
	public ModelAndView loadRecipeIngredients(	Model model,
												HttpSession session) {

		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			Date currDate = new Date();
			List<EstimateDailyProd> edpList = requisitionService.getRequisitionByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
			mav.addObject("edpList", edpList);
			mav.addObject("today", currDate);
			List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
			logger.debug("Fetched vendorList :: {}", vendorList);
			mav.addObject("vendorList", vendorList);
			List<MetricUnit> metricUnitList = inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_REQUISITION_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/getrequisitionbydateandstoreid",
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
			
			List<EstimateDailyProd> edpList = requisitionService.getRequisitionByDate(customer.getStoreId(), estimateDailyProd.getDate());
			mav.addObject("edpList", edpList);
			mav.addObject("today", date);
			List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
			logger.debug("Fetched vendorList :: {}", vendorList);
			mav.addObject("vendorList", vendorList);
			List<MetricUnit> metricUnitList = inventorymgntService.getInvItemUnitList();
			mav.addObject("metricUnitList", metricUnitList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_REQUISITION_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/getrequisitionbyids/{edpid}/{poId}",
					method = RequestMethod.GET)
	public ModelAndView getRequisitionByIds(@PathVariable("edpid") String edpid,
											@PathVariable("poId") String poId,
											Model model,
											HttpSession session,
											HttpServletRequest request,
											HttpServletResponse response) throws IOException {
		logger.debug("In getRequisitionByIds  Details......{},{}", edpid, poId);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryPurchaseOrderItems> dailyProdItems = requisitionService.getRequisitionByIds(customer.getStoreId(), edpid, poId);
		logger.debug("dailyProdItems in controller :: {}", dailyProdItems);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		out.print(new Gson().toJson(dailyProdItems).toString());
		return null;
	}

	@RequestMapping(value = "/getrequisitionbyidsandpoidzero/{edpid}/{poId}",
					method = RequestMethod.GET)
	public ModelAndView getRequisitionByIdsAndPoidZero(	@PathVariable("edpid") String edpid,
														@PathVariable("poId") String poId,
														Model model,
														HttpSession session,
														HttpServletRequest request,
														HttpServletResponse response) throws IOException {
		logger.debug("In getRequisitionByIdsAndPoidZero  Details......{},{}", edpid, poId);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<Ingredient> dailyProdItems = requisitionService.getRequisitionByIdsAndPoidZero(customer.getStoreId(), edpid, poId);
		logger.debug("dailyProdItems in controller :: {}", dailyProdItems);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		out.print(new Gson().toJson(dailyProdItems).toString());
		return null;
	}

	@RequestMapping(value = "/createnewpurchaseorder",
					method = RequestMethod.POST)
	public void createNewPurchaseOrder(	@RequestBody String invPOOrder,
										HttpSession session,
										HttpServletResponse response) throws IOException {
		logger.debug("in createnewpurchaseorder...{}", invPOOrder);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Date currDate = new Date();
			String s = "";
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			InventoryPurchaseOrder purchaseOrder = gson.fromJson(invPOOrder, new TypeToken<InventoryPurchaseOrder>() {}.getType());
			for (InventoryPurchaseOrderItems invPurchaseOrderItems : purchaseOrder.getInventoryPurchaseOrderItems()) {
				invPurchaseOrderItems.setStoreId(customer.getStoreId());
				invPurchaseOrderItems.setCreatedBy(customer.getContactNo());
			}
			purchaseOrder.setDate(Utility.getFormatedDateShort(currDate));
			purchaseOrder.setUserId(customer.getContactNo());
			purchaseOrder.setTime(Utility.getFormatedDateShort(currDate));
			purchaseOrder.setStoreId(customer.getStoreId());
			purchaseOrder.setCreatedBy(customer.getContactNo());
			if (purchaseOrder.getId() == 0) {
				s = inventoryService.createInventoryPurchaseOrder(purchaseOrder);
			} else {
				s = inventoryService.updateInventoryPurchaseOrder(purchaseOrder);
			}
			out.print(s);
			out.flush();
		}
	}
	
	// new added 8th May 2018
	
	@RequestMapping(value = "/getrequisitionbyidsnew/{edpid}/{poId}",
			method = RequestMethod.GET)
public ModelAndView newgetRequisitionByIds(@PathVariable("edpid") String edpid,
									@PathVariable("poId") String poId,
									Model model,
									HttpSession session,
									HttpServletRequest request,
									HttpServletResponse response) throws IOException {
      logger.debug("In new getRequisitionByIds  Details......{},{}", edpid, poId);
      Customer customer = null;
     if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	      ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
	      return mav;
       }
     List<InventoryPurchaseOrder> dailyProdItems = requisitionService.newgetRequisitionByIds(customer.getStoreId(), edpid, poId);
     logger.debug("dailyProdItems in controller :: {}", dailyProdItems);
     PrintWriter out = response.getWriter();
     response.setContentType("application/json");
     out.print(new Gson().toJson(dailyProdItems).toString());
     return null;
     }
	
	
	
	
	
	
}
