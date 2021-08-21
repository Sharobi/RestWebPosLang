package com.sharobi.webpos.roombooking.base.controller;




import java.io.IOException;
import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.StoreCustomer;
import com.sharobi.webpos.adm.service.StoreCustomerMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.roombooking.base.model.RoomBookingInfo;
import com.sharobi.webpos.roombooking.base.model.RoomBookingPayment;
import com.sharobi.webpos.roombooking.base.model.UniqueIdTypeMaster;
import com.sharobi.webpos.roombooking.base.service.CustomerRegistrationService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/customer")
public class CustomerRegistrationController {
	
	private final static Logger logger=LogManager.getLogger(CustomerRegistrationController.class);
	private final static CustomerRegistrationService customerRegistration=new CustomerRegistrationService();
	@Autowired  StoreCustomerMgntService storecustomermgntService;
	@Autowired StoreService storeService;
	private final static Gson gson=new Gson();
	

	@RequestMapping(value="/welcome",
			method = RequestMethod.GET)
	public ModelAndView welcome(Model model,HttpSession session){
		logger.debug("in welcome...! ");
	ModelAndView mav = new ModelAndView();
	Customer customer=null;
	if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
	{
		mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
		return mav;
	}
//	String s = new SimpleDateFormat("HH:mm").format(new Date());
//	System.out.println("swSpinnerTimeValue: " + s);
	
	/*List<RoomBookingInfo> allreservedDetails=customerRegistration.getReserveIdBySearch(getTodayDate(),customer.getStoreId());*/
	List<RoomBooking> allreservedDetails=customerRegistration.getReserveIdBySearch(getTodayDate(),customer.getStoreId());
//	String reservedDetails = gson.toJson(allreservedDetails);
	mav.addObject("directBooking","N");
	mav.addObject("bookingId","N");
	session.setAttribute("allreservedDetails", allreservedDetails);
	/*if(allreservedDetails.size()==0)
	{
	  RoomBooking blankObj = new RoomBooking();
		blankObj.setReserveId("0");
		blankObj.setIsCheckIn("Y");
		allreservedDetails.add(blankObj);
	}*/
	System.out.println("booking details:"+gson.toJson(allreservedDetails));
	List<UniqueIdTypeMaster> allidType=customerRegistration.getAllUniqueIdType(customer.getStoreId());
	mav.addObject("uniqueIdTypeList",allidType);	
	mav.addObject("allreservedDetails",allreservedDetails);	
	mav.addObject(Constants.CHECK_IN,"Y");
	mav.setViewName(ForwardConstants.VIEW_ROOM_BOOKING_FORM_PAGE);
	return mav;
	}
	@RequestMapping(value="/directbooking",method=RequestMethod.POST)
	public void directbooking(@RequestBody RoomBooking roombooking,HttpSession session,HttpServletResponse response) throws IOException
	{
		
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");

			session.setAttribute("DirectRoomBookDetails", roombooking);
		
			out.print("success");
			out.flush();
		}
	}

