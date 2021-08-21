/**
 * 
 */
package com.sharobi.webpos.base.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sharobi.webpos.adm.model.CommonResultSetMapper;
import com.sharobi.webpos.adm.model.DashPaymentSummary;
import com.sharobi.webpos.adm.model.DashSalesSummary;
import com.sharobi.webpos.adm.model.DashSalesSummaryOrderType;
import com.sharobi.webpos.adm.model.DashSalesSummaryPaymentType;
import com.sharobi.webpos.adm.model.DashTopCustomer;
import com.sharobi.webpos.adm.model.DashTopItem;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Language;
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.model.StoreDayBookRegister;
import com.sharobi.webpos.base.service.LanguageService;
import com.sharobi.webpos.base.service.MenuService;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.login.model.KeyBean;
import com.sharobi.webpos.login.model.PosModules;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.StoreSMSConfiguration;

/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/home")
public class HomeController {
	private final static Logger logger=LogManager.getLogger(HomeController.class);
	@Autowired  StoreService storeService;
	@Autowired  LanguageService langService;
	@Autowired  MenuService menuService;
	private final static Gson gson=new Gson();
	@RequestMapping(value="/welcome",method=RequestMethod.GET)
	public ModelAndView welcome(Model model,HttpSession session) 
	{
		logger.debug("In welcome......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		Locale locale = LocaleContextHolder.getLocale();
		logger.debug("In Login lang ar..."+locale);
		session.setAttribute(Constants.SELECTED_LANG,locale.getDisplayLanguage());
/*		Locale locale = LocaleContextHolder.getLocale();
		logger.debug("In Login lang..."+locale);
		logger.debug("In Login lang getDisplayLanguage..."+locale.getDisplayLanguage());
		session.setAttribute(Constants.SELECTED_LANG, locale.getDisplayLanguage());*/
		
		/*if(locale.equals("ar")){
			session.setAttribute(Constants.SELECTED_LANG, Constants.LANG_AR);
			logger.debug("In Login lang ar..."+locale);
		}else if(locale.equals("en")){
			session.setAttribute(Constants.SELECTED_LANG, Constants.LANG_EN);
			logger.debug("In Login lang en..."+locale);
		}*/
		Store store=storeService.getStoreById(customer.getStoreId());
		System.out.println(""+store.getIsBarcode());
		System.out.println(""+store.getWaiterNameFlag());
		System.out.println("sms"+store.getSmsIntegration());
		session.setAttribute(Constants.LOGGED_IN_STORE, store);
		List<PosModules> posModuless=storeService.getPosModulesByUserId(String.valueOf(customer.getId()), customer.getStoreId());
		List<Language> langObj = langService.getLanguageListByStoreId(customer.getStoreId());
		
		String smsflag=store.getSmsIntegration();
		if(smsflag.equals("Y")){
		System.out.println("IN SMS Data Fetch");
		StoreSMSConfiguration smsdata = storeService.getSmsData(customer.getStoreId());
		session.setAttribute("smsData", smsdata);
		}
		
		String res=storeService.checkOpentimestatus(customer.getStoreId());
		session.setAttribute("posModuless", posModuless);
		session.setAttribute(Constants.LANG_LIST, langObj);
		mav.addObject("posModuless",posModuless);
		mav.addObject("store",store);
		mav.addObject("langlist1", langObj);
		mav.addObject(Constants.HOME,"Y");
		StoreDayBookRegister storeDayBookRegistersession=gson.fromJson(res, StoreDayBookRegister.class);
		System.out.println("res:"+res);
		session.setAttribute(Constants.REST_OPEN_DET,storeDayBookRegistersession);
		Menu menu=(Menu)session.getAttribute(Constants.MENU_ALL_TREE);
		if(menu==null){
		Menu allMenuList = menuService.getAllMenuList(customer.getStoreId(),locale.getDisplayLanguage());
		System.out.println("Menu:::"+gson.toJson(allMenuList));
		session.setAttribute(Constants.MENU_ALL_TREE, allMenuList);
		}
		
		
		// License  expiration date calculation for alert in home page   
		Date date = new Date();
		String currentdate= new SimpleDateFormat("yyyy-MM-dd").format(date);
		String storeLicenseInfo=storeService.getLicenseInfoByStoreId(Integer.valueOf(customer.getStoreId()));
		KeyBean keybean=gson.fromJson(storeLicenseInfo, KeyBean.class);
		String expireDate=keybean.getTo_date();
		
		Date todayDate;
		Date liscExpireDate;
		try {
			todayDate = new SimpleDateFormat("yyyy-MM-dd").parse(currentdate);  
			liscExpireDate = new SimpleDateFormat("yyyy-MM-dd").parse(expireDate);
			long timeDiff = liscExpireDate.getTime() - todayDate.getTime();
			long daysDiff = timeDiff/(1000*60*60*24);
			//System.out.println("________Time difference is__________::"+daysDiff+"::__Today__::"+todayDate+"::__expday__::"+liscExpireDate);
			if(daysDiff<=15){
				mav.addObject("expdate",expireDate);
			}
			else{
				mav.addObject("expdate","null");
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}  
		
		
		
		mav.setViewName(ForwardConstants.VIEW_HOME_PAGE);
		return mav;
	}
	
	
	@RequestMapping(value="/getlicenseinfo/{storeid}",method=RequestMethod.GET)
	public void getlicenseinfo(@PathVariable("storeid") String storeid,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In getlicenseinfo......{}",storeid);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			String res=storeService.getLicenseInfoByStoreId(Integer.valueOf(storeid));
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/saverestopentime",method=RequestMethod.GET)
	public void saveRestOpenTime(HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In saverestopentime......{}");
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res="";
			StoreDayBookRegister storeDayBookRegister=null;
			if((storeDayBookRegister=(StoreDayBookRegister) session.getAttribute(Constants.REST_OPEN_DET))==null)
			{
				res=storeService.saveRestOpentime(customer.getStoreId(), customer.getId(),0);
			}else{
				res=storeService.saveRestOpentime(customer.getStoreId(), customer.getId(),storeDayBookRegister.getId());
			}
			 
			StoreDayBookRegister storeDayBookRegistersession=gson.fromJson(res, StoreDayBookRegister.class);
			System.out.println("res:"+res);
			session.setAttribute(Constants.REST_OPEN_DET,storeDayBookRegistersession);
			out.print(storeDayBookRegistersession.getUserText());
			out.flush();
		}
	}
	
	@RequestMapping(value="/saverestclosetime",method=RequestMethod.GET)
	public void saveRestCloseTime(HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In saverestclosetime......{}");
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			String res="Restaurant not open yet, please start the restaurant first.";
			StoreDayBookRegister storeDayBookRegister=null;
			if((storeDayBookRegister=(StoreDayBookRegister) session.getAttribute(Constants.REST_OPEN_DET))==null)
			{
				
			}else{
				res=storeService.saveRestClosetime(customer.getStoreId(), customer.getId(),storeDayBookRegister.getId());
			}
			
			System.out.println("res:"+res);
			//session.removeAttribute(Constants.REST_OPEN_DET);
			out.print(res);
			out.flush();
		}
	}
	
	
	
	
	//For Dash board access
	
	
	@RequestMapping(value = "/getBoxData", method = RequestMethod.POST)
  public void getAllBoxData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
      throws IOException {
    logger.info("In getboxdata......{}" );
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      DashSalesSummary res =storeService.getBoxData(commonResultSetMapper);
      System.out.println("res:" + res);
      out.print(gson.toJson(res));
      out.flush();
    }
  }
	
