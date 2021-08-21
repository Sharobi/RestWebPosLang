/**************************************************************************
 *                                                                        *
 *  JAVASCRIPT MENU HIGHLIGHTER v.1.5 (080929)                            *
 * --------------------------------------------                           *
 * �2005 Media Division (www.MediaDivision.com)                           *
 *                                                                        *
 * Written by Marius Smarandoiu & Armand Niculescu                        *
 *                                                                        *
 * You are free to use, modify and distribute this file, but please keep  *
 * this header and credits                                                *
 *                                                                        *
 * Usage:                                                                 *
 * - the script will apply the .current class to the <a> and its parent   *
 *   <li> that is contained in the element with id="primarynav" and points*
 *   to the current URL                                                   *
 * - works in IE6, Firefox and Opera                                      *
 **************************************************************************/
function extractPageName(hrefString)
{
	var newhref=null;
	var cuttedhref=hrefString.substring(0, hrefString.indexOf('?'));
	if(cuttedhref==null || cuttedhref=='')
		{
		newhref=hrefString;
		}
	else
		{
		newhref=cuttedhref;
		}
	var arr = newhref.split('/');
	//alert(arr[arr.length-2].toLowerCase() + arr[arr.length-1].toLowerCase());
	return  (arr.length<2) ? newhref : arr[arr.length-2].toLowerCase() + arr[arr.length-1].toLowerCase();               
}

function setActiveMenu(arr, crtPage)
{
	for (var i=0; i<arr.length; i++)
	{
		//alert('in loop:'+arr.length+':'+crtPage);
		if(extractPageName(arr[i].href) == crtPage)
		{
			if (arr[i].parentNode.tagName != "DIV")
			{
				arr[i].className = "menu-top-active";
				arr[i].parentNode.className = "menu-top-active";
			}
		}
		/*new edition for menu item and report*/
		if(crtPage=='ordervieworders.htm')
		{
		//alert('hi');
		arr[2].className = "menu-top-active";
		arr[2].parentNode.className = "menu-top-active";
		}
		if(crtPage=='ordervieworderhd.htm')
		{
		//alert('hi');
		arr[2].className = "menu-top-active";
		arr[2].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewdaywiseorders.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewperiodwisesales.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewitemwisedailyorders.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewdaywisepo.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewperiodwisepo.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewdaywisestockin.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewperiodwisestockin.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewdaywisestockoutallcat.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewperiodwisestockoutallcat.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewdaywisestockoutkitchen.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewperiodwisestockoutkitchen.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewdaywisehourlysales.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewdaytimewisesales.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewdaytimewisesales.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewdaywisesalescategory.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewdaywisesummarysales.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewperiodwisesummarysales.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='reportviewcurrentstock.htm')
		{
		//alert('hi');
		arr[4].className = "menu-top-active";
		arr[4].parentNode.className = "menu-top-active";
		}
		if(crtPage=='orderviewallpaidorderbydate.htm')
		{
		//alert('hi');
		arr[5].className = "menu-top-active";
		arr[5].parentNode.className = "menu-top-active";
		}
		if(crtPage=='inventoryviewinventory.htm')
		{
		//alert('hi');
		arr[6].className = "menu-top-active";
		arr[6].parentNode.className = "menu-top-active";
		}
		if(crtPage=='stockinviewstockin.htm')
		{
		//alert('hi');
		arr[6].className = "menu-top-active";
		arr[6].parentNode.className = "menu-top-active";
		}
		if(crtPage=='stockoutviewstockout.htm')
		{
		//alert('hi');
		arr[6].className = "menu-top-active";
		arr[6].parentNode.className = "menu-top-active";
		}
		//by manodip new inventory
		if(crtPage=='stockinnewloadstockin.htm')
		{
		//alert('hi');
		arr[6].className = "menu-top-active";
		arr[6].parentNode.className = "menu-top-active";
		}
		if(crtPage=='stockoutnewloadstockout.htm')
		{
		//alert('hi');
		arr[6].className = "menu-top-active";
		arr[6].parentNode.className = "menu-top-active";
		}
		//end manodip
		//start rm
		if(crtPage=='recipeloadrecipeingredient.htm')
		{
		//alert('hi');
		arr[7].className = "menu-top-active";
		arr[7].parentNode.className = "menu-top-active";
		}
		if(crtPage=='edploadedp.htm')
		{
		//alert('hi');
		arr[7].className = "menu-top-active";
		arr[7].parentNode.className = "menu-top-active";
		}
		if(crtPage=='requisitionloadrequisition.htm')
		{
		//alert('hi');
		arr[7].className = "menu-top-active";
		arr[7].parentNode.className = "menu-top-active";
		}
		if(crtPage=='rawstockinloadrawstockin.htm')
		{
		//alert('hi');
		arr[7].className = "menu-top-active";
		arr[7].parentNode.className = "menu-top-active";
		}
		if(crtPage=='rawstockoutloadrawstockout.htm')
		{
		//alert('hi');
		arr[7].className = "menu-top-active";
		arr[7].parentNode.className = "menu-top-active";
		}
		if(crtPage=='rawcloseloadrawclose.htm')
		{
		//alert('hi');
		arr[7].className = "menu-top-active";
		arr[7].parentNode.className = "menu-top-active";
		}
		if(crtPage=='fgstockinloadfgstockin.htm')
		{
		//alert('hi');
		arr[7].className = "menu-top-active";
		arr[7].parentNode.className = "menu-top-active";
		}
		if(crtPage=='fgstockoutloadfgstockout.htm')
		{
		//alert('hi');
		arr[7].className = "menu-top-active";
		arr[7].parentNode.className = "menu-top-active";
		}
		if(crtPage=='fgcloseloadfgclose.htm')
		{
		//alert('hi');
		arr[7].className = "menu-top-active";
		arr[7].parentNode.className = "menu-top-active";
		}
		//end rm
		if(crtPage=='menumgntviewmenumgnt.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='menumgntloadmenuitems.htm')
			{
			//alert('hi');
			arr[8].className = "menu-top-active";
			arr[8].parentNode.className = "menu-top-active";
			}
		if(crtPage=='menumgntloadsubcategory.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='menumgntloadsubcategorybyid.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='tablemgntloadtablemgnt.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='unpaidorderlistloadunpaidorder.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='taxmgntviewtaxmgnt.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='expendituremgmtloadexpendituremgmt.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='expendituremgmtviewdailyexpenditure.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='vendormgntloadvendormgnt.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='inventorymgntloadinvtypemgnt.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='inventorymgntloadinvitemmgnt.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='inventorymgntloadsimpleinvitemmgnt.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		
		if(crtPage=='storecustomermgntloadstorecustomermgnt.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='creditsaleloadcreditcustomer.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='menumgntviewmenuitemupload.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		if(crtPage=='menumgntuploadmenuitem.htm')
		{
		//alert('hi');
		arr[8].className = "menu-top-active";
		arr[8].parentNode.className = "menu-top-active";
		}
		
		/**/	
	}
}

function setPage()
{
	hrefString = document.location.href ? document.location.href : document.location;
	var newhref=null;
	var cuttedhref=hrefString.substring(0, hrefString.indexOf('?'));
	if(cuttedhref==null || cuttedhref=='')
		{
		newhref=hrefString;
		}
	else
		{
		newhref=cuttedhref;
		}
	if (document.getElementById("nav")!=null)
		setActiveMenu(document.getElementById("nav").getElementsByTagName("a"), extractPageName(newhref));
}