//	@RequestMapping(value="/uploadidentity",method=RequestMethod.POST)
//	public ModelAndView uploadMenuItem(@Valid @ModelAttribute("menufile") IdentityFile menuFile, @RequestParam MultipartFile fileUpload,HttpSession session,HttpServletResponse response,HttpServletRequest request,BindingResult result)
//	{
//		logger.debug("in uploadmenuitem...! ");
//		ModelAndView mav=new ModelAndView();
//		Customer customer=null;
//		InputStream inputFile = null;
//		byte[] byteArr=null;
//		MultiPart multipartEntity=null;
//		//String identityFilePath=null;
//		RoomBooking roomBookDetails =(RoomBooking)session.getAttribute(Constants.ROOMBOOKING_CHECK_IN);	
//		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
//		{
//			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
//			return mav;
//		}
//		
//		if (fileUpload != null && fileUpload.getSize() > 0) {
//			try{
//				System.out.println("file name:"+fileUpload.getName());
//				System.out.println("original file name:"+fileUpload.getOriginalFilename());
//				System.out.println("file size:"+fileUpload.getSize());
//				inputFile=fileUpload.getInputStream();
//				byteArr=fileUpload.getBytes();
//				System.out.println("inputsterm:"+inputFile);
//				System.out.println("byte arr:"+byteArr);
//				String uploadsDir = "/uploads/";
//                String realPathtoUploads =  request.getServletContext().getRealPath(uploadsDir);
//                if(! new File(realPathtoUploads).exists())
//                {
//                    new File(realPathtoUploads).mkdir();
//                }
//				
//				System.out.println("path:"+realPathtoUploads);
//				String orgName = fileUpload.getOriginalFilename();
//                String filePath = realPathtoUploads +"/"+ orgName;
//                File dest = new File(filePath);
//                fileUpload.transferTo(dest);
//               // identityFilePath=filePath;
//                //out.print(filePath);
//        			//out.flush();
//                
//
//				//MenuFile menuFile=new MenuFile();
//                menuFile.setStoreId(customer.getStoreId());
//                menuFile.setFileName(fileUpload.getOriginalFilename());
//				
//                FileDataBodyPart filePart = new FileDataBodyPart("file", new File(filePath));
//				filePart.setContentDisposition(FormDataContentDisposition.name("file").fileName(fileUpload.getOriginalFilename()).build());
//				multipartEntity = new FormDataMultiPart().field("menuFile", new Gson().toJson(menuFile), MediaType.APPLICATION_JSON_TYPE).bodyPart(filePart);
//				
//				
//				//roomBookDetails.getRoombookinginfo().getCustomer().setIdentity(identityFile);
//				
//			//	String res=menuItemTranslationService.uploadMenuItems(identityFile,multipartEntity);
//			//	System.out.println("result:"+res);
//			//	mav.addObject("msg",res);
//
//				inputFile.close();
//			}catch (Exception e) {
//				logger.error("File uploading problem: ", e);
//			}
//		}
//		else
//		{
//			//result.reject("NotEmpty.menuitemupload.file");
//			// identityFilePath="";
//			// roomBookDetails.getRoombookinginfo().getCustomer().setIdentity(null);
// 			//out.flush();
//		}
//		String res1=customerRegistration.bookRoom(roomBookDetails);
//		System.out.print(res1);
//		String res2="";
//		if(res1.equalsIgnoreCase("success"))
//		{
//		 res2=customerRegistration.bookRoomStore(menuFile,multipartEntity);
//		}
//		System.out.println("res:"+res2);
//		mav.addObject("bookingId",res2);
//		List<RoomBookingInfo> reserveListByPeriod=customerRegistration.getReserveIdByPeriod(roomBookDetails.getRoombookinginfo().getFromDate(),roomBookDetails.getRoombookinginfo().getToDate(),customer.getStoreId());		
//		mav.addObject("fromdate",roomBookDetails.getRoombookinginfo().getFromDate());	
//		mav.addObject("todate",roomBookDetails.getRoombookinginfo().getToDate());	
//		mav.addObject("directBooking","N");
//		session.setAttribute("allreservedDetails", reserveListByPeriod);
//		if(reserveListByPeriod.size()==0)
//		{
//			RoomBookingInfo blankObj = new RoomBookingInfo();
//			blankObj.setReserveId("0");
//			blankObj.setIsCheckIn("Y");
//			reserveListByPeriod.add(blankObj);
//		}
//		mav.addObject("allreservedDetails",reserveListByPeriod);	
//	
//		mav.setViewName(ForwardConstants.VIEW_ROOM_BOOKING_FORM_PAGE);
//		return mav;
//}