	@RequestMapping(value = "/getPaymentSummary", method = RequestMethod.POST)
  public void getPaymentSummaryData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
      throws IOException {
    logger.info("In getPaymentSummary......{}" );
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      DashPaymentSummary res =storeService.getPaymentSummary(commonResultSetMapper);
      System.out.println("res:" + res);
      out.print(gson.toJson(res));
      out.flush();
    }
  }
  
	
	
	
	@RequestMapping(value = "/getDashSaleSummaryOrderType", method = RequestMethod.POST)
  public void getDashSaleSummaryOrderTypeData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
      throws IOException {
    logger.info("In getDashSaleSummaryOrderType......{}" );
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      List<DashSalesSummaryOrderType> res =storeService.getDashSaleSummaryOrderType(commonResultSetMapper);
      System.out.println("res:" + res);
      out.print(gson.toJson(res));
      out.flush();
    }
  }
  
	
	@RequestMapping(value = "/getDashSaleSummaryPaymentType", method = RequestMethod.POST)
  public void getDashSaleSummaryPaymentTypeData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
      throws IOException {
    logger.info("In getDashSaleSummaryPaymentType......{}" );
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      List<DashSalesSummaryPaymentType> res =storeService.getDashSaleSummaryPaymentType(commonResultSetMapper);
      System.out.println("res:" + res);
      out.print(gson.toJson(res));
      out.flush();
    }
  }
	
	
	@RequestMapping(value = "/getDashTopCustomer", method = RequestMethod.POST)
  public void getDashTopCustomerData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
      throws IOException {
    logger.info("In getDashTopCustomer......{}" );
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      List<DashTopCustomer> res =storeService.getDashTopCustomer(commonResultSetMapper);
      System.out.println("res:" + res);
      out.print(gson.toJson(res));
      out.flush();
    }
  }
	@RequestMapping(value = "/getDashTopItem", method = RequestMethod.POST)
  public void getDashTopItemData(@RequestBody CommonResultSetMapper commonResultSetMapper,HttpSession session, HttpServletResponse response)
      throws IOException {
    logger.info("In getDashTopItem......{}" );
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null){
      PrintWriter out = response.getWriter();
      response.setContentType("text/plain");
      List<DashTopItem> res =storeService.getDashTopItem(commonResultSetMapper);
      System.out.println("res:" + res);
      out.print(gson.toJson(res));
      out.flush();
    }
  }
	
	
}
