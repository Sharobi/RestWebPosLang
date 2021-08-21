package com.sharobi.webpos.roombooking.base.controller;


import java.io.IOException;
import java.io.PrintWriter;
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
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.roombooking.adm.model.Room;
import com.sharobi.webpos.roombooking.adm.model.RoomServices;
import com.sharobi.webpos.roombooking.adm.service.RoomService_Service;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.roombooking.base.model.RoomBookingDetails;
import com.sharobi.webpos.roombooking.base.model.RoomBookingInfo;
import com.sharobi.webpos.roombooking.base.model.RoomBookingPayment;
import com.sharobi.webpos.roombooking.base.model.RoomBookingServices;
import com.sharobi.webpos.roombooking.base.service.CheckOutService;
import com.sharobi.webpos.roombooking.base.service.CustomerRegistrationService;
import com.sharobi.webpos.roombooking.base.service.RoomSearchService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import org.apache.commons.lang3.math.NumberUtils;

@Controller
@RequestMapping("/checkout")
public class CheckOutController {
	private final static Logger logger=LogManager.getLogger(CheckOutController.class);
	private final static CheckOutService checkout=new CheckOutService();
	private final static CustomerRegistrationService customerRegistration=new CustomerRegistrationService();
	private final static RoomSearchService roomService=new RoomSearchService();
	 private final static RoomService_Service roomServicesService=new RoomService_Service();
	@Autowired StoreService storeService;
	private final static Gson gson=new Gson();
	@RequestMapping(value="/welcome",
			method = RequestMethod.GET)
	public ModelAndView welcome(Model model,HttpSession session){
	ModelAndView mav = new ModelAndView();
	Customer customer=null;
	if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
	{
		mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
		return mav;
	}
	
	
	List<RoomBooking> allcheckedinCust=checkout.getAllcheckIncustomer(getTodayDate(),getTodayDate(),customer.getStoreId(),"0");
	session.setAttribute("allcheckedinCust", allcheckedinCust);
	System.out.println("checkedincustomers:"+gson.toJson(allcheckedinCust));
	List<RoomServices> roomservicesList=roomServicesService.getRoomService(customer.getStoreId());
	mav.addObject("roomservicesList", roomservicesList);
	mav.addObject("roomservices", gson.toJson(roomservicesList).toString());
	mav.addObject("allcheckedinCust",allcheckedinCust);
	mav.addObject(Constants.CHECK_OUT,"Y");
	mav.setViewName(ForwardConstants.VIEW_ROOM_CHECKOUT_PAGE);
	return mav;
}
	

	@RequestMapping(value="/checkedincustomerbyperiod",method=RequestMethod.GET)
	public ModelAndView getCheckInList(@RequestParam String fromDate, @RequestParam String toDate,@RequestParam String bookingNo, Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);
		
		ModelAndView mav = new ModelAndView();
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		
		List<RoomBooking> allcheckedinCust=checkout.getAllcheckIncustomer(fromDate,toDate,customer.getStoreId(),bookingNo);		
		mav.addObject("fromdate",fromDate);	
		mav.addObject("todate",toDate);	
		mav.addObject("directBooking","N");
		session.setAttribute("allcheckedinCust", allcheckedinCust);
		mav.addObject("allcheckedinCust",allcheckedinCust);	
		List<RoomServices> roomservicesList=roomServicesService.getRoomService(customer.getStoreId());
	  mav.addObject("roomservicesList", roomservicesList);
	  mav.addObject("roomservices", gson.toJson(roomservicesList).toString());
		mav.addObject(Constants.CHECK_OUT,"Y");
		mav.setViewName(ForwardConstants.VIEW_ROOM_CHECKOUT_PAGE);
		return mav;
	}
	@RequestMapping(value="/bookingidbycustomeridbyperiod",method=RequestMethod.GET)
	public ModelAndView getCheckInIdByBookingId(@RequestParam String fromDate, @RequestParam String toDate,@RequestParam String custId, Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);
		
		ModelAndView mav = new ModelAndView();
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		
		List<RoomBooking> allcheckedinCust=checkout.getBookingIdByCustIdByPeriod(fromDate,toDate,customer.getStoreId(),custId);		
		mav.addObject("fromdate",fromDate);	
		mav.addObject("todate",toDate);	
		mav.addObject("directBooking","N");
		mav.addObject("allcheckedinCust",allcheckedinCust);	
		List<RoomServices> roomservicesList=roomServicesService.getRoomService(customer.getStoreId());
	  mav.addObject("roomservicesList", roomservicesList);
	  mav.addObject("roomservices", gson.toJson(roomservicesList).toString());
		mav.setViewName(ForwardConstants.VIEW_ROOM_CHECKOUT_PAGE);
		return mav;
	}
