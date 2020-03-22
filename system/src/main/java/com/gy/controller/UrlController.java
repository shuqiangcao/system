package com.gy.controller;

import com.gy.dto.Result;
import com.gy.service.UrlService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @ClassName UrlController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/1/15 18:02
 **/
@Controller
@RequestMapping("/url")
@Slf4j
public class UrlController {

    @Autowired
    UrlService urlService;

    @RequestMapping("/batchurl")
    public String batchUrl(){
        return "smsmanagement/addbatchurl";
    }

    @RequestMapping("/addbatchurl")
    @ResponseBody
    public Result addBatchUrl(@RequestParam String longurl){

        Result result = urlService.addBatchUrl(longurl);
        return result;
    }

    @RequestMapping("/allbatchurl")
    public String allBatchurl(){
        return "smsmanagement/batchurl";
    }

    @RequestMapping("/addallurl")
    @ResponseBody
    public Result addAllurl(@RequestParam String longurl,@RequestParam String mobile){

        Result result = urlService.addallBatchUrl(longurl,mobile);
        return result;
    }
}
