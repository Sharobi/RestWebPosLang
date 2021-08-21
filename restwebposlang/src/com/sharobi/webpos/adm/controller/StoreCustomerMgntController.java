/**
 *
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.StoreCustomer;
import com.sharobi.webpos.adm.service.CreditSaleService;
import com.sharobi.webpos.adm.service.StoreCustomerMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.roombooking.base.model.RoomBookingGuest;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/storecustomermgnt")
public class StoreCustomerMgntController {
  private final static Logger logger = LogManager.getLogger(StoreCustomerMgntController.class);
  @Autowired
  StoreCustomerMgntService storecustomermgntService;
  @Autowired
  CreditSaleService creditSaleService;

  @RequestMapping(value = "/loadstorecustomermgnt", method = RequestMethod.GET)
  public ModelAndView loadStoreCustomer(HttpSession session) {
    logger.debug("in loadstorecustomermgnt...! ");
    ModelAndView mav = new ModelAndView();
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
      return mav;
    }
    List<StoreCustomer> storeCustList = storecustomermgntService.getStoreCustomerList(customer.getStoreId());
    mav.addObject("storecustList", storeCustList);
    mav.addObject(Constants.ADMIN, "Y");
    mav.setViewName(ForwardConstants.VIEW_STORECUST_MGNT_PAGE);
    return mav;
  }
  /*
   * @RequestMapping(value=
   * "/addstorecustomer/{custName}/{custContact}/{custAddress}/{custEmail}/{custcrLimit}"
   * ,method=RequestMethod.GET) public void
   * addStoreCustomer(@PathVariable("custName") String
   * custName,@PathVariable("custContact") String
   * custContact,@PathVariable("custAddress") String
   * custAddress,@PathVariable("custEmail") String
   * custEmail,@PathVariable("custcrLimit") int custcrLimit,HttpSession
   * session,HttpServletResponse response) throws IOException {
   * logger.debug("In addstorecustomer......{},{},{},{},{}",custName,custContact
   * ,custAddress,custEmail,custcrLimit); Customer customer=null;
   * if((customer=(Customer)
   * session.getAttribute(Constants.LOGGED_IN_USER))!=null) { PrintWriter out =
   * response.getWriter(); response.setContentType("text/plain"); StoreCustomer
   * storeCustomer=new StoreCustomer(); storeCustomer.setName(custName);
   * storeCustomer.setContactNo(custContact);
   * storeCustomer.setAddress(custAddress); storeCustomer.setEmailId(custEmail);
   * storeCustomer.setCreditLimit(custcrLimit);
   * storeCustomer.setStoreId(customer.getStoreId());
   * storeCustomer.setCreditCustomer("N"); String
   * res=storecustomermgntService.addStoreCustomer(storeCustomer);
   * System.out.println("res:"+res); out.print(res); out.flush(); } }
   */

  @RequestMapping(value = "/addstorecustomer", method = RequestMethod.POST)
  public void addStoreCustomer(@RequestBody String customerString, HttpSession session, HttpServletResponse response)
      throws IOException {
    logger.debug("In addstorecustomer......{}", customerString);
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      /*
       * StoreCustomer storeCustomer=new StoreCustomer();
       * storeCustomer.setName(custName);
       * storeCustomer.setContactNo(custContact);
       * storeCustomer.setAddress(custAddress);
       * storeCustomer.setEmailId(custEmail);
       * storeCustomer.setCreditLimit(custcrLimit);
       * storeCustomer.setStoreId(customer.getStoreId());
       * storeCustomer.setCreditCustomer("N");
       */

      Gson gson = new GsonBuilder().create();
      StoreCustomer storeCust = gson.fromJson(customerString, new TypeToken<StoreCustomer>() {
      }.getType());

      storeCust.setStoreId(customer.getStoreId());
      storeCust.setCreditCustomer("N");
      String res = storecustomermgntService.addStoreCustomer(storeCust);
      System.out.println("res:" + res);
      out.print(res);
      out.flush();
    }
  }

  @RequestMapping(value = "/addcreditcustomer", method = RequestMethod.POST)
  public void addCreditCustomer(@RequestBody String customerString, HttpSession session, HttpServletResponse response)
      throws IOException {
    logger.debug("In addcreditcustomer......{}", customerString);
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      /*
       * StoreCustomer storeCustomer=new StoreCustomer();
       * storeCustomer.setName(custName);
       * storeCustomer.setContactNo(custContact);
       * storeCustomer.setAddress(custAddress);
       * storeCustomer.setEmailId(custEmail);
       * storeCustomer.setCreditLimit(custcrLimit);
       * storeCustomer.setStoreId(customer.getStoreId());
       * storeCustomer.setCreditCustomer("N");
       */

      Gson gson = new GsonBuilder().create();
      StoreCustomer storeCust = gson.fromJson(customerString, new TypeToken<StoreCustomer>() {
      }.getType());

      storeCust.setStoreId(customer.getStoreId());
      storeCust.setCreditCustomer("Y");
      // JSONObject json = (JSONObject) JSONSerializer.toJSON(data);
      System.out.println("customer contact:" + storeCust.getContactNo());
      storeCust.setCreatedByid(customer.getId());
      String res = storecustomermgntService.addStoreCustomer(storeCust);
      StoreCustomer customerobj = storecustomermgntService.getAddedCustomerData(customer.getStoreId(),
          storeCust.getContactNo());
      out.print(gson.toJson(customerobj));
      out.flush();
    }
  }

  /*
   * @RequestMapping(value=
   * "/editstorecustomer/{custId}/{custName}/{custContact}/{custAddress}/{custEmail}/{custcrLimit}/{crFlag}"
   * ,method=RequestMethod.GET) public void
   * editStoreCustomer(@PathVariable("custId") int
   * custId,@PathVariable("custName") String
   * custName,@PathVariable("custContact") String
   * custContact,@PathVariable("custAddress") String
   * custAddress,@PathVariable("custEmail") String
   * custEmail,@PathVariable("custcrLimit") int
   * custcrLimit,@PathVariable("crFlag") String crFlag,HttpSession
   * session,HttpServletResponse response) throws IOException {
   * logger.debug("In editstorecustomer......{},{},{},{},{},{},{}",custId,
   * custName,custContact,custAddress,custEmail,custcrLimit,crFlag); Customer
   * customer=null; if((customer=(Customer)
   * session.getAttribute(Constants.LOGGED_IN_USER))!=null) { PrintWriter out =
   * response.getWriter(); response.setContentType("text/plain"); StoreCustomer
   * storeCustomer=new StoreCustomer(); storeCustomer.setId(custId);
   * storeCustomer.setName(custName); storeCustomer.setContactNo(custContact);
   * storeCustomer.setAddress(custAddress); storeCustomer.setEmailId(custEmail);
   * storeCustomer.setCreditLimit(custcrLimit);
   * storeCustomer.setCreditCustomer(crFlag);
   * storeCustomer.setStoreId(customer.getStoreId());
   * storeCustomer.setDeleteFlag("N"); String
   * res=storecustomermgntService.editStoreCustomer(storeCustomer);
   * System.out.println("res:"+res); out.print(res); out.flush(); } }
   */

  @RequestMapping(value = "/editstorecustomer", method = RequestMethod.POST)
  public void editStoreCustomer(@RequestBody String editCustomerString, HttpSession session,
      HttpServletResponse response) throws IOException {
    logger.debug("In editstorecustomer......{},{},{},{},{},{},{}", editCustomerString);
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      // StoreCustomer storeCustomer=new StoreCustomer();
      /*
       * storeCustomer.setId(custId); storeCustomer.setName(custName);
       * storeCustomer.setContactNo(custContact);
       * storeCustomer.setAddress(custAddress);
       * storeCustomer.setEmailId(custEmail);
       * storeCustomer.setCreditLimit(custcrLimit);
       * storeCustomer.setCreditCustomer(crFlag);
       */
      Gson gson = new GsonBuilder().create();
      StoreCustomer storeCust = gson.fromJson(editCustomerString, new TypeToken<StoreCustomer>() {
      }.getType());

      storeCust.setStoreId(customer.getStoreId());
      storeCust.setDeleteFlag("N");
      String res = storecustomermgntService.editStoreCustomer(storeCust);
      System.out.println("res:" + res);
      out.print(res);
      out.flush();
    }
  }

  @RequestMapping(value = "/deletestorecustomer/{id}", method = RequestMethod.GET)
  public void deleteVendor(@PathVariable("id") String id, HttpSession session, HttpServletResponse response)
      throws IOException {
    logger.debug("In deletestorecustomer......{}", id);
    // ModelAndView mav = new ModelAndView();
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      String res = storecustomermgntService.deleteStoreCustomer(NumberUtils.toInt(id), customer.getStoreId());
      System.out.println("res:" + res);
      out.print(res);
      out.flush();
    }
  }

  @RequestMapping(value = "/getallcreditcustomerdata", method = RequestMethod.GET)
  public void GetListofCreditCustomer(HttpSession session, HttpServletResponse response) throws IOException {
    logger.debug("In GetListofCreditCustomer......{}");
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      Gson gson = new GsonBuilder().create();
      List<StoreCustomer> customerobjlist = creditSaleService.getCreditCustomerList(customer.getStoreId());
      out.print(gson.toJson(customerobjlist));
      out.flush();
    }
  }

 @RequestMapping(value = "/convertToCreditBooking", method = RequestMethod.POST)
  @ResponseBody
  public String addRoomBookingGuest(@RequestBody String roomBookingObject, HttpSession session,
      HttpServletResponse response, HttpServletRequest request) throws IOException {
   /*url=http://192.168.1.34:8082/Restaurant/rest/roomsearch/convertToCreditBooking
   */     
    logger.debug("In convertToCreditBooking......" + roomBookingObject);
    String res = null;
    Gson gson = new Gson();
    RoomBooking robj=null;
    JsonObject jobj = new JsonObject();
    jobj.addProperty("is_success", false);
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      robj=gson.fromJson(roomBookingObject, new TypeToken<RoomBooking>() {}.getType());
      res=storecustomermgntService.convertToCreditBooking(robj);
      if (res != null) {
        boolean status = (res.equalsIgnoreCase("Success") == true) ? true : false;
        jobj.addProperty("is_success", status);
      } else {
        jobj.addProperty("is_success", false);
      }
      logger.debug("String Response After convertToCreditBooking   Is......" + res);
      logger.debug("Json Response  For convertToCreditBooking  Is......" + jobj);

    }
    return jobj.toString();
  }

  
  @RequestMapping(value = "/convertToCreditCustomer", method = RequestMethod.GET)
  @ResponseBody
  public String convertToCreditCustomer(@RequestHeader("storecustomer") String storeCustomer,
      @RequestHeader("storeId") String storeId, HttpSession session, HttpServletRequest request) throws Exception {
    /*url= http://192.168.1.34:8082/Restaurant/rest/storeCustomer/convertToCreditCustomer?storeId=29&custId=848
    */   
    JsonObject response = new JsonObject();
    StoreCustomer stobj=null;
    Gson gson= new Gson();
    logger.debug("In convertToCreditCustomer METHOD IN StoreCustomerMgntController Class ......");
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      stobj=gson.fromJson(storeCustomer, new TypeToken<StoreCustomer>() {}.getType());
      String res=storecustomermgntService.convertToCreditCustomer(stobj, storeId);
      Boolean status=(res.equalsIgnoreCase("Success"))?true:false;
      response.addProperty("is_success", status);
    }
    logger.debug("RESPONSE IN StoreCustomerMgntController CONTROLLER FOR convertToCreditCustomer .....");
    logger.debug(response);
    return response.toString();
  }

}
