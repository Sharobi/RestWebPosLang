package com.sharobi.webpos.bi.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.bi.model.BiModel;
import com.sharobi.webpos.bi.service.BiService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/bi")
public class BiController {

	@Autowired BiService biService;  
	
	
	@RequestMapping(value="/getBidataPage", method=RequestMethod.GET)
	public ModelAndView getSalesDataPage(Model model,HttpSession session,HttpServletResponse response) throws IOException{
		
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		
		mav.setViewName(ForwardConstants.VIEW_BI_PAGE);
		
	    return mav;
	}
	
	
	@RequestMapping(value="/getBidata", method=RequestMethod.GET)
	public void getSalesData(HttpSession session,HttpServletResponse response) throws IOException{
		
		List<BiModel> biModelList1 = biService.getData1();
		/*List<BiModel> biModelList2 = biService.getData2();*/
		
		Gson gson = new Gson();
		String jsonString = gson.toJson(biModelList1);
		response.setContentType("application/json");
		response.getWriter().write(jsonString);
		
	}
	
}
