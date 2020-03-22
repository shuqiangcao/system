package com.gy.controller;

import com.gy.dto.Result;
import com.gy.entity.SmsAudit;
import com.gy.entity.SmsCp;
import com.gy.entity.SmsTemplate;
import com.gy.entity.SysUser;
import com.gy.service.SendSmsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

/**
 * @ClassName SendSmsController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/6 15:57
 **/
@Controller
@RequestMapping("/send")
@Slf4j
public class SendSmsController {

    @Autowired
    SendSmsService sendSmsService;

    @RequestMapping("/sendsms")
    public String sendSms(Model model,HttpSession session){
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        String cpName = "";
        if (!"1".equals(userRoleId)){
            cpName = loginuser.getComp();
            List<SmsCp> smsCps = sendSmsService.queryCpByname(cpName);
            List<SmsTemplate> smsTemplates = sendSmsService.queryTemplateByname(cpName);
            model.addAttribute("smsCps",smsCps);
            model.addAttribute("smsTemplates",smsTemplates);
            model.addAttribute("userRoleId",userRoleId);
        }else{
            List<SmsCp> smsCps = sendSmsService.queryCp();
            List<SmsTemplate> smsTemplates = sendSmsService.queryTemplate();
            model.addAttribute("smsCps",smsCps);
            model.addAttribute("smsTemplates",smsTemplates);
            model.addAttribute("userRoleId",userRoleId);
        }

        return "/smsmanagement/sendsms";
    }

    @RequestMapping("/checktemplate")
    @ResponseBody
    public Result checktemplate(@RequestParam Integer id){
        Result result = sendSmsService.queryTemplateById(id);
        return result;
    }

    @RequestMapping("/submitsms")
    @ResponseBody
    public Result submitsms(@RequestBody SmsAudit smsAudit){
        log.info("提交参数:{}",smsAudit.toString());
        Result result = sendSmsService.insertAudit(smsAudit);
        return result;
    }

    @RequestMapping("/smsaudit")
    public String smsaudit(@RequestParam(required = false,defaultValue = "1") Integer pageNum, @RequestParam(required = false,defaultValue = "10") Integer pageSize,Model model){

        //查询渠道
        List<SmsCp> smsCps = sendSmsService.queryCp();
        //分页查询
        Result result = sendSmsService.queryAllAudit(pageNum, pageSize);
        model.addAttribute("cp",smsCps);
        model.addAttribute("result",result);
        return "/smsmanagement/smsauditlist";
    }

    @RequestMapping("/checkaudit")
    @ResponseBody
    public Result checkaudit(@RequestParam(required = false,defaultValue = "1") Integer pageNum, @RequestParam(required = false,defaultValue = "10") Integer pageSize,@RequestParam String cp,@RequestParam String begintime,@RequestParam String endtime,@RequestParam String status) throws UnsupportedEncodingException {
        log.info("渠道:{}", URLDecoder.decode(cp,"utf-8"));
        cp = URLDecoder.decode(cp,"utf-8");
        //分页查询
        Result result = sendSmsService.queryCpAllAudit(pageNum, pageSize, cp, begintime, endtime,status);
        return result;
    }


    @RequestMapping("/isaudit")
    @ResponseBody
    public Result isaudit(@RequestParam Integer id) {
        Result result = sendSmsService.doAudit(id);
        return result;
    }

    @RequestMapping("/showmobile")
    @ResponseBody
    public Result showMobile(@RequestParam Integer id){
        Result result = sendSmsService.queryauditMobile(id);
        return result;
    }

    @RequestMapping("/deleteaudit")
    @ResponseBody
    public Result deleteAudit(@RequestParam Integer id){
        Result result = sendSmsService.deleteAudit(id);
        return result;
    }

}
