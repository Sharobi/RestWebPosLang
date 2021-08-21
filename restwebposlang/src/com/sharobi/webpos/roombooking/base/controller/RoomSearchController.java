package com.sharobi.webpos.roombooking.base.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.MediaType;

import org.apache.commons.io.FilenameUtils;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.controller.TableController;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.StoreCustomerFile;
import com.sharobi.webpos.hr.model.Employee;
import com.sharobi.webpos.hr.model.EmployeeFile;
import com.sharobi.webpos.roombooking.adm.model.Floor;
import com.sharobi.webpos.roombooking.adm.model.Room;
import com.sharobi.webpos.roombooking.adm.model.RoomBookingType;
import com.sharobi.webpos.roombooking.adm.model.RoomType;
import com.sharobi.webpos.roombooking.adm.service.RoomTypeService;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.roombooking.base.model.RoomBookingInfo;
import com.sharobi.webpos.roombooking.base.model.UniqueIdTypeMaster;
import com.sharobi.webpos.roombooking.base.service.CustomerRegistrationService;
import com.sharobi.webpos.roombooking.base.service.RoomSearchService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataMultiPart;
import com.sun.jersey.multipart.MultiPart;
import com.sun.jersey.multipart.file.FileDataBodyPart;

@Controller
@RequestMapping("/room")
public class RoomSearchController {
	private final static Logger logger=LogManager.getLogger(RoomSearchController.class);
	private final static RoomSearchService roomService=new RoomSearchService();
	private final static RoomTypeService rmtypeService=new RoomTypeService();
	private final static CustomerRegistrationService customerRegistration = new CustomerRegistrationService();
	private final static Gson gson=new Gson();
	
	@RequestMapping(value="/viewroom",method=RequestMethod.GET)
	public ModelAndView getRoomList(Model model,HttpSession session)
	{
		logger.debug("In Room View......");
		ModelAndView mav = new ModelAndView();

		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<Room> roomList=roomService.getRoomListBySearch(getTodayDate(),getTomorrowDate(),customer.getStoreId());
		
		int maxFloor=0;
		
		/*if(roomList==null || roomList.isEmpty()){}
		else{}*/
		for(int i = 0; i<roomList.size();i++)
		{
			if(roomList.get(i).getFloor()>=maxFloor)
			{
				maxFloor=roomList.get(i).getFloor();
			}
		}
		
		List<Floor> floorList = new ArrayList<Floor>();
		Floor floor = new Floor();
		List<Room> room = new ArrayList<Room>();	
		List<Integer> matchedPos = new ArrayList<Integer>();
		for(int i = 0; i<roomList.size(); i++)
		{
		//	System.out.println(i+ " " + roomList.size() + " " + roomList.get(i).getFloor() + " " + maxFloor);
			int pos = 0;

			if(roomList.get(i).getFloor()==maxFloor)
			{
				room.add(roomList.get(i));
				pos=i;
				matchedPos.add(pos);
			}
			if(maxFloor>=0 && i==roomList.size()-1)
			{
				if(matchedPos.size()>0)
				{
					for(int j = matchedPos.size()-1;j>=0;j--)
						roomList.remove(matchedPos.get(j).intValue());
				}
				matchedPos = new ArrayList<Integer>();
				if(room.size()>0)
				{
					floor.setRoom(room);
					floor.setFloor(Integer.toString(maxFloor));
					floorList.add(floor);	
				}
				floor = new Floor();
				room = new ArrayList<Room>();	
				i=-1;
				maxFloor--;
				continue;
			}
		}
		
		String jsonInString = gson.toJson(floorList);			
		System.out.println(jsonInString);
		
		mav.addObject("floorList", floorList); // floorList contain total rooms and respective floor details
		session.setAttribute("floorList", floorList); // set floorList(all data filtered by store id) in session for further access
		
		List<RoomType> roomtypeList=rmtypeService.getRoomTypeByStoreId(customer.getStoreId());
		mav.addObject("roomtypeList",roomtypeList);	//	roomtypeList contain all room types
		List<RoomBookingType> roombookingtypeList=rmtypeService.getRoomBookingTypeByStoreId(customer.getStoreId());
		mav.addObject("roombookingtypeList",roombookingtypeList); 
		mav.addObject(Constants.ROOM_SERCH,"Y");
		List<UniqueIdTypeMaster> allidType=customerRegistration.getAllUniqueIdType(customer.getStoreId());
	  mav.addObject("uniqueIdTypeList",allidType);
		mav.setViewName(ForwardConstants.VIEW_ROOM_SEARCH_PAGE);
					
		return mav;
	}
	
