package com.gy.controller;

import com.gy.dto.Result;
import com.gy.entity.SmsCp;
import com.gy.service.SmsCpService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;

/**
 * @ClassName CpController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/13 11:06
 **/
@Controller
@RequestMapping("/cp")
@Slf4j
public class SmsCpController {

    @Autowired
    private SmsCpService smsCpService;

    @RequestMapping("cpmessage")
    public String cpList(@RequestParam(required = false,defaultValue = "1") Integer pageNum, @RequestParam(required = false,defaultValue = "10") Integer pageSize, Model model){
        Result result = smsCpService.queryAllCp(pageNum, pageSize);
        model.addAttribute("result",result);
        return "/cpmanagement/cplist";
    }

    @RequestMapping("/addcp")
    public String addCp(){
        return "cpmanagement/addcp";
    }

    @RequestMapping("/savecp")
    @ResponseBody
    public Result saveCp(@RequestBody SmsCp smsCp){
        log.info("新增渠道参数:{}",smsCp.toString());
        Result result = smsCpService.insertCp(smsCp);
        return result;
    }

    @RequestMapping("/cpmsg")
    @ResponseBody
    public Result cpMsg(@RequestParam Integer cpId){
        log.info("渠道id:{}",cpId);
        Result result = smsCpService.queryCpById(cpId);
        return result;
    }

    @RequestMapping("/cppay")
    @ResponseBody
    public Result cpPay(@RequestParam String name, @RequestParam String account, @RequestParam BigDecimal balance, @RequestParam BigDecimal money, HttpSession session){
        log.info("渠道参数:{},{},{},{}",name,account,balance,money);
        Result result = smsCpService.updateCpBalance(name,account,money,balance,session);
        return result;
    }

    @RequestMapping("/editcp")
    public String editCp(@RequestParam Integer cpId,Model model){
        log.info("渠道id:{}",cpId);
        SmsCp smsEditCp = smsCpService.queryEditCpById(cpId);
        model.addAttribute("smsEditCp",smsEditCp);
        return "cpmanagement/editcp";
    }

    @RequestMapping("/saveeditcp")
    @ResponseBody
    public Result saveEditcp(@RequestBody SmsCp smsCp){
        log.info("渠道修改参数:{}",smsCp.toString());
        Result result = smsCpService.updateCp(smsCp);
        return result;
    }

    @RequestMapping("/deletecp")
    @ResponseBody
    public Result deleteCp(@RequestParam Integer cpId){
        log.info("删除渠道id:{}",cpId);
        Result result = smsCpService.deleteCp(cpId);
        return result;
    }

}
