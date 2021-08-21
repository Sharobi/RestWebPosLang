/**
 *
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
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
import com.sharobi.webpos.adm.model.StoreCustomer;
import com.sharobi.webpos.adm.service.CreditSaleService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.model.Payment;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.OrderService;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;


/**
 * @author habib
 *
 */
@Controller
@RequestMapping("/creditsale")
public class CreditSaleController {

	private final static Logger logger=LogManager.getLogger(CreditSaleController.class);
	@Autowired CreditSaleService creditsaleService;
	@Autowired OrderService orderService;
	@Autowired StoreService storeService;

	@RequestMapping(value="/loadcreditcustomer",method=RequestMethod.GET)
	public ModelAndView loadCreditCustomer(HttpSession session)
	{
		logger.debug("in loadcreditcustomer...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		List<StoreCustomer> creditCustList=creditsaleService.getCreditCustomerList(customer.getStoreId());
		StoreCustomer storeCust=new StoreCustomer();
		List<Order> creditOrderList=new ArrayList<Order>();
		if(creditCustList.size()>0)
		{
			storeCust=creditCustList.get(0);
			creditOrderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), storeCust.getId());
			for(Order orders:creditOrderList)
			{
				setPaidAmt(orders);
			}
			mav.addObject("storeCustDetail",storeCust);
			mav.addObject("creditOrderList",creditOrderList);
		}
		mav.addObject("creditcustList",creditCustList);
		mav.addObject(Constants.ADMIN,"Y");
		Store store=storeService.getStoreById(customer.getStoreId());
		mav.addObject("is_acc", store.getIs_account());
		mav.setViewName(ForwardConstants.VIEW_CREDIT_SALE_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/loadcreditbooking",method=RequestMethod.GET)
  public ModelAndView loadCreditBooking(HttpSession session)
  {
	  logger.debug("in loadcreditbooking...! ");
    ModelAndView mav=new ModelAndView();
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
    {
      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
      return mav;
    }
    List<StoreCustomer> creditCustList=creditsaleService.getCreditCustomerList(customer.getStoreId());
    StoreCustomer storeCust=new StoreCustomer();
    List<Order> creditOrderList=new ArrayList<Order>();
    /*if(creditCustList.size()>0)
    {
      storeCust=creditCustList.get(0);
      creditOrderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), storeCust.getId());
      for(Order orders:creditOrderList)
      {
        setPaidAmt(orders);
      }
      mav.addObject("storeCustDetail",storeCust);
      mav.addObject("creditOrderList",creditOrderList);
    }*/
    mav.addObject("creditcustList",creditCustList);
    mav.addObject(Constants.ADMIN,"Y");
    /*Store store=storeService.getStoreById(customer.getStoreId());
    mav.addObject("is_acc", store.getIs_account());*/
    mav.setViewName(ForwardConstants.VIEW_CREDIT_BOOKING_PAGE);
    return mav;
  }
	@RequestMapping(value="/getcreditorderbycustid/{custId}",method=RequestMethod.GET)
	public void getcreditOrderByustId(@PathVariable("custId") int custId,HttpSession session,HttpServletResponse response)throws IOException
	{
		logger.debug("in getcreditorderbycustid...{}",custId);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<Order> creditorderList=new ArrayList<Order>();
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), custId);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			out.print(new Gson().toJson(creditorderList, new TypeToken<List<Order>>() {}.getType()));
			out.flush();
		}
	}

	@RequestMapping(value="/getcreditorderbycustidAdmin",method=RequestMethod.POST)
	public void getcreditOrderByustIdAdmin(@RequestBody int getcreditCustomerById ,HttpSession session,HttpServletResponse response)throws IOException
	{
		logger.debug("in getcreditorderbycustid...{}",getcreditCustomerById);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<Order> creditorderList=new ArrayList<Order>();
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), getcreditCustomerById);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			out.print(new Gson().toJson(creditorderList, new TypeToken<List<Order>>() {}.getType()));
			out.flush();
		}
	}


	/*@RequestMapping(value="/paybulkcashbycustid/{custId}/{remarks}/{tenderAmt}",method=RequestMethod.GET)
	public void payBulkCashByustId(@PathVariable("custId") int custId,@PathVariable("remarks") String remarks,@PathVariable("tenderAmt") double tenderAmt,HttpSession session,HttpServletResponse response)throws IOException
	{
		logger.debug("in paybulkcashbycustid...{},{},{}",custId,tenderAmt,remarks);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<Order> creditorderList=new ArrayList<Order>();
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), custId);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			double finaltenderAmt=0.0;
			finaltenderAmt=tenderAmt;
			for(Order orders:creditorderList)
			{
				if(finaltenderAmt>0)
				{
				int orderno=orders.getId();
				double billAmt=orders.getOrderBill().getGrossAmt();
				double paidAmt=orders.getPaidAmt();
				double amttoPay=billAmt-paidAmt;
				if(finaltenderAmt>=amttoPay)
					{
					paidAmt=amttoPay;
					amttoPay=0.0;
					}
				else
					{
					paidAmt=finaltenderAmt;
					amttoPay=amttoPay-finaltenderAmt;
					}
				Order order=new Order();
				order.setId(orderno);
				Payment payment=new Payment();
				payment.setOrderPayment(order);
				payment.setAmount(billAmt);
				payment.setPaidAmount(paidAmt);
				payment.setAmountToPay(amttoPay);
				payment.setTenderAmount(tenderAmt);
				payment.setPaymentMode("cash");
				payment.setCardLastFourDigits("0000");
				payment.setStoreId(customer.getStoreId());
				payment.setSource("web");
				payment.setCreatedBy(customer.getContactNo());
				payment.setCreationDate(getOrderTime());
				payment.setRemarks(remarks);
				String res=orderService.orderPayment(payment);
				System.out.println("paid amt:"+paidAmt);
				if("success".equals(res))
				{
					finaltenderAmt=finaltenderAmt-paidAmt;
				}
				}
				else
				{
					break;
				}

			}
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), custId);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			out.print(new Gson().toJson(creditorderList, new TypeToken<List<Order>>() {}.getType()));
			out.flush();
		}
	}*/

