/**
 * 
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;
import java.util.List;

/**
 * @author habib
 * 
 */
public class MenuCategoryLangMap implements Serializable {

	
	private static final long serialVersionUID = 1L;

    private int id;
    private MenuCategory menucategory;
    private int storeId;
    private String language;
    private String menuItemName;
    private String languageId;
    private String englishName;
    private List<MenuCategoryLangMap> categoryLangMaps;
    private int catSubCatId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public MenuCategory getMenucategory() {
		return menucategory;
	}
	public void setMenucategory(MenuCategory menucategory) {
		this.menucategory = menucategory;
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
	public String getMenuItemName() {
		return menuItemName;
	}
	public void setMenuItemName(String menuItemName) {
		this.menuItemName = menuItemName;
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
	public List<MenuCategoryLangMap> getCategoryLangMaps() {
		return categoryLangMaps;
	}
	public void setCategoryLangMaps(List<MenuCategoryLangMap> categoryLangMaps) {
		this.categoryLangMaps = categoryLangMaps;
	}
	public int getCatSubCatId() {
		return catSubCatId;
	}
	public void setCatSubCatId(int catSubCatId) {
		this.catSubCatId = catSubCatId;
	}
	
	@Override
	public String toString() {
		return "MenuCategoryLangMap [id=" + id + ", menucategory="
				+ menucategory + ", storeId=" + storeId + ", language="
				+ language + ", menuItemName=" + menuItemName + ", languageId="
				+ languageId + ", englishName=" + englishName
				+ ", categoryLangMaps=" + categoryLangMaps + ", catSubCatId="
				+ catSubCatId + "]";
	} 	
}
