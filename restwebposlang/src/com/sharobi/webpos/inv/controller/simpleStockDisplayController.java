package com.sharobi.webpos.inv.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.inv.model.InventoryStockIn;
import com.sharobi.webpos.inv.model.ItemCurrentStock;
import com.sharobi.webpos.inv.service.InventoryService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/simplestock")
public class simpleStockDisplayController {
  private final static Logger logger = LogManager.getLogger(simpleStockDisplayController.class);
  @Autowired  InventoryService inventoryService;
  Gson gson = new Gson();
  
  @RequestMapping(value = "/display",method = RequestMethod.GET)
  public ModelAndView loadSimpleStockDisplay(  Model model,
                  HttpSession session) {

  ModelAndView mav = new ModelAndView();
  Customer customer = null;
  if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
    mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
    return mav;
  } else {
    List<ItemCurrentStock> itemList= inventoryService.getCurrentStockByIngredients(customer.getStoreId(), 0);
    mav.addObject("itemLists", itemList);
    mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
    mav.setViewName(ForwardConstants.VIEW_SIMPLESTOCKDISPLAY_PAGE);
    return mav;
  }
  }
  

}
