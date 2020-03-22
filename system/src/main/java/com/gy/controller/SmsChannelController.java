package com.gy.controller;

import com.gy.dto.Result;
import com.gy.entity.SmsChannel;
import com.gy.service.SmsChannelService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @ClassName SmsChannelController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/16 14:50
 **/
@Controller
@RequestMapping("/channel")
@Slf4j
public class SmsChannelController {

    @Autowired
    private SmsChannelService smsChannelService;

    @RequestMapping("/channelmsg")
    public String channelList(@RequestParam(required = false,defaultValue = "1") Integer pageNum, @RequestParam(required = false,defaultValue = "10") Integer pageSize, Model model){
        Result result = smsChannelService.queryAllChannel(pageNum, pageSize);
        model.addAttribute("result",result);
        return "/channelmanagement/channellist";
    }

    @RequestMapping("/addchannel")
    public String addChannel(){
        return "channelmanagement/addchannel";
    }

    @RequestMapping("/savechannel")
    @ResponseBody
    public Result saveChannel(@RequestBody SmsChannel smsChannel){
        log.info("新增通道参数:{}",smsChannel.toString());
        Result result = smsChannelService.insertChannel(smsChannel);
        return result;
    }

    @RequestMapping("/editchannel")
    public String editChannel(@RequestParam Integer channelId,Model model){
        log.info("通道id:{}",channelId);
        SmsChannel smsChannel = smsChannelService.queryEditChannelById(channelId);
        model.addAttribute("smsChannel",smsChannel);
        return "channelmanagement/editchannel";
    }

    @RequestMapping("/saveeditchannel")
    @ResponseBody
    public Result saveEditchannel(@RequestBody SmsChannel smsChannel){
        log.info("通道修改参数:{}",smsChannel.toString());
        Result result = smsChannelService.updateChannel(smsChannel);
        return result;
    }

    @RequestMapping("/deletechannel")
    @ResponseBody
    public Result deleteChannel(@RequestParam Integer channelId){
        log.info("删除通道id:{}",channelId);
        Result result = smsChannelService.deleteChannel(channelId);
        return result;
    }

}
