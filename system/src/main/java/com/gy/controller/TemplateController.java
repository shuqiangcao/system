package com.gy.controller;

import com.gy.dto.Result;
import com.gy.entity.SmsTemplate;
import com.gy.service.SmsTemplateService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;
import java.util.List;

/**
 * @ClassName TemplateController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/27 11:28
 **/
@Controller
@RequestMapping("/template")
@Slf4j
public class TemplateController {

    @Autowired
    SmsTemplateService smsTemplateService;

    @RequestMapping("/templatelist")
    public String templateList(@RequestParam(required = false,defaultValue = "1") Integer pageNum, @RequestParam(required = false,defaultValue = "10") Integer pageSize, Model model){
        Result result = smsTemplateService.findAllTemplate(pageNum, pageSize);
        model.addAttribute("result",result);
        return "/smsmanagement/templatelist";
    }

    @RequestMapping("/checkchannel")
    @ResponseBody
    public Result checkChannel(){
        return smsTemplateService.queryallchannel();
    }

    @RequestMapping("/checkcp")
    @ResponseBody
    public Result checkCp(){
        return smsTemplateService.queryallCp();
    }

    @RequestMapping("/savetemplate")
    @ResponseBody
    public Result savetemplate(@RequestBody SmsTemplate smsTemplate){
        log.info("模板参数:{}",smsTemplate.toString());
        return smsTemplateService.insertTemplate(smsTemplate);
    }

    @ResponseBody
    @RequestMapping("/edittemplate")
    public Result edittemplate(@RequestParam Integer templateId){
        return smsTemplateService.queryTemplate(templateId);
    }

    @RequestMapping("/saveedittemplate")
    @ResponseBody
    public Result saveedittemplate(@RequestBody SmsTemplate smsTemplate){
        log.info("编辑模板参数:{}",smsTemplate.toString());
        return smsTemplateService.updateTemplate(smsTemplate);
    }

    @RequestMapping("/deletetemplate")
    @ResponseBody
    public Result deletetemplate(@RequestParam Integer templateId){
        return smsTemplateService.deleteTemplate(templateId);
    }

}
