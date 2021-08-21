/**
 * 
 */
package com.sharobi.webpos.base.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sharobi.webpos.adm.model.FmcgUnit;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.ChildTable;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.OrderType;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.model.Table;
import com.sharobi.webpos.base.model.TableCombo;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.base.service.TableService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/table")
public class TableController {
	private final static Logger logger=LogManager.getLogger(TableController.class);
	@Autowired  TableService tableService;
	@Autowired  MenuService menuService;
	@Autowired  OrderService orderService;
	@Autowired  StoreService storeService;
	
	@Autowired MenuMgntService menumgntService;
	
	@RequestMapping(value="/viewtable",method=RequestMethod.GET)
	public ModelAndView getTableList(Model model,HttpSession session) throws ParseException
	{
		long st = System.currentTimeMillis();
		logger.debug("In Table......");
		String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);
		ModelAndView mav = new ModelAndView();
		List<ChildTable> childtableList=new ArrayList<ChildTable>();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<Table> tableList=tableService.getTableList(customer.getStoreId());
		List<Order> unpaidOrderList=orderService.getUnpaidOrderList(customer.getStoreId(), getTodayDate(),selLang);
		session.setAttribute(Constants.ALL_UNPAIDORDER_LIST, unpaidOrderList);
		List<MenuCategory> menuCatDirectList = tableService.getDirectCatList(customer.getStoreId());
		mav.addObject("menuCatDirectList", menuCatDirectList);
		DecimalFormat df=new DecimalFormat("00.00");
		Store store=null;
		store=(Store)session.getAttribute(Constants.LOGGED_IN_STORE);
		if(tableList!=null){
		if(tableList.size()>0)
		{
			for(Table tables:tableList)
			{
				List<Order> orderList=new ArrayList<Order>();
				if(unpaidOrderList!=null){
				if(unpaidOrderList.size()>0)
				{
					for(Order orders:unpaidOrderList)
					{ 
						if(tables.getTableNo().equals(orders.getTable_no()))
						{
							/*double staticVat=14.5;
							double staticST=5.6;
							double totVat = 0;
							double totST = 0;
							double totRate = 0;
							double totDisc = 0;
							double scharge = 0;
							double totAmt;*/
							/*for(OrderItem items:orders.getOrderitem())
							{
								double disc=0;
								double rate=0;
								double vat=0;
								double ST=0;
								rate=items.getItem().getPrice()*Integer.parseInt(items.getQuantityOfItem());
								if(items.getItem().getPromotionFlag().equalsIgnoreCase("Y"))
								{
									disc=(items.getItem().getPrice()*items.getItem().getPromotionValue()/100)*Integer.parseInt(items.getQuantityOfItem());
								}
								if(store.getId()==35 && !orders.getTable_no().equals("0") && items.getItem().getVat()==0.0)
								{
									vat=Double.parseDouble(df.format((rate-disc)*(staticVat/100)));
								}
								else{
									vat=Double.parseDouble(df.format((rate-disc)*(items.getItem().getVat()/100)));
								}
								if(store.getId()==35 && !orders.getTable_no().equals("0") && items.getItem().getServiceTax()==0.0)
								{
									ST=Double.parseDouble(df.format((rate-disc)*(staticST/100)));
								}
								else{
									ST=Double.parseDouble(df.format((rate-disc)*(items.getItem().getServiceTax()/100)));
								}
								totRate+=rate;
								totDisc+=disc;
								totVat+=vat;
								totST+=ST;
							}
*/							/*if(store.getServiceChargeRate()!=0.00){
								scharge=totRate * store.getServiceChargeRate()/100;
								totVat=totVat+totVat* store.getServiceChargeRate()/100;
								totST=totST+totST* store.getServiceChargeRate()/100;
							}
							totAmt=(totRate+scharge+totVat+totST)-totDisc;
							if(store.getRoundOffTotalAmtStatus().equalsIgnoreCase("Y"))
							{
								totAmt=Math.round(totAmt);
							}*/
							StringTokenizer st2 = new StringTokenizer(orders.getChildTables(), "/");
							while(st2.hasMoreElements())
							{
								ChildTable cdT=new ChildTable();
								cdT.setChildTableNo(st2.nextElement().toString());
								cdT.setParentTableNo(orders.getTable_no());
								childtableList.add(cdT);
							}
							if(store.getMultiOrderTable().equalsIgnoreCase("Y") && tables.getMultiOrder().equalsIgnoreCase("Y"))
							{
								orderList.add(orders);
								tables.setIsBooked("Y");
							}
							else
							{
								tables.setOrder(orders);
								tables.setIsBooked("Y");
								tables.setNoofItem(orders.getOrderitem().size());
								//tables.setOrderAmt(Double.parseDouble(df.format(totAmt)));
								tables.setOrderAmt(Double.parseDouble(df.format(orders.getOrderBill().getBillAmount())));
							}
						
						   if(orders.getBillPrintcount()>0){ //new added 26th June 2018
							   tables.setIsBilled("Y");
							   //System.out.println("table no:"+tables.getTableId()+"isbilled:"+tables.getIsBilled());
						   }
						
						
						
						}
						
					}
					tables.setMultiOrders(orderList);
					tables.setNoofOrder(orderList.size());
				}
			}
				System.out.println("data::"+tables.getTableNo()+":"+childtableList.toString());
				if(childtableList.size()>0)
				{
					for(ChildTable cdt:childtableList)
					{
						if(tables.getTableNo().equals(cdt.getChildTableNo()))
						{
							tables.setIsBooked("Y");
							tables.setIschildTable("Y");
							tables.setParentTable(cdt.getParentTableNo());
						}
					}
				}
			}
		}
	 }
		List<OrderType> orderTypeList = orderService.getOrderType(customer.getStoreId());
		/*if (orderTypeList.size() > 0) {
			for (OrderType orderType : orderTypeList) {
				    mav.addObject("orderType", orderType);
					break;
			
			}
		}*/
		
