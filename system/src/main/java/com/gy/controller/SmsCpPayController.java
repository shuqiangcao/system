package com.gy.controller;

import com.gy.dto.Result;
import com.gy.entity.SmsCp;
import com.gy.entity.SysUser;
import com.gy.service.SendSmsService;
import com.gy.service.SmsCpPayService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @ClassName CpPayController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/25 18:28
 **/
@Controller
@RequestMapping("/pay")
@Slf4j
public class SmsCpPayController {

    @Autowired
    private SmsCpPayService smsCpPayService;

    @Autowired
    private SendSmsService sendSmsService;

    @RequestMapping("/cppayrecord")
    public String payList(Model model, @RequestParam(required = false,defaultValue = "1") Integer pageNum, @RequestParam(required = false,defaultValue = "10") Integer pageSize, @RequestParam(required = false,defaultValue = "") String cp, HttpSession session){
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        if (!"1".equals(userRoleId)){
            cp = loginuser.getUserName();
            Result result = smsCpPayService.queryPayList(pageNum,pageSize,cp);
            model.addAttribute("payList",result);
            return "/paymanagement/userpaylist";
        }else{
            //查询所有渠道账号
            List<SmsCp> smsCps = sendSmsService.queryCp();
            Result result = smsCpPayService.queryPayList(pageNum,pageSize,cp);
            model.addAttribute("payList",result);
            model.addAttribute("smsCps",smsCps);
            return "/paymanagement/paylist";
        }
    }

    @RequestMapping("/checkpaylist")
    @ResponseBody
    public Result checkPayList(@RequestParam(required = false,defaultValue = "1") Integer pageNum,@RequestParam(required = false,defaultValue = "10") Integer pageSize,@RequestParam(required = false,defaultValue = "") String cp,@RequestParam String begintime,@RequestParam String endtime){

        Result result = smsCpPayService.queryCpPayList(pageNum,pageSize,cp,begintime,endtime);
        return result;
    }

    @RequestMapping("/checkuserpaylist")
    @ResponseBody
    public Result checkUserPayList(@RequestParam(required = false,defaultValue = "1") Integer pageNum,@RequestParam(required = false,defaultValue = "10") Integer pageSize,@RequestParam(required = false,defaultValue = "") String cp,@RequestParam String begintime,@RequestParam String endtime,HttpSession session){
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        cp = loginuser.getUserName();
        Result result = smsCpPayService.queryCpPayList(pageNum,pageSize,cp,begintime,endtime);
        return result;
    }

    @RequestMapping("/cpconsumelist")
    public String cpConsumeRecord(Model model, @RequestParam(required = false,defaultValue = "1") Integer pageNum,@RequestParam(required = false,defaultValue = "10") Integer pageSize,@RequestParam(required = false,defaultValue = "") String cp,HttpSession session){
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        if (!"1".equals(userRoleId)){
            cp = loginuser.getComp();
            Result result = smsCpPayService.queryConsumeList(pageNum,pageSize,cp);
            model.addAttribute("consumeList",result);
            return "/paymanagement/userconsumelist";
        }else{
            //查询所有渠道账号
            List<SmsCp> smsCps = sendSmsService.queryCp();
            Result result = smsCpPayService.queryConsumeList(pageNum,pageSize,cp);
            model.addAttribute("consumeList",result);
            model.addAttribute("smsCps",smsCps);
            return "/paymanagement/cpconsumelist";
        }
    }

    @RequestMapping("/checkconsumelist")
    @ResponseBody
    public Result checkConsumeList(@RequestParam(required = false,defaultValue = "1") Integer pageNum,@RequestParam(required = false,defaultValue = "10") Integer pageSize,@RequestParam(required = false,defaultValue = "") String cp,@RequestParam String begintime,@RequestParam String endtime){

        Result result = smsCpPayService.queryCpConsumeList(pageNum,pageSize,cp,begintime,endtime);
        return result;
    }

    @RequestMapping("/checkuserconsumelist")
    @ResponseBody
    public Result checkUserConsumeList(@RequestParam(required = false,defaultValue = "1") Integer pageNum,@RequestParam(required = false,defaultValue = "10") Integer pageSize,@RequestParam(required = false,defaultValue = "") String cp,@RequestParam String begintime,@RequestParam String endtime,HttpSession session){
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        cp = loginuser.getComp();
        Result result = smsCpPayService.queryCpConsumeList(pageNum,pageSize,cp,begintime,endtime);
        return result;
    }

}