	@RequestMapping(value="/searchroom",method=RequestMethod.GET)
	public ModelAndView getRoomList(@RequestParam String fromDate, @RequestParam String toDate, Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In Room......");
		
		ModelAndView mav = new ModelAndView();
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
	
		List<Room> roomList=roomService.getRoomListBySearch(fromDate,toDate,customer.getStoreId());		
			

			int maxFloor=0;
			for(int i = 0; i<roomList.size();i++)
			{
				if(roomList.get(i).getFloor()>=maxFloor)
				{
					maxFloor=roomList.get(i).getFloor();
				}
			}
			List<Floor> floorList = new ArrayList<Floor>();
			Floor floor = new Floor();
			List<Room> room = new ArrayList<Room>();	
			List<Integer> matchedPos = new ArrayList<Integer>();
			for(int i = 0; i<roomList.size(); i++)
			{
				int pos = 0;

				if(roomList.get(i).getFloor()==maxFloor)
				{
					room.add(roomList.get(i));
					pos=i;
					matchedPos.add(pos);
				}
				if(maxFloor>=0 && i==roomList.size()-1)
				{
					if(matchedPos.size()>0)
					{
						for(int j = matchedPos.size()-1;j>=0;j--)
							roomList.remove(matchedPos.get(j).intValue());
					}
					matchedPos = new ArrayList<Integer>();
					if(room.size()>0)
					{
						floor.setRoom(room);
						floor.setFloor(Integer.toString(maxFloor));
						floorList.add(floor);	
					}
					floor = new Floor();
					room = new ArrayList<Room>();	
					i=-1;
					maxFloor--;
					continue;
				}
			}
			
			String jsonInString = gson.toJson(floorList);			
			System.out.println(jsonInString);
			mav.addObject("fromdate", fromDate);
			mav.addObject("todate", toDate);
			
//			session.setAttribute("floorList", floorList);
//			out.print(floorList);
//			out.flush();
			
			
			mav.addObject("floorList", floorList);
			session.setAttribute("floorList", floorList);// set floorList(all data filtered by from_date ,to_date and store_id) in session for further access
			
			
			List<RoomType> roomtypeList=rmtypeService.getRoomTypeByStoreId(customer.getStoreId());
			mav.addObject("roomtypeList",roomtypeList);	
			List<UniqueIdTypeMaster> allidType=customerRegistration.getAllUniqueIdType(customer.getStoreId());
	    mav.addObject("uniqueIdTypeList",allidType);
	    List<RoomBookingType> roombookingtypeList=rmtypeService.getRoomBookingTypeByStoreId(customer.getStoreId());
	    mav.addObject("roombookingtypeList",roombookingtypeList); 
			mav.addObject(Constants.ROOM_MANAGEMENT,"Y");
			mav.addObject(Constants.ROOM_SERCH,"Y");
			mav.setViewName(ForwardConstants.VIEW_ROOM_SEARCH_PAGE);
						
			return mav;
//		}
	}
	
	
	@RequestMapping(value="/getallrooms",method=RequestMethod.GET)
	public ModelAndView getAllRooms(@RequestParam String fromDate, @RequestParam String toDate, Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In getAllRooms......");
		
		ModelAndView mav = new ModelAndView();
		
		Customer customer=null;
		
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
			List<Floor> floorList =(List<Floor>)session.getAttribute(Constants.FLOOR_LIST);
		
			mav.addObject("floorList", floorList);
			
			mav.addObject("fromdate", fromDate);
			mav.addObject("todate", toDate);
			
			List<RoomType> roomtypeList=rmtypeService.getRoomTypeByStoreId(customer.getStoreId());
			mav.addObject("roomtypeList",roomtypeList);		
			List<UniqueIdTypeMaster> allidType=customerRegistration.getAllUniqueIdType(customer.getStoreId());
	    mav.addObject("uniqueIdTypeList",allidType);
	    List<RoomBookingType> roombookingtypeList=rmtypeService.getRoomBookingTypeByStoreId(customer.getStoreId());
	    mav.addObject("roombookingtypeList",roombookingtypeList); 
			mav.addObject(Constants.ROOM_MANAGEMENT,"Y");
			mav.setViewName(ForwardConstants.VIEW_ROOM_SEARCH_PAGE);
						
			return mav;
//		}
	}
	
