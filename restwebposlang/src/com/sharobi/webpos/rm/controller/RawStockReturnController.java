package com.sharobi.webpos.rm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.sharobi.webpos.adm.model.ReturnTypes;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.inv.controller.StockInControllerNew;
import com.sharobi.webpos.inv.model.InventoryReturn;
import com.sharobi.webpos.inv.model.InventoryReturnItem;
import com.sharobi.webpos.inv.model.InventoryVendors;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.inv.service.PurchaseReturnService;
import com.sharobi.webpos.inv.service.StockInService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/rawstockreturn")

public class RawStockReturnController {
	private final static Logger logger = LogManager.getLogger(StockInControllerNew.class);
	
	@Autowired InventoryService inventoryService ;
	@Autowired StockInService stockInService ;
	@Autowired InventoryMgntService inventorymgntService ;
	@Autowired OrderService orderService ;
	@Autowired PurchaseReturnService purchaseReturnService ;
	@Autowired StoreService storeService ;
	
	final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	@RequestMapping(value = "/loadrawstockreturn",method = RequestMethod.GET)
	public ModelAndView loadSmartPurchaseReturnPage(Model model,
						        HttpSession session,
						        HttpServletRequest request) throws ParseException {
	     logger.debug("In loadSmartPurchaseReturnPage......");
	     Customer customer = null;
	     if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	           ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
	           return mav;
	          }
	      Date currDate = new Date();
	      ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_RAW_STOCK_RETURN_PAGE);
	      List<InventoryReturn> inventoryReturnList = purchaseReturnService.getPurchaseReturnByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
	      logger.debug("Fetched returnlisi :: {}", inventoryReturnList);
	      List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
	      logger.debug("Fetched vendorList :: {}", vendorList);
	      mav.addObject("vendorList", vendorList);
	      mav.addObject("inventoryPurchaseReturnList", inventoryReturnList);
	      List<ReturnTypes> returntypelist = orderService.getAllReturntypes(customer.getStoreId());

	      List<ReturnTypes> filteredreturntypelist = new ArrayList<ReturnTypes>();
	        for(ReturnTypes ob:returntypelist){
	      	  if(ob.getType().equals("PUR")){
	      		  filteredreturntypelist.add(ob);
	      	  }

	        }
	        mav.addObject("reasons", filteredreturntypelist);
	        session.setAttribute(Constants.RETURN_TYPELIST, new Gson().toJson(filteredreturntypelist).toString());


	      /*mav.addObject("reasons", returntypelist);
	      session.setAttribute(Constants.RETURN_TYPELIST, new Gson().toJson(returntypelist).toString()); */


	      Date currdate = new Date();
	      String date = dateFormat.format(currdate);
	      Date today = dateFormat.parse(date);
	      mav.addObject("today", today);
	      mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
	      Store store = storeService.getStoreById(customer.getStoreId());
    		System.out.println("___is_acc_in stock return " + store.getIs_account());
    		mav.addObject("is_acc", store.getIs_account());
	      return mav;
	       }



@RequestMapping(value = "/createorupdaterawpurchasereturn",
			method = RequestMethod.POST)
public void createOrUpdatePurchaseReturn(	@RequestBody String purchaseReturn,
								HttpSession session,
								HttpServletResponse response) throws IOException, ParseException {
	logger.debug("in createOrUpdatePurchaseReturn...{}", purchaseReturn);
	Customer customer;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
		String date = null;
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		Gson gson = new Gson();
		InventoryReturn invreturn = gson.fromJson(purchaseReturn, new TypeToken<InventoryReturn>() {}.getType());

		if (invreturn.getId() == 0) {
			for (InventoryReturnItem returnitems : invreturn.getInventoryReturnItems()) {
				returnitems.setCreatedBy(customer.getContactNo());
				date = returnitems.getCreatedDate(); //date1=new SimpleDateFormat("yyyy-MM-dd").parse(returnitems.getCreatedDate());
			}
			invreturn.setUserId(customer.getContactNo());
			invreturn.setCreatedBy(customer.getContactNo());
			invreturn.setCreatedDate(date);
			//invreturn.setDate(date); //invreturn.setDate(date1);

			purchaseReturnService.saveNewPurchaseReturn(invreturn);

		}
		else {
			String returnid = String.valueOf(invreturn.getId());
			InventoryReturn invitemreturndata = purchaseReturnService.getPurchaseReturnByReturnId(customer.getStoreId(), returnid);


			for (InventoryReturnItem newreturnitems : invreturn.getInventoryReturnItems()) {
				newreturnitems.setCreatedBy(invitemreturndata.getCreatedBy());
				newreturnitems.setCreatedDate(invitemreturndata.getCreatedDate());
				date = newreturnitems.getUpdatedDate(); //date1=new SimpleDateFormat("yyyy-MM-dd").parse(newreturnitems.getUpdatedDate());
			}
			
		    invreturn.setCreatedBy(invitemreturndata.getCreatedBy());
	     	invreturn.setCreatedDate(invitemreturndata.getCreatedDate());


		     invreturn.setUpdatedBy(customer.getContactNo());
		     invreturn.setUpdatedDate(date);

		    logger.debug("updatable invreturn obj :: {}", gson.toJson(invreturn));

		    purchaseReturnService.updatePurchaseReturn(invreturn);


		}
		out.print("success");
		out.flush();
	}
}