		//mav.addObject("orderTypeName", tno);
	//	mav.addObject("currentSeat", sno.equals("") ? "0" : sno);
		session.setAttribute(Constants.ALL_ORDERTYPE_LIST, orderTypeList);
		
		/*try{Display display=new Display();
		display.StartDisplay();
		display.ShowGreeting();
		}
		catch(Exception ex){ex.printStackTrace();}*/
		//System.out.println("Tables:"+tableList.toString());
		//model.addAttribute("table",new Table());
		mav.addObject("tableList", tableList);
		session.setAttribute("TableList", tableList);
		mav.addObject(Constants.TABLE_MANAGEMENT,"Y");
		List<Customer> waiterlist=storeService.getAllWaitersByStoreid(customer.getStoreId());
		mav.addObject("waiterlist",waiterlist);		
		Store s = (Store) session.getAttribute(Constants.LOGGED_IN_STORE);
		
		
		
		
		/*This part for counting advance table booking orderlist size */
		//List<Order> bookingList=orderService.getAllPreBookingList(customer.getStoreId());
		/*List<Order> filteredbookingList=new ArrayList<Order>();
		Calendar calendar = Calendar.getInstance();
		Date today = calendar.getTime();		
		calendar.add(Calendar.DAY_OF_YEAR, 1);
		Date tomorrow = calendar.getTime();
		SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");
		String todaydate = newFormat.format(today);
        String tomorrowdate = newFormat.format(tomorrow);
        DateFormat formatter = new SimpleDateFormat("MMM d, yyyy HH:mm:ss a"); 
        if(bookingList!=null){
        if(bookingList.size()>0){
        for(Order ob2: bookingList){
        	Date date = (Date)formatter.parse(ob2.getOrderDate());				
			String finalString = newFormat.format(date);
            ob2.setOrderDate(finalString);
        	
			if(ob2.getOrderDate().equals(todaydate) || ob2.getOrderDate().equals(tomorrowdate)){
				filteredbookingList.add(ob2);
			}			
		}
	  }
	}
	mav.addObject("noofpreorder",filteredbookingList.size());*/
	//mav.addObject("noofpreorder",bookingList.size());
		String ordercount=orderService.getCountOfAdvanceBooking(customer.getStoreId());
    mav.addObject("noofpreorder",ordercount);
		
		
	//add new for add item from table page start(date 5th Oct 2018)
	
	List<MenuCategory> menucategoryList=menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
	if(menucategoryList.size()!=0){
	 //session.setAttribute("sescategoryList", menucategoryList);
	MenuCategory menuCategory=menumgntService.getAllMenuTree(customer.getStoreId());
	session.setAttribute("categoryTree", menuCategory);
	//List<MenuCategory> menuCatList=(List<MenuCategory>) session.getAttribute("sescategoryList");
	MenuCategory menucategory = null;
	//menucategory=menuCatList.get(0);
	menucategory=menucategoryList.get(0);
	List<MenuCategory> menusubcategoryList=menumgntService.getMenuSubCategoryByStoreId(customer.getStoreId(),menucategory.getId());
	List<FmcgUnit> fmcgList=menumgntService.getFmcgUnitByStoreId(customer.getStoreId());
	//mav.addObject("menucatList",menuCatList);
	mav.addObject("menucatList",menucategoryList);
	mav.addObject("menusubcatList",menusubcategoryList);
	mav.addObject("fmcgList",fmcgList);
	
	session.removeAttribute(Constants.MENU_ALL_TREE);
	Locale locale = LocaleContextHolder.getLocale();
	Menu allMenuList = menuService.getAllMenuList(customer.getStoreId(),locale.getDisplayLanguage());
	session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
	}
	