@RequestMapping(value="/welcomedirectbooking",
			method = RequestMethod.GET)
	public ModelAndView welcomeDirectBooking(Model model,HttpSession session){
	ModelAndView mav = new ModelAndView();
	Customer customer=null;
	if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
	{
		mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
		return mav;
	}
	
	List<RoomBooking>allreservedDetails=customerRegistration.getReserveIdBySearch(getTodayDate(),customer.getStoreId());
	
//	String reservedDetails = gson.toJson(allreservedDetails);
	
	RoomBooking DirectRoomBookDetails =(RoomBooking)session.getAttribute(Constants.DIRECT_ROOM_BOOK_DETAILS);		
	System.out.print(DirectRoomBookDetails);
	mav.addObject("directBooking",DirectRoomBookDetails);	
	mav.addObject("bookingId","N");
	mav.addObject(Constants.CHECK_IN,"Y");
	mav.addObject("allreservedDetails",allreservedDetails);
    List<UniqueIdTypeMaster> allidType=customerRegistration.getAllUniqueIdType(customer.getStoreId());
	mav.addObject("uniqueIdTypeList",allidType);	
	mav.setViewName(ForwardConstants.VIEW_ROOM_BOOKING_FORM_PAGE);
	return mav;
	}

@RequestMapping(value="/getAllReserveDetails",method=RequestMethod.GET)
public void getAllReserveDetails(Model model, HttpSession session,HttpServletResponse response) throws IOException
{
	String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);
	
	Customer customer=null;
	
	if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
	{
		PrintWriter out = response.getWriter();

		List<RoomBookingInfo> reservedDetails =(List<RoomBookingInfo>)session.getAttribute(Constants.ALL_RESERVED_LIST);		
		System.out.print(reservedDetails);
		response.setContentType("text/plain");
		String jsonInString = gson.toJson(reservedDetails);	
		out.print(jsonInString);
		out.flush();
	}
}

@RequestMapping(value="/getDirectReserveDetails",method=RequestMethod.GET)
public void getDirectReserveDetails(Model model, HttpSession session,HttpServletResponse response) throws IOException
{
	Customer customer=null;
	
	if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
	{
		PrintWriter out = response.getWriter();

		RoomBooking DirectRoomBookDetails =(RoomBooking)session.getAttribute(Constants.DIRECT_ROOM_BOOK_DETAILS);	
		System.out.print(DirectRoomBookDetails);
		response.setContentType("text/plain");
		String jsonInString = gson.toJson(DirectRoomBookDetails);	
		out.print(jsonInString);
		out.flush();
	}
}

