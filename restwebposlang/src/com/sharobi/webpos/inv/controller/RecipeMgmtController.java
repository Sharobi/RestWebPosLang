package com.sharobi.webpos.inv.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
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
import com.sharobi.webpos.base.model.Menu;
import com.sharobi.webpos.rm.controller.RecipeController;
import com.sharobi.webpos.rm.model.CookingUnit;
import com.sharobi.webpos.rm.model.Ingredient;
import com.sharobi.webpos.rm.model.IngredientList;
import com.sharobi.webpos.rm.model.MetricUnit;
import com.sharobi.webpos.rm.service.RecipeService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/recipemgmt")
public class RecipeMgmtController {
  private final static Logger logger = LogManager.getLogger(RecipeMgmtController.class);
  @Autowired RecipeService recipeService;

  @RequestMapping(value = "/loadrecipe",
          method = RequestMethod.GET)
  public ModelAndView loadRecipeIngredients(  Model model,
                        HttpSession session) {
    ModelAndView mav = new ModelAndView();

    Customer customer = null;
    if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
      return mav;
    } else {
      String selLang=(String) session.getAttribute(Constants.SELECTED_LANG);  
      System.out.println("selLang="+selLang);
      Menu allMenuList = recipeService.getAllMenuListForRM(customer.getStoreId(),selLang);
      System.out.println("allMenuList=" + allMenuList.toString());
      mav.addObject("allmenuforrm", allMenuList);
      session.setAttribute(Constants.SES_ALL_MENU_RECEIPE, allMenuList);
      List<MetricUnit> cookingUnit = recipeService.getUnitsByType("cooking_us");
      mav.addObject("cookingUnit", cookingUnit);
      List<MetricUnit> metricUnit = recipeService.getUnitsByType("metric");
      mav.addObject("metricUnit", metricUnit);
      mav.addObject(Constants.ACTIVE_INVENTORY,"Y");
      mav.setViewName(ForwardConstants.VIEW_INVENTORY_RECIPE_PAGE);
      return mav;
    }
  }

}
