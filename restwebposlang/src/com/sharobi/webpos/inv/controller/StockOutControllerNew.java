package com.sharobi.webpos.inv.controller;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.inv.model.InventoryItems;
import com.sharobi.webpos.inv.model.InventoryStockOut;
import com.sharobi.webpos.inv.model.InventoryStockOutItems;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.inv.service.StockOutService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/stockoutnew")
public class StockOutControllerNew {
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private final static Logger logger = LogManager.getLogger(StockOutControllerNew.class);
	
	@Autowired StockOutService stockOutService;
	@Autowired InventoryService inventoryService;
	@Autowired InventoryMgntService inventorymgntService;

	@RequestMapping(value = "/loadstockout",
					method = RequestMethod.GET)
	public ModelAndView welcome(Model model,
								HttpSession session,
								HttpServletRequest request) throws ParseException {
		logger.debug("In loadstockin......");
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		Date currDate = new Date();
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_NEW_PAGE);
		List<InventoryStockOut> inventoryStockOutList = stockOutService.getInventoryStockOutByDateNew(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
		List<MenuCategory> menuCategoryList = stockOutService.getMenuCategoryListByStoreId(customer.getStoreId());
		Date currdate = new Date();
		String date = dateFormat.format(currdate);
		List<InventoryItems> stockoutRawItemList = stockOutService.getStockOurRawItemsByCurrentDate(customer.getStoreId(),date); 
		mav.addObject("rawItemList", stockoutRawItemList);
		Date today = dateFormat.parse(date);
		mav.addObject("today", today);
		mav.addObject("menuCategoryList", menuCategoryList);
		mav.addObject("inventoryStockOutList", inventoryStockOutList);
		int stockOutId = 0;
		if(inventoryStockOutList.size()>0){
		   for(InventoryStockOut ob: inventoryStockOutList){
		     stockOutId = ob.getId();
		     break;
		   }
		}
		mav.addObject("stockoutId",stockOutId);
		mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
		return mav;
	}
	
