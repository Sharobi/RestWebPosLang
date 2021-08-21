/**
 * 
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;
import java.util.List;

import com.sharobi.webpos.base.model.MenuItem;

/**
 * @author habib
 * 
 */
public class MenuItemLangMap implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	private int id;

	private MenuItem menuItem;

	private int storeId;

	private String language;

	private String name;

	private String description;

	private String promotionDesc;

	private String foodOption1;

	private String foodOption2;

	private String languageId;

	private String englishName;
	
	private String englishDesc;
	
	private List<MenuItemLangMap> itemLangMaps;
	
	private int itemId;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public MenuItem getMenuItem() {
		return menuItem;
	}

	public void setMenuItem(MenuItem menuItem) {
		this.menuItem = menuItem;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPromotionDesc() {
		return promotionDesc;
	}

	public void setPromotionDesc(String promotionDesc) {
		this.promotionDesc = promotionDesc;
	}

	public String getFoodOption1() {
		return foodOption1;
	}

	public void setFoodOption1(String foodOption1) {
		this.foodOption1 = foodOption1;
	}

	public String getFoodOption2() {
		return foodOption2;
	}

	public void setFoodOption2(String foodOption2) {
		this.foodOption2 = foodOption2;
	}

	public String getLanguageId() {
		return languageId;
	}

	public void setLanguageId(String languageId) {
		this.languageId = languageId;
	}

	public String getEnglishName() {
		return englishName;
	}

	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}
	

	public String getEnglishDesc() {
		return englishDesc;
	}

	public void setEnglishDesc(String englishDesc) {
		this.englishDesc = englishDesc;
	}
	

	public List<MenuItemLangMap> getItemLangMaps() {
		return itemLangMaps;
	}

	public void setItemLangMaps(List<MenuItemLangMap> itemLangMaps) {
		this.itemLangMaps = itemLangMaps;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	@Override
	public String toString() {
		return "MenuItemLangMap [id=" + id + ", menuItem=" + menuItem
				+ ", storeId=" + storeId + ", language=" + language + ", name="
				+ name + ", description=" + description + ", promotionDesc="
				+ promotionDesc + ", foodOption1=" + foodOption1
				+ ", foodOption2=" + foodOption2 + ", languageId=" + languageId
				+ ", englishName=" + englishName + ", englishDesc="
				+ englishDesc + ", itemLangMaps=" + itemLangMaps + ", itemId="
				+ itemId + "]";
	}
	
}
