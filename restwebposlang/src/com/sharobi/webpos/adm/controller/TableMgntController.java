/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.TableMaster;
import com.sharobi.webpos.adm.model.Tables;
import com.sharobi.webpos.adm.service.TableMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.model.Table;
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
@RequestMapping("/tablemgnt")
public class TableMgntController {
	private final static Logger logger=LogManager.getLogger(TableMgntController.class);
	@Autowired  TableMgntService tablemgntService;
	@Autowired  TableService tableService;
	@Autowired  OrderService orderService;
	@Autowired  StoreService storeService;
	
	@RequestMapping(value="/loadtablemgnt",method=RequestMethod.GET)
	public ModelAndView loadTableMgnt(HttpSession session)
	{
		logger.debug("in loadtablemgnt...! ");
		String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<Tables> tableListforMgnt=tablemgntService.getTableListforMgnt(customer.getStoreId());
		session.setAttribute("existingTableList", tableListforMgnt);
		List<Order> orderList=orderService.getUnpaidOrderList(customer.getStoreId(), getTodayDate(),selLang);
		if(orderList.size()>0)
		{
			for(Order orders:orderList)
			{
				for(Tables tables:tableListforMgnt)
				{
					if(tables.getTableNo().equals(orders.getTable_no()))
					{
						tables.setIsBooked("Y");
					}
				}
			}
		}
		mav.addObject("tableListforMgnt", tableListforMgnt);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_TABLE_MGNT_PAGE);
		return mav;
	}
	@RequestMapping(value="/addtable",method=RequestMethod.POST)
	public void addTable(@RequestBody String tablepost,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In addtable......{}",tablepost);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			Tables table=gson.fromJson(tablepost, new TypeToken<Tables>() {
			}.getType());
			String tableno=table.getTableNo();
			/*String tableNo;
			int tabno=Integer.parseInt(tableno);
			if(tabno<10){tableNo="0"+tabno;}
			else{tableNo=""+tabno;}*/
			String tableAlreadyExist="N";
			List<Tables> existingTableList=(List<Tables>) session.getAttribute("existingTableList");
			for(Tables tab:existingTableList)
			{
				if(tableno.equals(tab.getTableNo()))
						{
						tableAlreadyExist="Y";
						}
			}
			if(tableAlreadyExist.equals("Y"))
			{
				out.print("alreadyexist");
				out.flush();
			}
			else
			{
				/*Tables tables =new Tables();
				tables.setTableNo(tableno);
				tables.setSeatingCapacity(seatingcapacity);
				tables.setTableDescription(desc);
				tables.setStoreId(customer.getStoreId());*/
				String res=tablemgntService.addTable(table);
				System.out.println("res:"+res);
				out.print(res);
				out.flush();
			}
		}
	}
	@RequestMapping(value="/edittable",method=RequestMethod.POST)
	public void editTable(@RequestBody String TableeditPost,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In edittable......{}",TableeditPost);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			TableMaster table=gson.fromJson(TableeditPost, new TypeToken<TableMaster>() {
			}.getType());
			/*TableMaster tables=new TableMaster();
			tables.setId(tableid);
			tables.setTableNo(tableno);
			tables.setSeatingCapacity(seatingcapacity);
			tables.setTableDescription(desc);*/
			table.setAvailableForOnlineBbooking((short) 1);
			table.setDeleteFlag("N");
			//tables.setStoreId(customer.getStoreId());
			table.setStatus("Y");
			table.setStyleId(""+1);
			//table.setMultiOrder(multiorder);
			String res=tablemgntService.editTable(table);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
			
			/*String tableNo;
			int tabno=Integer.parseInt(tableno);
			if(tabno<10){tableNo="0"+tabno;}
			else{tableNo=""+tabno;}
			String tableAlreadyExist="N";
			List<Tables> existingTableList=(List<Tables>) session.getAttribute("existingTableList");
			for(Tables tab:existingTableList)
			{
				if(tableNo.equals(tab.getTableNo()))
						{
						tableAlreadyExist="Y";
						}
			}
			if(tableAlreadyExist.equals("Y"))
			{
				out.print("alreadyexist");
				out.flush();
			}
			else
			{
				Tables tables =new Tables();
				tables.setTableId(tableid);
				tables.setTableNo(tableNo);
				tables.setSeatingCapacity(seatingcapacity);
				tables.setTableDescription(desc);
				tables.setStoreId(customer.getStoreId());
				String res=tablemgntService.editTable(tables);
				System.out.println("res:"+res);
				out.print(res);
				out.flush();
			}*/
			
		}
	}
	public synchronized List<Tables> getUpdatedTableList(String tabno,List<Tables> tabList)
	{
		for(Tables tab:tabList)
		{
			if(tabno.equals(tab.getTableNo()))
					{
				tabList.remove(tab);
					}
		}
		return tabList;
	}
	@RequestMapping(value="/deletetable/{tableid}",method=RequestMethod.GET)
	public void editTable(@PathVariable("tableid") int tableid,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In deletetable......{}",tableid);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res=tablemgntService.deleteTable(tableid, customer.getStoreId());
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/loadtablelayout",method=RequestMethod.GET)
	public ModelAndView loadTableLayout(HttpSession session)
	{
		logger.debug("in loadtablelayout...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<Table> tableList=tableService.getTableList(customer.getStoreId());
		mav.addObject("tableList", tableList);
		mav.addObject(Constants.ADMIN,"Y");
		Store s=(Store) session.getAttribute(Constants.LOGGED_IN_STORE);
		if(s.getEnterpriseTblLayout().equalsIgnoreCase("Y")){
			mav.setViewName(ForwardConstants.VIEW_TABLE_LAYOUT_PAGE_NEW);
		}else{
			mav.setViewName(ForwardConstants.VIEW_TABLE_LAYOUT_PAGE);
		}
		
		return mav;
	}
	
	
	@RequestMapping(value = "/updatetableposition", method = RequestMethod.POST)
	public void updateTablePosition(@RequestBody String tableMasterString, HttpSession session, HttpServletResponse response) throws IOException {
		logger.debug("in updateTablePosition...{}", tableMasterString);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			TableMaster tableMaster = gson.fromJson(tableMasterString, new TypeToken<TableMaster>() {
			}.getType());
			String res=tablemgntService.updateTablePosition(tableMaster);
			out.print(res);
			out.flush();
		}
	}
	
	public String getTodayDate()
	{
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    //java.util.Calendar cal=java.util.Calendar.getInstance();
	    System.out.println("date:"+df.format(date));
		return df.format(date);
	}
}