@RequestMapping(value = "/getCustomerDetailsById/{customerId}",method = RequestMethod.GET)//cancelReserveCustomer
public void getCustomerDetailsByReserveId(	@PathVariable("customerId") String customerId,
											HttpSession session,
											HttpServletResponse response) throws IOException
{

	Customer customer=null;
	
	if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
	{
		PrintWriter out = response.getWriter();
		String custDetails = customerRegistration.getCustomerDetailsById(customerId,customer.getStoreId());
		out.print(custDetails);
		out.flush();
	}
}

	@RequestMapping(value="/roombooking",method=RequestMethod.POST)
	public void reserveRoom(@RequestBody String roomBooking,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In roombooking......"+roomBooking);
		Customer customer=null;
		System.out.print(roomBooking);
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			Gson gson = new Gson();
			RoomBooking roomBookingDetails =gson.fromJson(roomBooking, new TypeToken<RoomBooking>() {}.getType());
			roomBookingDetails.setFrontDeskName(customer.getUserId());		
			
			String res=customerRegistration.bookRoom(roomBookingDetails);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/roombookingSessionStore",method=RequestMethod.POST)
	public void roombookingSessionStore(@RequestBody String roomBooking,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In roombooking......");
		Customer customer=null;
		System.out.print(roomBooking);
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			Gson gson = new Gson();
			RoomBooking roomBookingDetails =gson.fromJson(roomBooking, new TypeToken<RoomBooking>() {}.getType());
			session.setAttribute("roombookingCheckIn", roomBookingDetails);
			out.print("success");
			out.flush();
		}
	}
	
	
	@RequestMapping(value="/reservedcustomerbyperiod",method=RequestMethod.GET)
	public ModelAndView getReservedRoomList(@RequestParam String fromDate, @RequestParam String toDate, @RequestParam String bookingNo,Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In Room......");
		
		ModelAndView mav = new ModelAndView();
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		
		List<RoomBooking> reserveListByPeriod=customerRegistration.getReserveIdByPeriod(fromDate,toDate,customer.getStoreId(),bookingNo);		
		mav.addObject("fromdate",fromDate);	
		mav.addObject("todate",toDate);	
		mav.addObject("directBooking","N");
		mav.addObject("bookingId","N");
		session.setAttribute("allreservedDetails", reserveListByPeriod);
		/*if(reserveListByPeriod.size()==0)
		{
			RoomBookingInfo blankObj = new RoomBookingInfo();
			blankObj.setReserveId("0");
			blankObj.setIsCheckIn("Y");
			reserveListByPeriod.add(blankObj);
		}*/
		mav.addObject("allreservedDetails",reserveListByPeriod);	
		mav.addObject(Constants.CHECK_IN,"Y");
		List<UniqueIdTypeMaster> allidType=customerRegistration.getAllUniqueIdType(customer.getStoreId());
		mav.addObject("uniqueIdTypeList",allidType);
		mav.setViewName(ForwardConstants.VIEW_ROOM_BOOKING_FORM_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/reservedidbycustomeridbyperiod",method=RequestMethod.GET)
	public ModelAndView getReservedIdByCustIdByPeriod(@RequestParam String fromDate, @RequestParam String toDate,@RequestParam String custId, Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		ModelAndView mav = new ModelAndView();
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		
		List<RoomBooking> reserveListByPeriod=customerRegistration.getReserveIdByCustIdByPeriod(fromDate,toDate,custId,customer.getStoreId());		
		mav.addObject("fromdate",fromDate);	
		mav.addObject("todate",toDate);	
		mav.addObject("directBooking","N");
		mav.addObject("bookingId","N");
		mav.addObject("allreservedDetails",reserveListByPeriod);	
		mav.setViewName(ForwardConstants.VIEW_ROOM_BOOKING_FORM_PAGE);
		return mav;
	}
	@RequestMapping(value="/reservedidbyreserveid",method=RequestMethod.GET)
	public ModelAndView getReservedIdByReserveId(@RequestParam String resId, Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		ModelAndView mav = new ModelAndView();
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		
		List<RoomBookingInfo> reserveDetails=customerRegistration.getReserveIdByReserveId(resId,customer.getStoreId());		
		mav.addObject("fromdate",reserveDetails.get(0).getFromDate());	
		mav.addObject("todate",reserveDetails.get(0).getToDate());	
		mav.addObject("directBooking","N");
		mav.addObject("bookingId","N");
		mav.addObject("allreservedDetails",reserveDetails);	
		mav.setViewName(ForwardConstants.VIEW_ROOM_BOOKING_FORM_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/reservedetailsbyreserveid/{reserveId}",method=RequestMethod.GET)
	public void getReserveDetailsByReserveId(@PathVariable("reserveId") String resId, Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			List<RoomBookingInfo> reserveDetails=customerRegistration.getReserveIdByReserveId(resId,customer.getStoreId());	

		//	System.out.println("res:"+reserveDetails);
			
			String jsonInString = gson.toJson(reserveDetails);			
			System.out.println(jsonInString);
			out.print(jsonInString);
			out.flush();
		}
	}
	/*@RequestMapping(value = "/cancelreseveCustomer/{reserveId}",method = RequestMethod.GET)//cancelReserveCustomer
	public void cancelReserveCustomer(	@PathVariable("reserveId") String reserveId,
			HttpSession session,
			HttpServletResponse response) throws IOException
	{
		logger.debug("In Room......");
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			
			out.print(customerRegistration.cancelResevedCustomer(reserveId,customer.getStoreId()));
			out.flush();
		}
	}*/
	
	
	
	@RequestMapping(value = "/cancelreseveCustomer",method = RequestMethod.POST)//cancelReserveCustomer
  public void cancelReserveCustomer(  @RequestBody String roomBookingString,
      HttpSession session,
      HttpServletResponse response) throws IOException
  {
    logger.debug("In cancelReserveCustomer METHOD......"+roomBookingString);
    Customer customer=null;
    RoomBooking roomBooking =new RoomBooking();
    
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      PrintWriter out = response.getWriter();
      Gson gson = new GsonBuilder().create();
      roomBooking = gson.fromJson(roomBookingString, new TypeToken<RoomBooking>() {
      }.getType());
     
      String cancelledBy=""+customer.getId()+"";
      roomBooking.setCancelBy(cancelledBy);
      roomBooking.setHotelId(customer.getStoreId());
      //roomBooking.setHotelId(customer.getId());
      out.print(customerRegistration.cancelResevedCustomer(roomBooking));
      out.flush();
    }
  }
	
	
	
	
	//advancePayment
	
	
	/*@RequestMapping(value = "/advancePayment/{reserveId}/{bookingId}/{amount}",method = RequestMethod.GET)//cancelReserveCustomer
	public void cancelReserveCustomer(	@PathVariable("reserveId") String reserveId,@PathVariable("bookingId") String bookingId,
			@PathVariable("amount") String amount,
			HttpSession session,
			HttpServletResponse response) throws IOException
	{
		logger.debug("In Room......");
		
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			
			out.print(customerRegistration.advPaymentforResevedCustomer(reserveId,customer.getStoreId(),amount,bookingId));
			out.flush();
		}
	}*/
	
	
	@RequestMapping(value = "/advancePayment", method = RequestMethod.POST)
  public void roomBookingPayment(@RequestBody String roomBookingPayment, HttpSession session,
      HttpServletResponse response) throws IOException {
    logger.info("in roombookingpayment...");
    Customer customer;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
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
      logger.info("Payment Data:"+gson.toJson(payment));
      out.print(customerRegistration.advPaymentforResevedCustomer(payment));
      out.flush();
    }

  }
	
	
	
	
	
	
	
	@RequestMapping(value = "/searchcustbyname",
			method = RequestMethod.GET)
public void searchCustomerByName(	@RequestParam(value = "term") String tagName,
		@RequestParam(value = "fromDate") String fromDate,
		@RequestParam(value = "toDate") String toDate,
		@RequestParam(value = "func") String func,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("in searchCustomerByName...{}", tagName);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			Gson gson = new Gson();
	
			// String result = URLDecoder.decode(tagName, "UTF-8");
	 
			String result = tagName.replaceAll(" ", "%20");
			String custList = customerRegistration.getCustContactsbyName(customer.getStoreId(), result, fromDate, toDate, func);
			out.print(gson.toJson(custList));
			out.flush();
		}
}