@RequestMapping(value = "/paybulkcashbycustid",
			method = RequestMethod.POST)
public void payBulkCashByustId(	@RequestBody String bulkorderPaymentAdminStringbycash,
								HttpSession session,
								HttpServletResponse response) throws IOException {
logger.debug("in bulkorderpaymentbycash...{},{}, {}, {},{},{},{},{}", bulkorderPaymentAdminStringbycash);
Gson gson = new GsonBuilder().create();
Payment paymentObj = gson.fromJson(bulkorderPaymentAdminStringbycash, new TypeToken<Payment>() {}.getType());

Customer customer;
if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
{
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
	List<Order> creditorderList=new ArrayList<Order>();
	creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), Integer.parseInt(paymentObj.getOrderPayment().getCustomerId()));
	for(Order orders:creditorderList)
	{
		setPaidAmt(orders);
	}
	double finaltenderAmt=0.0;
	finaltenderAmt=paymentObj.getTenderAmount();
	for(Order orders:creditorderList)
	{
		if(finaltenderAmt>0)
		{
		int orderno=orders.getId();
		double billAmt=orders.getOrderBill().getGrossAmt();
		double paidAmt=orders.getPaidAmt();
		double amttoPay=billAmt-paidAmt;
		if(finaltenderAmt>=amttoPay)
			{
			paidAmt=amttoPay;
			amttoPay=0.0;
			}
		else
			{
			paidAmt=finaltenderAmt;
			amttoPay=amttoPay-finaltenderAmt;
			}
		Order order=new Order();
		order.setId(orderno);
		Payment payment=new Payment();
		payment.setOrderPayment(order);
		payment.setAmount(billAmt);
		payment.setPaidAmount(paidAmt);
		payment.setAmountToPay(amttoPay);
		payment.setTenderAmount(paymentObj.getTenderAmount());
		payment.setPaymentMode("cash");
		payment.setCardLastFourDigits("0000");
		payment.setStoreId(customer.getStoreId());
		payment.setSource("web");
		payment.setCreatedBy(customer.getContactNo());
		payment.setCreationDate(getOrderTime());
		payment.setRemarks(paymentObj.getRemarks());
		
		payment.setQs(Constants.CUSTOMER_PAYMENT_QS);
		payment.setCr_legder_id(paymentObj.getCr_legder_id());
		payment.setDr_legder_id(paymentObj.getDr_legder_id());
		Store store=storeService.getStoreById(customer.getStoreId());
		payment.setIs_account(store.getIs_account());
		payment.setCr_amount(paidAmt);
		payment.setDr_amount(paidAmt);
		System.out.println("_____creditsale______bulk___Payment_____"+payment.toString());
		
		
		String res=orderService.orderPayment(payment);
		//System.out.println("paid amt:"+paidAmt);
		if("success".equals(res))
		{
			finaltenderAmt=finaltenderAmt-paidAmt;
		}
		}
		else
		{
			break;
		}

	}
	creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), Integer.parseInt(paymentObj.getOrderPayment().getCustomerId()));
	for(Order orders:creditorderList)
	{
		setPaidAmt(orders);
	}
	out.print(new Gson().toJson(creditorderList, new TypeToken<List<Order>>() {}.getType()));
	out.flush();
    }

}




	/*@RequestMapping(value="/paybulkcardbycustid/{custId}/{tenderAmt}/{lastfourdigit}/{remarks}",method=RequestMethod.GET)
	public void payBulkCardByustId(@PathVariable("custId") int custId,@PathVariable("tenderAmt") double tenderAmt,@PathVariable("lastfourdigit") String lastfourdigit,@PathVariable("remarks") String remarks,HttpSession session,HttpServletResponse response)throws IOException
	{
		logger.debug("in paybulkcardbycustid...{},{},{},{}",custId,tenderAmt,lastfourdigit,remarks);
		Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<Order> creditorderList=new ArrayList<Order>();
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), custId);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			double finaltenderAmt=0.0;
			finaltenderAmt=tenderAmt;
			for(Order orders:creditorderList)
			{
				if(finaltenderAmt>0)
				{
				int orderno=orders.getId();
				double billAmt=orders.getOrderBill().getGrossAmt();
				double paidAmt=orders.getPaidAmt();
				double amttoPay=billAmt-paidAmt;
				if(finaltenderAmt>=amttoPay)
					{
					paidAmt=amttoPay;
					amttoPay=0.0;
					}
				else
					{
					paidAmt=finaltenderAmt;
					amttoPay=amttoPay-finaltenderAmt;
					}
				Order order=new Order();
				order.setId(orderno);
				Payment payment=new Payment();
				payment.setOrderPayment(order);
				payment.setAmount(billAmt);
				payment.setPaidAmount(paidAmt);
				payment.setAmountToPay(amttoPay);
				payment.setTenderAmount(tenderAmt);
				payment.setPaymentMode("card");
				payment.setCardLastFourDigits(""+lastfourdigit);
				payment.setStoreId(customer.getStoreId());
				payment.setSource("web");
				payment.setCreatedBy(customer.getContactNo());
				payment.setCreationDate(getOrderTime());
				payment.setRemarks(remarks);
				String res=orderService.orderPayment(payment);
				System.out.println("paid amt:"+paidAmt);
				if("success".equals(res))
				{
					finaltenderAmt=finaltenderAmt-paidAmt;
				}
				}
				else
				{
					break;
				}

			}
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), custId);
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			out.print(new Gson().toJson(creditorderList, new TypeToken<List<Order>>() {}.getType()));
			out.flush();
		}
	}*/


