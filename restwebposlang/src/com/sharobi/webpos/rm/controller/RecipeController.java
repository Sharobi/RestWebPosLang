package com.sharobi.webpos.rm.controller;

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
import com.sharobi.webpos.rm.model.CookingUnit;
import com.sharobi.webpos.rm.model.Ingredient;
import com.sharobi.webpos.rm.model.IngredientList;
import com.sharobi.webpos.rm.model.MetricUnit;
import com.sharobi.webpos.rm.service.RecipeService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/recipe")
public class RecipeController {
	private final static Logger logger = LogManager.getLogger(RecipeController.class);
	@Autowired RecipeService recipeService;
  Gson gson = new Gson();
	@RequestMapping(value = "/loadrecipeingredient",
					method = RequestMethod.GET)
	public ModelAndView loadRecipeIngredients(	Model model,
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
			System.out.println("allMenuList=" + gson.toJson(allMenuList));
			mav.addObject("allmenuforrm", allMenuList);
			session.setAttribute(Constants.SES_ALL_MENU_RECEIPE, allMenuList);
			List<CookingUnit> cookingUnit = recipeService.getAllCookingUnits(customer.getStoreId());
			mav.addObject("cookingUnit", cookingUnit);
			List<MetricUnit> metricUnit = recipeService.getAllMetricsUnits(customer.getStoreId());
			mav.addObject("metricUnit", metricUnit);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_RECIPE_INGREDIENTS_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/getIngredientDetailsOfMenuItem",
					method = RequestMethod.GET)
	public void getIngredientDetailsOfMenuItem(	@RequestParam String itemid,
												HttpSession session,
												HttpServletResponse response) {
		logger.debug("in getIngredientDetailsOfMenuItem...! {}", itemid);
		PrintWriter out;
		try {
			out = response.getWriter();

			response.setContentType("text/plain");
			Customer customer = null;
			if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
				out.print(recipeService.getAllIndredientOfMenuItem(customer.getStoreId(), Integer.valueOf(itemid)));
				out.flush();
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/createorupdatereceipe",
					method = RequestMethod.POST)
	public void createOrUpdateReceipe(	@RequestBody String receipelist,
										HttpSession session,
										HttpServletResponse response) throws IOException {
		logger.debug("in createorupdatereceipelist...{}", receipelist);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			IngredientList ingredientList = gson.fromJson(receipelist, new TypeToken<IngredientList>() {}.getType());
			recipeService.createNewReceipe(ingredientList);
			out.print("success");
			out.flush();
		}
	}

	@RequestMapping(value = "/deleteEachReceipeItem/{storeid}/{rceipeingid}",
					method = RequestMethod.GET)
	public ModelAndView deleteEachReceipeItem(	@PathVariable("storeid") String storeid,
												@PathVariable("rceipeingid") String rceipeingid,
												Model model,
												HttpSession session,
												HttpServletRequest request) throws ParseException {
		logger.debug("In deleteEachReceipeItem......{},{}", storeid, rceipeingid);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		recipeService.deleteEachReceipeItem(storeid, rceipeingid);
		return null;
	}

	@RequestMapping(value = "/updatereceipeitem",
					method = RequestMethod.POST)
	public void updatereceipeitem(	@RequestBody String receipeItem,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("in updatereceipeitem...{}", receipeItem);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			Ingredient ingredient = gson.fromJson(receipeItem, new TypeToken<Ingredient>() {}.getType());
			ingredient.setStoreId(customer.getStoreId());
			ingredient.setCreatedBy(customer.getName());
			ingredient.setDeleteFlag("N");
			recipeService.updateEachReceipeItem(ingredient);
			out.print("success");
			out.flush();
		}
	}
}