@RequestMapping(value = "/searchcustbyphno",
			method = RequestMethod.GET)
public void searchCustomerByPhno(	@RequestParam(value = "term") String tagName,
		@RequestParam(value = "fromDate") String fromDate,
		@RequestParam(value = "toDate") String toDate,
		@RequestParam(value = "func") String func,
								HttpSession session,
								HttpServletResponse response) throws IOException {
	logger.debug("in searchCustomerByPhno...{}", tagName);
	Customer customer;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		Gson gson = new Gson();
		String custList = customerRegistration.getCustDetbyPhno(customer.getStoreId(), tagName, fromDate, toDate, func);
		out.print(gson.toJson(custList));
		out.flush();
	}
}

@RequestMapping(value = "/searchreserveid",
method = RequestMethod.GET)
public void searchResIdListByResId(	@RequestParam(value = "term") String tagName,
		@RequestParam(value = "fromDate") String fromDate,
		@RequestParam(value = "toDate") String toDate,
					HttpSession session,
					HttpServletResponse response) throws IOException {
		logger.debug("in searchreserveid...{}", tagName);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			Gson gson = new Gson();
			String custList = customerRegistration.getResDetListbyResId(customer.getStoreId(), tagName, fromDate, toDate);
			out.print(gson.toJson(custList));
			out.flush();
		}
}

	public String getTodayDate()
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    System.out.println("date:"+df.format(date));
		return df.format(date);
	}
	
	