	@RequestMapping(value="/getrooms",method=RequestMethod.GET)
	public void getRooms(Model model, HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In Room......");
				
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			
			List<Floor> floorList =(List<Floor>)session.getAttribute(Constants.FLOOR_LIST);		
			System.out.print(floorList);
			String jsonInString = gson.toJson(floorList);	
			response.setContentType("text/plain");
			out.print(jsonInString);
			out.flush();
		}
	}
	
	@RequestMapping(value="/reserveroom",method=RequestMethod.POST)
	public void reserveRoom(@RequestBody String roomBookingInfo,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In reserveroom......"+roomBookingInfo);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			Gson gson = new Gson();
			RoomBookingInfo roomBookingDetails =gson.fromJson(roomBookingInfo, new TypeToken<RoomBookingInfo>() {}.getType());

			String res=roomService.reserveRoom(roomBookingDetails);
			System.out.println("res:"+res);
			out.print(res);
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
	
	public String getTomorrowDate(){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    Date tomorrow = new Date(date.getTime() + (1000 * 60 * 60 * 24));
	    System.out.println("tomorrow date:"+df.format(tomorrow));
		return df.format(tomorrow);
		
	}
	
	@RequestMapping(value = "/getavailablerooms", method = RequestMethod.GET)
  public void getAvailableRooms( @RequestParam String fromDate, 
                                 @RequestParam String   toDate,
                                 HttpSession session, 
                                 HttpServletResponse response) throws IOException {
    logger.debug("in getavailablerooms...");
    Customer customer;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
        PrintWriter out = response.getWriter();
        response.setContentType("text/plain");
        out.print(roomService.getAvailableRoomListForChange(fromDate,toDate,customer.getStoreId()));
        out.flush();
    }
  }
	
	
	@RequestMapping(value = "/getSelectedRoomData", method = RequestMethod.GET)
  public void getRoomDetails( @RequestParam String roomId, 
                                 HttpSession session, 
                                 HttpServletResponse response) throws IOException {
    logger.debug("in getRoomDetails...");
    Customer customer;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
        PrintWriter out = response.getWriter();
        response.setContentType("text/plain");
        out.print(roomService.getSelectedRoomDetails(roomId,customer.getStoreId()));
        out.flush();
    }
  }
	
	@RequestMapping(value="/changeroom/{newRoomId}/{oldRoomId}/{reserveId}/{bookingId}/{newRoomRate}/{taxId}/{taxRate}",method=RequestMethod.GET)
  public void updateCheckoutHistory(@PathVariable("newRoomId") String newRoomId,@PathVariable("oldRoomId") String oldRoomId,@PathVariable("reserveId") String reserveId,@PathVariable("bookingId") String bookingId,@PathVariable("newRoomRate") String newRoomRate,@PathVariable("taxId") String taxId,@PathVariable("taxRate") String taxRate,HttpSession session,HttpServletResponse response) throws IOException
  {
    logger.debug("in Change room...{}{}{}! "+newRoomId+oldRoomId+reserveId+bookingId);
    Customer customer=null;
    
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
    {
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      out.print(roomService.changeRoom(newRoomId,oldRoomId,reserveId,bookingId,newRoomRate,taxId,taxRate,customer.getStoreId()));
      out.flush();
      
    }
  }
	
	
	@RequestMapping(value = "/getCustomerDetailsByPhoneOrName", method = RequestMethod.GET)
  @ResponseBody
  public String getCustomerDetailsByPhoneOrName(@RequestHeader("storeId") String storeId,@RequestHeader("searchterm") String searchterm,@RequestHeader("is_phone")Boolean is_phone, HttpSession session,HttpServletRequest request) throws Exception {
	  /*URL FOR SEARCH BY CUSTOMER  PHONE NUMBER FOR ROOMBOOKING IS:
    http://192.168.1.34:8082/Restaurant/rest/storeCustomer/getAllRBStoreCustomerByPhNmbr?storeId={1}&phone={2}
    URL FOR SEARCH BY CUSTOMER NAME FOR ROOM BOOKING IS:
    http://192.168.1.34:8082/Restaurant/rest/storeCustomer/getAllRBStoreCustomerByName?storeId={1}&name={2}
*/  
	  String response = null;
    logger.debug("In getCustomerDetailsByPhoneOrName METHOD In RoomSearchController.java CLASS ......");
    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
     
        response=roomService.getCustomerDetailsByPhoneOrName(storeId, searchterm, is_phone);
    }
    logger.debug("RESPONSE IN RoomSearchController CONTROLLER FOR getCustomerDetailsByPhoneOrName Method Is .....");
    logger.debug(response);
    return response;
  }
	
	
	 @RequestMapping(value = "/getCreditBookingByCustomerId", method = RequestMethod.GET)
	  @ResponseBody
	  public String getCreditBookingByCustomerId(@RequestHeader("storeId") String storeId,@RequestHeader("custId") String custId, HttpSession session,HttpServletRequest request) throws Exception {
	   /*URL FOR THIS IS=
     http://192.168.1.34:8082/Restaurant/rest/roomsearch/getCreditBookingByCustomerId?storeId=29&custId=848
*/   
	    String response = null;
	    logger.debug("In getCreditBookingByCustomerId METHOD In RoomSearchController.java CLASS ......");
	    Customer customer = null;
	    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	     
	        response=roomService.getCreditBookingByCustomerId(storeId, custId);
	    }
	    logger.debug("RESPONSE IN RoomSearchController CONTROLLER FOR getCreditBookingByCustomerId Method Is .....");
	    logger.debug(response);
	    return response;
	  }
	
	
	 
	 
	 
	 @RequestMapping(value = "/getPaymentInfoByBookingId", method = RequestMethod.GET)
   @ResponseBody
   public String getPaymentInfoByBookingId(@RequestHeader("bookingId") String bookingId, HttpSession session,HttpServletRequest request) throws Exception {
	   /* URL FOR THIS IS
	    http://192.168.1.34:8082/Restaurant/rest/roomsearch/getPaymentInfoByBookingId?bookingId=16
	*/   
     String response = null;
     logger.debug("In getCreditBookingByCustomerId METHOD In RoomSearchController.java CLASS ......");
     Customer customer = null;
     if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
      
         response=roomService.getPaymentInfoByBookingId(bookingId);
     }
     logger.debug("RESPONSE IN RoomSearchController CONTROLLER FOR getPaymentInfoByBookingId Method Is .....");
     logger.debug(response);
     return response;
   }
 
	 
	 @RequestMapping(value="/addMoreRoom",method=RequestMethod.POST)
	 @ResponseBody
	  public String addMoreRoom(@RequestBody String roomBooking,HttpSession session,HttpServletRequest request) throws IOException
	  {
	   /*URL FOR THIS IS:http://192.168.1.34:8082/Restaurant/rest/roomsearch/addMoreRoom
	   */  
	    logger.debug("In addMoreRoom in RoomSearchController.java File......"+roomBooking);
	    String response = null;
	    Customer customer=null;
	    Boolean status=false;
	    JsonObject jobj= new JsonObject();
	    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
	    {
	      Gson gson = new Gson();
	      RoomBooking roomBookingObject =gson.fromJson(roomBooking, new TypeToken<RoomBooking>() {}.getType());
	      response =roomService.addMoreRoom(roomBookingObject);
	      if(response!=null){
	        status=response.equalsIgnoreCase("success")?true:false;
	      }
	    }
	    logger.debug("RESPONSE IN RoomSearchController CONTROLLER FORaddMoreRoom Method Is .....");
	    logger.debug(response);
	    jobj.addProperty("status", status);
	    return jobj.toString();
	  }
	 
	 @RequestMapping(value = "/uploadCustImage", method = RequestMethod.POST)
	  @ResponseBody
	  public String uploadCustImage(@RequestParam("id") Integer custid, @RequestParam("file") MultipartFile fileUpload,
	      HttpSession session, HttpServletResponse response, HttpServletRequest request) {
	 /* public String uploadCustImage(@RequestParam MultipartFile fileUpload,
        @RequestParam String custimgName,
        @RequestParam String custimgid,
        @RequestParam String custimgPhone,
        HttpSession session,
        HttpServletResponse response,
        HttpServletRequest request) {*/
	    logger.debug("in uploadCustImage...! ");
	    StoreCustomerFile custfile = new StoreCustomerFile();
	    Customer customer = null;
	   
	    JsonObject jobj = new JsonObject();
	    jobj.addProperty("is_upload", false);
	    Boolean resp = false;
	   
	    customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER);
	    if (customer != null) {
	      if (fileUpload != null && fileUpload.getSize() > 0 && CanFileUpload(fileUpload)) {
	        try {
	          String uploadsDir = "/uploads/";
	          String realPathtoUploads = request.getServletContext().getRealPath(uploadsDir);
	          File pathtoupload = new File(realPathtoUploads);
	          if (!pathtoupload.exists()) {
	            pathtoupload.mkdir();
	          }

	          System.out.println("path:" + realPathtoUploads);
	          String extension = FilenameUtils.getExtension(fileUpload.getOriginalFilename());
	          System.out.println("ext:"+extension);
	          if("jpg".equals(extension) || "jpeg".equals(extension))
	          {
	          String orgName = fileUpload.getOriginalFilename();
	          String filePath = realPathtoUploads + "/" + orgName;
	          File dest = new File(filePath);
	          fileUpload.transferTo(dest);
	          String storeId = "'" + customer.getStoreId() + "'";
	          custfile.setId(custid);
	          custfile.setStoreId(storeId);
	          custfile.setFileName(fileUpload.getOriginalFilename());
	          FileDataBodyPart filePart = new FileDataBodyPart("file", new File(filePath));
	          filePart.setContentDisposition(
	              FormDataContentDisposition.name("file").fileName(fileUpload.getOriginalFilename()).build());
	          MultiPart multipartEntity = new FormDataMultiPart()
	              .field("cust", new Gson().toJson(custfile), MediaType.APPLICATION_JSON_TYPE).bodyPart(filePart);

	          String response2 = roomService.uploadCustImage(multipartEntity);

	          resp = response2.equalsIgnoreCase("Success") ? true : false;
	          jobj.addProperty("is_upload", resp);
	           System.out.println("AFTER UPLOAD EMPLOYEE IMAGE RESPONSE IS:" +response2);
	          }else
	          {
	            jobj.addProperty("is_upload", false);
	            jobj.addProperty("errormsg", "Only jpeg/jpg file allowed");
	          }
	        } catch (Exception e) {
	          logger.error("File uploading problem: ", e);
	        }
	      } else {
	        jobj.addProperty("is_upload", false);
	        jobj.addProperty("errormsg", "File Size Should Not Exceed 1Mb Size");
	      }
	    }
	    return jobj.toString();
	    //return "redirect:/customer/welcome.htm";
	  }
	 
	 public boolean CanFileUpload(MultipartFile fileUpload) {
	    Long fileSizeInMb = fileUpload.getSize() / (1024 * 1024);
	    Boolean response = false;
	    response = (fileSizeInMb <= 1) ? true : false;
	    return response;
	  }
	
	 @RequestMapping(value = "/getCustImageById", method = RequestMethod.GET)
	  @ResponseBody
	  public String getCustImageById(@RequestParam("id") String id) {
	    //Employee employee = null;
	    //JsonArray jarr = new JsonArray();
	    logger.debug("In getCustImageById......{}",id);

	    //employee = hrMgmtService.getEmployeeByStoreIdAndId(storeId, id);
	    String photourl = roomService.getCustImageById(Integer.parseInt(id));
	    //String docurl = hrMgmtService.getEmployeeDocImageById(id);
	    /*if (photourl != null) {
	      employee.setPhoto(photourl);
	    }
	    if (docurl != null) {
	      employee.setIdProofDocImage(docurl);
	    }
	    Gson gson = new Gson();
	    String gresponse = gson.toJson(employee);
	    // System.out.println("res:" + gresponse);
	    return gresponse;*/
	    return photourl;
	  }
	
	
}