/*	@RequestMapping(value="/bookingidbybookingid",method=RequestMethod.GET)
	public ModelAndView getBookingIdByBookingId(@RequestParam String resId, Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);
		
		ModelAndView mav = new ModelAndView();
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		
		List<RoomBookingInfo> allcheckedinCust=checkout.getBookingIdByBookingId(resId,customer.getStoreId());		
		mav.addObject("fromdate",allcheckedinCust.get(0).getFromDate());	
		mav.addObject("todate",allcheckedinCust.get(0).getToDate());	
		mav.addObject("directBooking","N");
		mav.addObject("allcheckedinCust",allcheckedinCust);	
		mav.setViewName(ForwardConstants.VIEW_ROOM_CHECKOUT_PAGE);
		return mav;
	}*/
	
	@RequestMapping(value = "/searchbookingid",
			method = RequestMethod.GET)
			public void searchResIdListByResId(	@RequestParam(value = "term") String tagName,
					@RequestParam(value = "fromDate") String fromDate,
					@RequestParam(value = "toDate") String toDate,
								HttpSession session,
								HttpServletResponse response) throws IOException {
					Customer customer;
					if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
						PrintWriter out = response.getWriter();
						response.setContentType("application/json");
						Gson gson = new Gson();
						String selLang = (String) session.getAttribute(Constants.SELECTED_LANG);
						String custList = checkout.getBookingIdByBookingId(customer.getStoreId(), tagName, fromDate, toDate);
						out.print(gson.toJson(custList));
						out.flush();
					}
			}
	@RequestMapping(value="/bookingidetbybookingid/{bookId}",method=RequestMethod.GET)
	public void getBookingDetByBookingId(@PathVariable("bookId") String bookId, HttpSession session,HttpServletResponse response) throws IOException
	{
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			List<RoomBooking> allcheckedinCust=checkout.getBookDetListbyBookId(bookId,customer.getStoreId());	

		//	System.out.println("res:"+reserveDetails);
			String jsonInString = gson.toJson(allcheckedinCust);		
			logger.debug("RESPONSE IN getBookingDetByBookingId METHOD IN CheckOutController CLASS AND THIS URL /bookingidetbybookingid/{bookId} IS ");
			logger.debug(jsonInString);
			System.out.println(jsonInString);
			out.print(jsonInString);
			out.flush();
			
		}
	}
	@RequestMapping(value="/checkoutfromhotel",method=RequestMethod.POST)
	public void checkOutFromRoom(@RequestBody String roomBooking,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			Gson gson = new Gson();
			RoomBooking roomBookingDetails =gson.fromJson(roomBooking, new TypeToken<RoomBooking>() {}.getType());

			String res=checkout.checkOutRoom(roomBookingDetails);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/bookingidetailsbybookingid",method=RequestMethod.GET)
	public ModelAndView getBookingDetailsByBookingId(@RequestParam String bookId, Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);
		
		ModelAndView mav = new ModelAndView();
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		
		List<RoomBooking> allcheckedinCust=checkout.getBookDetListbyBookId(bookId,customer.getStoreId());		
		
		mav.addObject("directBooking","N");
		mav.addObject("allcheckedinCust",allcheckedinCust);	
		List<RoomServices> roomservicesList=roomServicesService.getRoomService(customer.getStoreId());
	  mav.addObject("roomservicesList", roomservicesList);
	  mav.addObject("roomservices", gson.toJson(roomservicesList).toString());
		mav.setViewName(ForwardConstants.VIEW_ROOM_CHECKOUT_PAGE);
		return mav;
	}
	public String getTodayDate()
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    System.out.println("date:"+df.format(date));
		return df.format(date);
	}
	
	
	
	@RequestMapping(value="/changecheckout/{bookingid}/{reserveid}/{checkoutdate}/{fromdate}/{todate}/{operation}",method=RequestMethod.GET)
	public void updateCheckoutHistory(@PathVariable("bookingid") String bookingid,@PathVariable("reserveid") String reserveid,@PathVariable("checkoutdate") String checkoutdate,@PathVariable("fromdate") String fromdate,@PathVariable("todate") String todate,@PathVariable("operation") int operation, HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.info("in Change Checkout...{}{}{}{}! "+bookingid+reserveid+checkoutdate+operation);
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			String responses="";
			if(operation == 0){ // decrease checkout date from existing 
			  
			  RoomBooking  rmbooking = new RoomBooking();
        rmbooking.setId(Integer.parseInt(bookingid));
        rmbooking.setHotelId(customer.getStoreId());
        rmbooking.setReserveId(reserveid);
        rmbooking.setCheckInDate(fromdate);
        rmbooking.setCheckoutDate(checkoutdate);
        responses = checkout.changeCheckout(rmbooking);
			  
			  
			}else{// increase checkout date from existing 
			
			//List<RoomBookingInfo> allreservedDetails=customerRegistration.getReserveIdBySearch(checkoutdate,customer.getStoreId());
		  List<Room> roomList=roomService.getRoomListBySearch(todate,checkoutdate,customer.getStoreId());
			List<RoomBooking> allcheckedinCust=checkout.getBookDetListbyBookId(bookingid,customer.getStoreId());		
			
			String list = gson.toJson(roomList);
			String bookedroomlist = gson.toJson(allcheckedinCust);
			System.out.println("All Room List is:"+list);
			System.out.println("Booked Room List is:"+bookedroomlist);
			
			RoomBooking roombookingdata = allcheckedinCust.get(0);
			List<RoomBookingDetails> roombookinfo=roombookingdata.getBookingDetail();
			List<Room> bookedRoom = new ArrayList<Room>();
			for(RoomBookingDetails detailsob: roombookinfo){
			    bookedRoom.add(detailsob.getRoomId());
			  }
			//String reservedid=roombookingdata.getReserveId();
			int bookedroomno=roombookinfo.size();
			int count=0;
			for(Room ob1:roomList){
        for(Room ob2: bookedRoom){
              if((ob2.getId() == ob1.getId() && ! ("Y").equalsIgnoreCase(ob1.getIsBooked())) || (ob2.getId() == ob1.getId() && ("Y").equalsIgnoreCase(ob1.getIsBooked())/* && (reservedid).equals(ob1.getReserveId())*/)){
               count++;
              }
        }
			}
			
			if(count == bookedroomno){
        RoomBooking  rmbooking = new RoomBooking();
        rmbooking.setId(Integer.parseInt(bookingid));
        rmbooking.setHotelId(customer.getStoreId());
        rmbooking.setReserveId(reserveid);
        rmbooking.setCheckInDate(fromdate);
        rmbooking.setCheckoutDate(checkoutdate);
        responses = checkout.changeCheckout(rmbooking);
      }
      else{
         responses = "fail";
      }
		}
			
			out.print(responses);
			out.flush();
			
		}
	}
	
	
	
	
	@RequestMapping(value="/addingdiscount/{bookingid}/{discpercentage}/{discammt}/{reserveid}",method=RequestMethod.GET)
	public void updateCheckoutHistory(@PathVariable("bookingid") String bookingid,@PathVariable("discpercentage") String discpercentage,@PathVariable("discammt") String discammt,@PathVariable("reserveid") String reserveid , HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("in adding discount...{}{}{}! "+bookingid+discpercentage+discammt+reserveid);
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			RoomBooking  rmbooking = new RoomBooking();
			rmbooking.setId(Integer.parseInt(bookingid));
			rmbooking.setHotelId(customer.getStoreId());
			rmbooking.setReserveId(reserveid);
			rmbooking.setDiscPer(Double.parseDouble(discpercentage));
			rmbooking.setDiscAmt(Double.parseDouble(discammt));			
			out.print(checkout.setDiscount(rmbooking));
			out.flush();
			
		}
	}
	/*@RequestMapping(value = "/addingdiscount", method = RequestMethod.POST)
  public void updateCheckoutHistory(@RequestBody String roomBookingPayment, HttpSession session,
      HttpServletResponse response) throws IOException
  {
    logger.debug("in adding discount...{}");
    Customer customer=null;
    
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      Gson gson = new Gson();
      RoomBookingPayment payment = gson.fromJson(roomBookingPayment, new TypeToken<RoomBookingPayment>() {
      }.getType());
      payment.setHotelId(String.valueOf(customer.getStoreId()));
      payment.setCreatedBy(customer.getContactNo());
      Store store=storeService.getStoreById(customer.getStoreId());
      payment.setIs_account(store.getIs_account());
      payment.setQs(Constants.SALE_QS);
      logger.info("Discount Data:"+gson.toJson(payment));  
      out.print(checkout.setDiscount(payment));
      out.flush();
      
    }
  }*/
	
	
	
	
	
	@RequestMapping(value="/bookingidetbybookingidforfinalbill/{bookId}",method=RequestMethod.GET)
	public void getBookingDetByBookingIdForFinalBill(@PathVariable("bookId") String bookId, HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("for finl bill...{}! "+bookId);
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			List<RoomBooking> allcheckedinCust=checkout.getBookDetListbyBookIdforfinalbill(bookId,customer.getStoreId());	

		//	System.out.println("res:"+reserveDetails);
			String jsonInString = gson.toJson(allcheckedinCust);			
			System.out.println(jsonInString);
			out.print(jsonInString);
			out.flush();
			
		}
	}
	
	
	
	@RequestMapping(value="/taxchange/{bookingId}/{reserveId}",method=RequestMethod.GET)
  public void changeTax(@PathVariable("bookingId") String bookingId,@PathVariable("reserveId") String reserveId, HttpSession session,HttpServletResponse response) throws IOException
  {
    logger.debug("chnage tax...{}{}! "+bookingId+reserveId);
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      RoomBooking roombookingobj = new RoomBooking();
      roombookingobj.setId(Integer.parseInt(bookingId));
      roombookingobj.setReserveId(reserveId);
      roombookingobj.setHotelId(customer.getStoreId());
      out.print(checkout.changeTax(roombookingobj));
      out.flush();
      
    }
  }
  
	@RequestMapping(value="/addServices",method=RequestMethod.POST)
  public void addServices(@RequestBody String roomBooking,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
  {
    
    Customer customer=null;
    Store store=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
  
      Gson gson = new Gson();
      RoomBooking roomBookingData =gson.fromJson(roomBooking, new TypeToken<RoomBooking>() {}.getType());

      String res=checkout.addRoomServices(roomBookingData);
      System.out.println("res:"+res);
      out.print(res);
      out.flush();
    }
  }
	
	@RequestMapping(value = "/getRoomServicesByBookingId/{bookingid}", method = RequestMethod.GET)
  public void getRoomServicesByBookingId(@PathVariable("bookingid") String bookingid, HttpSession session,
      HttpServletResponse response) throws IOException {
    logger.info("in getRoomServicesByBookingId...{}", bookingid);
    Customer customer;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      out.print(checkout.getRoomServiceInfoByBookingId(NumberUtils.toInt(bookingid),customer.getStoreId()));
      out.flush();
    }
  }
	
	
	
}