	@RequestMapping(value = "/loadstockoutman",
      method = RequestMethod.GET)
	public ModelAndView welcomeman(Model model,
            HttpSession session,
            HttpServletRequest request) throws ParseException {
	    logger.debug("In loadstockoutman......");
	     Customer customer = null;
      if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
        ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
        return mav;
      }
      Date currDate = new Date();
      ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_MAN_PAGE);
      List<InventoryStockOut> inventoryStockOutList = stockOutService.getInventoryStockOutByDateNew(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
      List<MenuCategory> menuCategoryList = stockOutService.getMenuCategoryListByStoreId(customer.getStoreId());
      Date currdate = new Date();
      String date = dateFormat.format(currdate);
      //List<InventoryItems> stockoutRawItemList = stockOutService.getStockOurRawItemsByCurrentDate(customer.getStoreId(),date); 
      //mav.addObject("rawItemList", stockoutRawItemList);
      Date today = dateFormat.parse(date);
      mav.addObject("today", today);
      mav.addObject("menuCategoryList", menuCategoryList);
      mav.addObject("inventoryStockOutList", inventoryStockOutList);
      int stockOutId = 0;
      if(inventoryStockOutList.size()>0){
         for(InventoryStockOut ob: inventoryStockOutList){
           stockOutId = ob.getId();
           break;
         }
        }
      mav.addObject("stockoutId",stockOutId);
      mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
      return mav;
}

	@RequestMapping(value = "/getmenucategorylist",
					method = RequestMethod.GET)
	public ModelAndView getMenuCategoryList(Model model,
											HttpSession session,
											HttpServletResponse response) throws ParseException, IOException {
		logger.debug("In getmenucategorylist......{}");
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		List<MenuCategory> menuCategoryList = stockOutService.getMenuCategoryListByStoreId(customer.getStoreId());
		out.print(new Gson().toJson(menuCategoryList).toString());
		out.flush();
		return null;
	}

	@RequestMapping(value = "/createstockout",
					method = RequestMethod.POST)
	public void createStockOut(	@RequestBody String invStockOut,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("in createstockout...{}", invStockOut);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Date currDate = new Date();
			SimpleDateFormat dateTimeFmt = new SimpleDateFormat("hh:mm:ss");
			String date = Utility.getFormatedDateShort(currDate);
			String dateTime = dateTimeFmt.format(currDate);
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			InventoryStockOut inventoryStockOut = gson.fromJson(invStockOut, new TypeToken<InventoryStockOut>() {}.getType());
			inventoryStockOut.setUserId(customer.getContactNo());
			inventoryStockOut.setStoreId(customer.getStoreId());
			inventoryStockOut.setCreatedBy(customer.getContactNo());
			out.print(stockOutService.createNewStockOut(inventoryStockOut));
			out.flush();
		}
	}

	@RequestMapping(value = "/getstockOutdetailsbyid/{stockOutId}/{date}",
					method = RequestMethod.GET)
	public ModelAndView getStockOutDetailsById(	@PathVariable("stockOutId") String stockOutId,
	                                           	@PathVariable("date") String date,
												Model model,
												HttpSession session,
												HttpServletRequest request,
												HttpServletResponse response) throws ParseException, IOException {
		logger.debug("In getStockOutDetailsById......{},{}", stockOutId, date);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<InventoryStockOut> inventoryStockOutList = stockOutService.getStockOutByPoId(customer.getStoreId(), stockOutId.trim());
		/*for (InventoryStockOut inventoryStockOut : inventoryStockOutList) {
			for (InventoryStockOutItems inventoryStockOutItem : inventoryStockOut.getInventoryStockOutItemList()) {
				String stockAvailable = inventoryService.getCurrentStockByItem(customer.getStoreId(), inventoryStockOutItem.getInventoryItems().getId());
				inventoryStockOutItem.getInventoryItems().setStockAvailable(stockAvailable);
				inventoryStockOutItem.setUnitName(inventoryStockOutItem.getUnit().getUnit());
			}
		}*/
		logger.info("inventoryStockInList in controller :: {}",new Gson().toJson(inventoryStockOutList));
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		out.print(new Gson().toJson(inventoryStockOutList).toString());
		return null;
	}

	@RequestMapping(value = "/getstockOutdetailsbydate/{date}",
					method = RequestMethod.GET)
	public ModelAndView getStockInDetailsByDate(@PathVariable("date") String date,
												Model model,
												HttpSession session,
												HttpServletRequest request,
												HttpServletResponse response) throws ParseException, IOException {
		logger.debug("In getstockOutdetailsbydate......{}", date);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_NEW_PAGE);
		List<InventoryStockOut> inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), date);
		/*for (InventoryStockOut inventoryStockOut : inventoryStockOutList) {
			for (InventoryStockOutItems inventoryStockOutItem : inventoryStockOut.getInventoryStockOutItemList()) {
				String stockAvailable = inventoryService.getCurrentStockByItem(customer.getStoreId(), inventoryStockOutItem.getInventoryItems().getId());
				inventoryStockOutItem.getInventoryItems().setStockAvailable(stockAvailable);
				inventoryStockOutItem.setUnitName(inventoryStockOutItem.getUnit().getUnit());
			}
		}*/
		logger.debug("inventoryStockInList in controller :: {}", inventoryStockOutList);
		List<MenuCategory> menuCategoryList = stockOutService.getMenuCategoryListByStoreId(customer.getStoreId());
		Date today = dateFormat.parse(date);
		mav.addObject("today", today);
		mav.addObject("menuCategoryList", menuCategoryList);
		mav.addObject("inventoryStockOutList", inventoryStockOutList);
		List<InventoryItems> stockoutRawItemList = stockOutService.getStockOurRawItemsByCurrentDate(customer.getStoreId(),date); 
    mav.addObject("rawItemList", stockoutRawItemList);
    int stockOutId = 0;
    if(inventoryStockOutList.size()>0){
       for(InventoryStockOut ob: inventoryStockOutList){
         stockOutId = ob.getId();
         break;
       }
    }
    mav.addObject("stockoutId",stockOutId);
		mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
		return mav;
	}
	
	@RequestMapping(value = "/getstockOutMandetailsbydate/{date}",
      method = RequestMethod.GET)
    public ModelAndView getStockOutManDetailsByDate(@PathVariable("date") String date,
                        Model model,
                        HttpSession session,
                        HttpServletRequest request,
                        HttpServletResponse response) throws ParseException, IOException {
    logger.debug("In getstockOutMandetailsbydate......{}", date);
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
      ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
      return mav;
    }
    ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_STOCK_OUT_MAN_PAGE);
    List<InventoryStockOut> inventoryStockOutList = stockOutService.getInventoryStockOutByDate(customer.getStoreId(), date);
    /*for (InventoryStockOut inventoryStockOut : inventoryStockOutList) {
      for (InventoryStockOutItems inventoryStockOutItem : inventoryStockOut.getInventoryStockOutItemList()) {
        String stockAvailable = inventoryService.getCurrentStockByItem(customer.getStoreId(), inventoryStockOutItem.getInventoryItems().getId());
        inventoryStockOutItem.getInventoryItems().setStockAvailable(stockAvailable);
        inventoryStockOutItem.setUnitName(inventoryStockOutItem.getUnit().getUnit());
      }
    }*/
    logger.debug("inventoryStockInList in controller :: {}", inventoryStockOutList);
    List<MenuCategory> menuCategoryList = stockOutService.getMenuCategoryListByStoreId(customer.getStoreId());
    Date today = dateFormat.parse(date);
    mav.addObject("today", today);
    mav.addObject("menuCategoryList", menuCategoryList);
    mav.addObject("inventoryStockOutList", inventoryStockOutList);
    //List<InventoryItems> stockoutRawItemList = stockOutService.getStockOurRawItemsByCurrentDate(customer.getStoreId(),date); 
    //mav.addObject("rawItemList", stockoutRawItemList);
    int stockOutId = 0;
    if(inventoryStockOutList.size()>0){
       for(InventoryStockOut ob: inventoryStockOutList){
         stockOutId = ob.getId();
         break;
       }
    }
    mav.addObject("stockoutId",stockOutId);
    mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
    return mav;
    }
	
	@RequestMapping(value = "/deletestockoutbyid/{stockoutid}", method = RequestMethod.GET)
  public ModelAndView deleteStockoutById(@PathVariable("stockoutid") String stockoutid, Model model, HttpSession session,
      HttpServletRequest request, HttpServletResponse response) {
    logger.debug("In deleteStockOut by stockoutid......{}", stockoutid);
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
      ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
      return mav;
    }
    try {
      String wsResponse = stockOutService.deleteStockoutById(stockoutid, customer.getStoreId());
      logger.debug("Response : " + wsResponse);
      PrintWriter out;
      out = response.getWriter();
      response.setContentType("text/plain");
      out.print(wsResponse);
      out.flush();
      return null;
    } catch (IOException e) {
      return null;
    }

  }
	
	@RequestMapping(value = "/approvestockout",
      method = RequestMethod.GET)
      public ModelAndView approveRawStockout( @RequestParam("stockoutid") String stockoutid,
                        Model model,
                        HttpSession session,
                        HttpServletResponse response) throws IOException {
      
      ModelAndView mav = new ModelAndView();
      Customer customer = null;
      if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
        mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
        return mav;
      } else {
        Date date=new Date();
        SimpleDateFormat ft=new SimpleDateFormat("yyyy-MM-dd");
        String dt=ft.format(date);
        String s = stockOutService.ApproveStockout(stockoutid, customer.getStoreId(), customer.getContactNo(), customer.getContactNo(), dt);
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        out.print(s);
        return null;
      } 
}
	
}
