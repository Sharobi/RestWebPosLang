package com.sharobi.webpos.util;

public class SmsParameter {
		private String mobile_no; 
		private String bill_no;
		private String bill_amount;
		private String merchant_id;
		private String email; 
		private String sub_id;
		private String date; 
		private String type;
		private String time; 
		private String name;
		private String merchantid;
		public String getMobile_no() {
			return mobile_no;
		}
		public void setMobile_no(String mobile_no) {
			this.mobile_no = mobile_no;
		}
		public String getBill_no() {
			return bill_no;
		}
		public void setBill_no(String bill_no) {
			this.bill_no = bill_no;
		}
		public String getBill_amount() {
			return bill_amount;
		}
		public void setBill_amount(String bill_amount) {
			this.bill_amount = bill_amount;
		}
		public String getMerchant_id() {
			return merchant_id;
		}
		public void setMerchant_id(String merchant_id) {
			this.merchant_id = merchant_id;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getSub_id() {
			return sub_id;
		}
		public void setSub_id(String sub_id) {
			this.sub_id = sub_id;
		}
		public String getDate() {
			return date;
		}
		public void setDate(String date) {
			this.date = date;
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		public String getTime() {
			return time;
		}
		public void setTime(String time) {
			this.time = time;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getMerchantid() {
			return merchantid;
		}
		public void setMerchantid(String merchantid) {
			this.merchantid = merchantid;
		}
		@Override
		public String toString() {
			return "SmsParameter [mobile_no=" + mobile_no + ", bill_no=" + bill_no + ", bill_amount=" + bill_amount
					+ ", merchant_id=" + merchant_id + ", email=" + email + ", sub_id=" + sub_id + ", date=" + date
					+ ", type=" + type + ", time=" + time + ", name=" + name + ", merchantid=" + merchantid + "]";
		}
				
}
