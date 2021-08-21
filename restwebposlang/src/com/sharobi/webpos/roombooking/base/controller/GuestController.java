package com.sharobi.webpos.roombooking.base.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.roombooking.base.model.RoomBookingGuest;
import com.sharobi.webpos.roombooking.base.service.CustomerRegistrationService;
import com.sharobi.webpos.roombooking.base.service.GuestService;
import com.sharobi.webpos.util.Constants;

@Controller
@RequestMapping("/guest")
public class GuestController {
  private final static Logger logger=LogManager.getLogger(GuestController.class);
  private final static GuestService guestService=new GuestService();
  private final static Gson gson=new Gson();
  
  @RequestMapping(value="/addRoomBookingGuest",method=RequestMethod.POST)
  @ResponseBody
  public String addRoomBookingGuest(@RequestBody String roomBookingObject,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
  {
    logger.debug("In addRoomBookingGuest......"+roomBookingObject);
    String res=null;
    JsonObject jobj = new JsonObject();
    jobj.addProperty("is_success", false);
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      RoomBooking roomBooking =gson.fromJson(roomBookingObject, new TypeToken<RoomBooking>() {}.getType());
      List<RoomBookingGuest>guestlist=roomBooking.getBookingGuest();
      if(guestlist.size()>0){
        res= guestService.addRoomBookingGuest(roomBooking);
      }else{
        res=null;
      }
      if(res!=null){
        boolean status=(res.equalsIgnoreCase("Success")==true)?true:false;
        jobj.addProperty("is_success", status);
      }else{
        jobj.addProperty("is_success", false);
      }
      logger.debug("String Response After Adding Guest For Room Booking  Is......"+res);
      logger.debug("Json Response After Adding Guest For Room Booking  Is......"+jobj);
      
    }
    return jobj.toString();
  }
  
  
  @RequestMapping(value = "/getRoomGuestByBookingId", method = RequestMethod.GET)
  @ResponseBody
  public String getRoomGuestByBookingId(@RequestHeader("bookingId") String bookingId,@RequestHeader("storeId") String storeId, HttpSession session,HttpServletRequest request) throws Exception {
    String response = null;
    logger.debug("In getRoomGuestByBookingId METHOD......");
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      response = guestService.getRoomGuestByBookingId(bookingId, storeId);
    }
    logger.debug("RESPONSE IN GUESTCONTROLLER CONTROLLER FOR getRoomGuestByBookingId .....");
    logger.debug(response);
    return response;
  }

  
  
  @RequestMapping(value = "/getAllUniqueId", method = RequestMethod.GET)
  @ResponseBody
  public String getAllUniqueId(@RequestHeader("storeId") String storeId, HttpSession session,HttpServletRequest request) throws Exception {
    String response = null;
    logger.debug("In getAllUniqueId METHOD INSIDE GUESTCONTROLLER CLASS......");
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      response = guestService.getAllUniqueIdType(Integer.parseInt(storeId));
    }
    logger.debug("RESPONSE IN GUESTCONTROLLER FOR GETALLUNIQUEID METHOD IS .....");
    logger.debug(response);
    return response;
  }

  
}
