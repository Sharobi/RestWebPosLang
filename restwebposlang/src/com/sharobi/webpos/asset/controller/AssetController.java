package com.sharobi.webpos.asset.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/asset")
public class AssetController {
  
  @RequestMapping("/loadassetMaster")
  public String openAssetPage()
  {
    return ForwardConstants.VIEW_ASSET_MASTER;
  }

}