	//add new for add item from table page end	
		
		if (s.getEnterpriseTblLayout().equalsIgnoreCase("Y")) {
			System.out.println("VIEW_TABLE_PAGE_NEW");
			mav.setViewName(ForwardConstants.VIEW_TABLE_PAGE_NEW);
			
		} else {
			System.out.println("VIEW_TABLE_PAGE");
			mav.setViewName(ForwardConstants.VIEW_TABLE_PAGE);
		}
		long et = System.currentTimeMillis();
		System.out.println("Elapsed time in webpos for table loading:" + (et - st));
        return mav;
	}
	
	@RequestMapping(value="/updatetableStatus/{tid}/{op}",method=RequestMethod.GET)
	public void upadateTableStatus(@PathVariable("tid") int tid,@PathVariable("op") int op,HttpSession session,HttpServletResponse response)throws IOException
	{
		logger.debug("in update table status...! {}, {}", tid, op);
		TableCombo table=new TableCombo();
		Customer customer;
		try{
			if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
			{
				table.setId(tid);
				table.setStatus(this.getStatusString(op));
				tableService.updateTableSatus(table);
			}
			
		}catch (Exception e) {
			logger.error("Exception:",e);
		}
	}
	
	private String getStatusString(int operationId) {
		return operationId == 1 ? "Y" : "N";
	}
	
	/*@RequestMapping(value="/bookingTable/{tableId}/{tableNo}",method=RequestMethod.GET)
	public ModelAndView bookingTable(@PathVariable("tableId") int tableId,@PathVariable("tableNo") int tableNo,Model model,HttpSession session)throws IOException
	{
		logger.debug("in booking table...! {}, {}", tableId, tableNo);
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		Menu allMenuList=menuService.getAllMenuList(customer.getStoreId());
		session.setAttribute(Constants.MENU_ALL_TREE,allMenuList);
		mav.addObject("allmenu",allMenuList);
		mav.addObject("tableId",tableId);
		mav.addObject("tableNo",tableNo);
		mav.setViewName("redirect:/order/vieworder");
		return mav;
	}*/
	
	public String getTodayDate()
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    //java.util.Calendar cal=java.util.Calendar.getInstance();
	   // System.out.println("date:"+df.format(date));
		return df.format(date);
	}
	
	
	@RequestMapping(value = "/setwaitername", method = RequestMethod.GET)
	 public void setWaiterName( @RequestParam(value = "waiterName") String waiterName,
	    HttpSession session,
	   HttpServletResponse response) throws IOException {
	
	  Customer customer;
	  if ((customer = (Customer) session
	    .getAttribute(Constants.LOGGED_IN_USER)) != null) {
	
		   PrintWriter out = response.getWriter();

	   response.setContentType("text/plain");
	   
	 	   
	   session.setAttribute("waiterName", waiterName);
	  // out.print(orderService.getPaymentInfo(NumberUtils.toInt(orderno)));
	   out.flush();
	  }
	 }
	
	 @RequestMapping(value="/autocompletewaiterdata",method=RequestMethod.GET)
	   public List<Customer> viewWaiterDetails(@RequestParam String tagName,HttpSession session,HttpServletResponse response) throws IOException {
	          logger.debug("In autocompleteitemcodewaitter......{}", tagName);
	          Customer customer = null;
	          if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
	               return null;
	              }
	           List<Customer> customers=storeService.getAllWaitersByStoreid(customer.getStoreId());
	           List<Customer> refinecustomers=new ArrayList<Customer>(); 
	           //System.out.println("waiter List size:" + customers);

	          for (Customer alpha : customers) {

	               if (StringUtils.startsWithIgnoreCase(alpha.getName(), tagName)) {
	               refinecustomers.add(alpha);
	                  }
	               if (StringUtils.startsWithIgnoreCase(alpha.getUserId(), tagName)) {
	                   refinecustomers.add(alpha);
	                      }


	               }
	         //System.out.println("refine waiter List :" + refinecustomers);
	         PrintWriter out = response.getWriter();
	         response.setContentType("application/json");
	         Gson gson = new Gson();
	         out.print(gson.toJson(refinecustomers));
	         return null;

	          }
	
	
}