@RequestMapping(value = "/paybulkcardbycustid",
method = RequestMethod.POST)
public void payBulkCardByustId(	@RequestBody String bulkorderPaymentAdminStringbycard,
					HttpSession session,
					HttpServletResponse response) throws IOException {
logger.debug("in bulkorderpaymentbycard...{},{}, {}, {},{},{},{},{}", bulkorderPaymentAdminStringbycard);
      Gson gson = new GsonBuilder().create();
      Payment paymentObj = gson.fromJson(bulkorderPaymentAdminStringbycard, new TypeToken<Payment>() {}.getType());
      Customer customer;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			List<Order> creditorderList=new ArrayList<Order>();
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), Integer.parseInt(paymentObj.getOrderPayment().getCustomerId()));
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			double finaltenderAmt=0.0;
			finaltenderAmt=paymentObj.getTenderAmount();
			for(Order orders:creditorderList)
			{
				if(finaltenderAmt>0)
				{
				int orderno=orders.getId();
				double billAmt=orders.getOrderBill().getGrossAmt();
				double paidAmt=orders.getPaidAmt();
				double amttoPay=billAmt-paidAmt;
				if(finaltenderAmt>=amttoPay)
					{
					paidAmt=amttoPay;
					amttoPay=0.0;
					}
				else
					{
					paidAmt=finaltenderAmt;
					amttoPay=amttoPay-finaltenderAmt;
					}
				Order order=new Order();
				order.setId(orderno);
				Payment payment=new Payment();
				payment.setOrderPayment(order);
				payment.setAmount(billAmt);
				payment.setPaidAmount(paidAmt);
				payment.setAmountToPay(amttoPay);
				payment.setTenderAmount(paymentObj.getTenderAmount());
				payment.setPaymentMode("card");
				payment.setCardLastFourDigits(""+paymentObj.getCardLastFourDigits());
				payment.setStoreId(customer.getStoreId());
				payment.setSource("web");
				payment.setCreatedBy(customer.getContactNo());
				payment.setCreationDate(getOrderTime());
				payment.setRemarks(paymentObj.getRemarks());
				
				payment.setQs(Constants.CUSTOMER_PAYMENT_QS);
				payment.setCr_legder_id(paymentObj.getCr_legder_id());
				payment.setDr_legder_id(paymentObj.getDr_legder_id());
				Store store=storeService.getStoreById(customer.getStoreId());
				payment.setIs_account(store.getIs_account());
				payment.setCr_amount(paidAmt);
				payment.setDr_amount(paidAmt);
				System.out.println("_____creditsale__card____bulk___Payment_____"+payment.toString());
				
				String res=orderService.orderPayment(payment);
				//System.out.println("paid amt:"+paidAmt);
				if("success".equals(res))
				{
					finaltenderAmt=finaltenderAmt-paidAmt;
				}
				}
				else
				{
					break;
				}

			}
			creditorderList=creditsaleService.getCreditOrdersBycustId(customer.getStoreId(), Integer.parseInt(paymentObj.getOrderPayment().getCustomerId()));
			for(Order orders:creditorderList)
			{
				setPaidAmt(orders);
			}
			out.print(new Gson().toJson(creditorderList, new TypeToken<List<Order>>() {}.getType()));
			out.flush();
		}

    }

	public Order setPaidAmt(Order order)
	{
		double paidAmount=0.00;
		List<Payment> paymentLst = orderService.getPaymentListById(order.getId());
		Iterator<Payment> iterator = paymentLst.iterator();
		while (iterator.hasNext()) {
			Payment payment = (Payment) iterator.next();
			paidAmount = paidAmount + payment.getPaidAmount();
		}
		order.setPaidAmt(paidAmount);
		return order;
	}

	public String getOrderTime()
	{
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	    Date date = new Date();
	    //java.util.Calendar cal=java.util.Calendar.getInstance();
	    //System.out.println("date:"+df.format(date));
		return df.format(date);
	}
}