//	
//	public String getDifferenceDate() 
//	{
//	String dateStart = "01/14/2012 09:29:58";
//	String dateStop = "01/15/2012 10:31:48";
//
//	//HH converts hour in 24 hours format (0-23), day calculation
//	SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
//
//	Date d1 = null;
//	Date d2 = null;
//
//	try {
//		d1 = format.parse(dateStart);
//		d2 = format.parse(dateStop);
//
//		//in milliseconds
//		long diff = d2.getTime() - d1.getTime();
//
//		long diffSeconds = diff / 1000 % 60;
//		long diffMinutes = diff / (60 * 1000) % 60;
//		long diffHours = diff / (60 * 60 * 1000) % 24;
//		long diffDays = diff / (24 * 60 * 60 * 1000);
//
//		System.out.print(diffDays + " days, ");
//		System.out.print(diffHours + " hours, ");
//		System.out.print(diffMinutes + " minutes, ");
//		System.out.print(diffSeconds + " seconds.");
//
//	} catch (Exception e) {
//		e.printStackTrace();
//	}
//}
	
	
	@RequestMapping(value = "/searchrmcustbyphone",
			method = RequestMethod.GET)
public void searchRoomCustomerByPhone(	@RequestParam(value = "term") String tagName,
								HttpSession session,
								HttpServletResponse response) throws IOException {
logger.debug("in searchRoomCustomerByPhone...{}", tagName);
Customer customer;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("application/json");
	Gson gson = new Gson();
	String custList = customerRegistration.getRmCustContactsbyPhoneNo(tagName,customer.getStoreId());
	out.print(gson.toJson(custList));
	out.flush();
}
}	
	
	
	
	
	
	@RequestMapping(value="/addroomcustomer",method=RequestMethod.POST)
  public void addStoreCustomer(@RequestBody String customerString,HttpSession session,HttpServletResponse response) throws IOException
  {
    logger.debug("In addstorecustomer......{}",customerString);
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      Gson gson = new GsonBuilder().create();
      StoreCustomer storeCust =gson.fromJson(customerString, new TypeToken<StoreCustomer>() {
      }.getType());

      storeCust.setStoreId(customer.getStoreId());
      storeCust.setCreditCustomer("N");
      String res=storecustomermgntService.addRoomCustomer(storeCust);
      System.out.println("res:"+res);
      out.print(res);
      out.flush();
    }
  }
	
	
	@RequestMapping(value="/checkin/{bookingId}",method=RequestMethod.GET)
  public void checkInIntoRoom(@PathVariable("bookingId") String bookingId,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
  {
    Customer customer=null;
    Store store=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
       RoomBooking roomBookingObj = new RoomBooking();
       roomBookingObj.setId(Integer.parseInt(bookingId));
       roomBookingObj.setHotelId(customer.getStoreId());
       out.print(customerRegistration.checkIn(roomBookingObj));
       out.flush();
    }
  }
	
	
	
	@RequestMapping(value="/getpaymentinfo/{bookingId}",method=RequestMethod.GET)
  public void getPaymentInfo(@PathVariable("bookingId") String bookingId,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
  {
     Customer customer=null;
    Store store=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      out.print(customerRegistration.getPaymentInfo(bookingId));
      out.flush();
    }
  }
	
	
	
	
	
	
}