@RequestMapping(value = "/getrawpurchaseReturndetailsbyidanddate/{returnid}/{date}",
method = RequestMethod.GET)
public ModelAndView getpurchaseReturnDetailsByIdandDate(	@PathVariable("returnid") String returnid,
									@PathVariable("date") String date,
									Model model,
									HttpSession session,
									HttpServletRequest request,
									HttpServletResponse response) throws ParseException, IOException {
   logger.debug("In getpurchaseReturnDetailsByIdandDate......{},{}", returnid, date);
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
    ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
    return mav;
    }
     InventoryReturn invitemreturndata = purchaseReturnService.getPurchaseReturnByReturnId(customer.getStoreId(), returnid.trim());
    logger.debug("return in controller :: {}", invitemreturndata);
    PrintWriter out = response.getWriter();
    response.setContentType("application/json");
    out.print(new Gson().toJson(invitemreturndata).toString());
    return null;
}




 @RequestMapping(value = "/getrawPurchaseReturndetailsbydate/{date}",method = RequestMethod.GET)
public ModelAndView getPurchaseReturnsDate(@PathVariable("date") String date,
							Model model,
							HttpSession session,
							HttpServletRequest request,
							HttpServletResponse response) throws ParseException, IOException {
   logger.debug("In getPurchaseReturnsDate......{}", date);
    Customer customer = null;
        if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
               ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
               return mav;
            }
        
        ModelAndView mav = new ModelAndView(ForwardConstants.VIEW_RAW_STOCK_RETURN_PAGE);
        List<InventoryReturn> inventoryReturnList = purchaseReturnService.getPurchaseReturnByDate(customer.getStoreId(), date);
        logger.debug("Fetched returnlist :: {}", inventoryReturnList);
        List<InventoryVendors> vendorList = inventoryService.getVendors(customer.getStoreId());
        logger.debug("Fetched vendorList :: {}", vendorList);
        mav.addObject("vendorList", vendorList);
        mav.addObject("inventoryPurchaseReturnList", inventoryReturnList);
        List<ReturnTypes> returntypelist = orderService.getAllReturntypes(customer.getStoreId());

        List<ReturnTypes> filteredreturntypelist = new ArrayList<ReturnTypes>();
        for(ReturnTypes ob:returntypelist){
      	  if(ob.getType().equals("PUR")){
      		  filteredreturntypelist.add(ob);
      	  }

        }
        mav.addObject("reasons", filteredreturntypelist);
        session.setAttribute(Constants.RETURN_TYPELIST, new Gson().toJson(filteredreturntypelist).toString());


        /*mav.addObject("reasons", returntypelist);
        session.setAttribute(Constants.RETURN_TYPELIST, new Gson().toJson(returntypelist).toString()); */


        
        Date today = dateFormat.parse(date);
        mav.addObject("today", today);
        mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
        return mav;
    }

 @RequestMapping(value = "/rawpurchasereturnclosed",
			method = RequestMethod.POST)
public ModelAndView purchaseReturnClosed(@RequestParam String purchaseReturnId,
		                                 @RequestBody String invReturn,
								         Model model,
								         HttpSession session,
								         HttpServletResponse response) throws ParseException, IOException {
   logger.debug("In purchaseReturnClosed......{}", purchaseReturnId);
   Customer customer = null;
   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
	return mav;
   }
   PrintWriter out = response.getWriter();
   response.setContentType("text/plain");
   Gson gson = new Gson();
   InventoryReturn inventoryReturn = gson.fromJson(invReturn, new TypeToken<InventoryReturn>() {}.getType());
   inventoryReturn.setId(Integer.parseInt(purchaseReturnId));

   Store store = storeService.getStoreById(customer.getStoreId());
   inventoryReturn.setIs_account(store.getIs_account());
   inventoryReturn.setQs(Constants.PURCHASE_RETURN_PAYMENT_QS);
   inventoryReturn.setStoreId(customer.getStoreId());
   System.out.println("___pur return___" + inventoryReturn.toString());
   purchaseReturnService.purchaseReturnClosed(inventoryReturn);
   out.print("success");
   out.flush();
   return null;
}


@RequestMapping(value = "/deleterawpurchasereturnbyid/{purchaseReturnId}",
	method = RequestMethod.GET)
public ModelAndView deletePurchaseReturnById(@PathVariable("purchaseReturnId") String purchaseReturnId,
						Model model,
						HttpSession session,
						HttpServletRequest request,
						HttpServletResponse response) {
      logger.debug("In deletePurchaseReturnById by purchaseReturnId......{}",purchaseReturnId);
      Customer customer = null;
         if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
                    ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
                    return mav;
           }
          try {
                String wsResponse = purchaseReturnService.deletePurchaseReturnById(purchaseReturnId,customer.getStoreId());
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




}
