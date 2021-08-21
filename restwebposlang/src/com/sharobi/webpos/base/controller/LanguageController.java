package com.sharobi.webpos.base.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sharobi.webpos.base.service.LanguageService;
import com.sharobi.webpos.util.ForwardConstants;


@Controller
@RequestMapping("/language")
public class LanguageController {

	@Autowired  LanguageService langList; 	
	
	@RequestMapping(value="/getlanguage/{storeid}/", method=RequestMethod.GET)
	public ModelAndView getLanguage(@PathVariable("storeid") int storeId, HttpSession session, HttpServletResponse response) throws IOException {
	  
	  ModelAndView mav = new ModelAndView();
	  //List<Language> languagess = langList.getLanguageListByStoreId(storeId);
	  mav.setViewName(ForwardConstants.REDIRECT_HOME);
	
	  return mav;
   }
	
}
