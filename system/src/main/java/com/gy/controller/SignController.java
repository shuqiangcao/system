package com.gy.controller;

import com.gy.dto.Result;
import com.gy.entity.SmsSign;
import com.gy.service.SmsSignService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @ClassName SignController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/21 14:55
 **/
@Controller
@RequestMapping("/sign")
@Slf4j
public class SignController {

    @Autowired
    private SmsSignService smsSignService;

    @RequestMapping("/signlist")
    public String signList(@RequestParam(required = false,defaultValue = "1") Integer pageNum, @RequestParam(required = false,defaultValue = "10") Integer pageSize, Model model){

        Result result = smsSignService.findAllSign(pageNum, pageSize);
        model.addAttribute("result",result);
        return "/smsmanagement/signlist";
    }

    @ResponseBody
    @RequestMapping("/savesign")
    public Result saveSign(@RequestBody SmsSign smsSign){
        log.info("参数:{}",smsSign.toString());
        Result result = new Result();
        int repeatSign = smsSignService.querySign(smsSign);
        if (repeatSign == 1){
            result.setRepeatsign(false);
        }else{
            int insertNum = smsSignService.insertSign(smsSign);
            if (insertNum == 1){
                result.setSuccess(true);
            }else{
                result.setSuccess(false);
            }
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/editsign")
    public Result editSign(@RequestParam Integer signId){
        Result result = new Result();
        SmsSign smsSign = smsSignService.signBySignId(signId);
        if (smsSign != null){
            result.setSuccess(true);
            result.setData(smsSign);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/saveeditsign")
    public Result saveeditsign(@RequestBody SmsSign smsSign){
        log.info("参数:{}",smsSign.toString());
        return smsSignService.updatesign(smsSign);
    }

    @ResponseBody
    @RequestMapping("/deletesign")
    public Result saveeditsign(@RequestParam Integer signId){
        log.info("参数:{}",signId);
        return smsSignService.deletesign(signId);
    }
}
