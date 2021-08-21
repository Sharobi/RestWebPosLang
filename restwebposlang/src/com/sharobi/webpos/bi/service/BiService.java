package com.sharobi.webpos.bi.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.sharobi.webpos.bi.model.BiModel;
@Service
public class BiService {

	private final static Gson gson = new Gson();
	
	public List<BiModel> getData1(){

		 
		 List<BiModel> listBiObj1 = new ArrayList<BiModel>();
		 
		 BiModel biObj11 = new BiModel();
		 
		 biObj11.setItemName("Half-Pant");
	     biObj11.setItemPrice(520.88);
	     
	     listBiObj1.add(biObj11);
	     
	     BiModel biObj12 = new BiModel();
		 
		 biObj12.setItemName("Full-fPant");
	     biObj12.setItemPrice(820.88);
	     
	     listBiObj1.add(biObj12);
	     
	     BiModel biObj13 = new BiModel();
		 
		 biObj13.setItemName("3Qtr-Pant");
	     biObj13.setItemPrice(120.88);
	     
	     listBiObj1.add(biObj13);
	     
	   return listBiObj1;
	}
	
	public List<BiModel> getData2() {
	     
	  
	   List<BiModel> listBiObj2 = new ArrayList<BiModel>();
	   
	   BiModel biObj21 = new BiModel(); 
	   biObj21.setItemName("T-Shirt");
	   biObj21.setItemPrice(890.78);
	   
	    listBiObj2.add(biObj21);
		
		BiModel biObj22 = new BiModel(); 
		biObj22.setItemName("Casual-Shirt");
		biObj22.setItemPrice(890.78);
		   
		listBiObj2.add(biObj22);
			
		BiModel biObj23 = new BiModel(); 
		biObj23.setItemName("Formal-Shirt");
		biObj23.setItemPrice(890.78);
			   
		listBiObj2.add(biObj23);
		
		return listBiObj2;
		
	}
	
}
