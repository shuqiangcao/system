package com.gy.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.gy.dto.Result;
import com.gy.entity.SmsChannel;
import com.gy.entity.SmsCp;
import com.gy.entity.SmsNotify;
import com.gy.entity.SysUser;
import com.gy.service.SendSmsService;
import com.gy.service.SmsStatisticsService;
import com.gy.util.ExcelUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpResponse;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

/**
 * @ClassName SmsStatisticsController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/19 11:10
 **/
@Controller
@RequestMapping("/statistical")
@Slf4j
public class SmsStatisticsController {

    @Autowired
    private SmsStatisticsService smsStatisticsService;

    @Autowired
    private SendSmsService sendSmsService;


    @RequestMapping("/querymsg")
    public String queryMsg(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                           @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                           Model model,HttpSession session){
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        String cpName = "";
        if (!"1".equals(userRoleId)){
            cpName = loginuser.getComp();
            Result result = smsStatisticsService.queryAllrecord(pageNum, pageSize,cpName);
            log.info("渠道发送记录返回:{}",result.toString());
            model.addAttribute("result",result);
            return "/smsstatistics/cpsendrecord";
        }else{
            List<SmsCp> smsCps = sendSmsService.queryCp();
            Result result = smsStatisticsService.queryAllrecord(pageNum, pageSize,cpName);
            model.addAttribute("result",result);
            model.addAttribute("smsCps",smsCps);
            return "/smsstatistics/sendrecord";
        }
    }

    @RequestMapping("/checkrecord")
    @ResponseBody
    public Result checkRecord(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                              @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                              @RequestParam String cp,
                              @RequestParam String begintime,
                              @RequestParam String endtime) throws UnsupportedEncodingException {
        log.info("渠道:{}", URLDecoder.decode(cp,"utf-8"));
        cp = URLDecoder.decode(cp,"utf-8");
        //分页查询
        Result result = smsStatisticsService.queryRecord(pageNum, pageSize, cp, begintime, endtime);
        return result;
    }

    @RequestMapping("/cpcheckrecord")
    @ResponseBody
    public Result cpcheckRecord(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                              @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                              @RequestParam String begintime,
                              @RequestParam String endtime,
                              HttpSession session) throws UnsupportedEncodingException {
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        log.info("渠道:{}", loginuser.getComp());
        String cp = loginuser.getComp();
        //分页查询
        Result result = smsStatisticsService.queryRecord(pageNum, pageSize, cp, begintime, endtime);
        return result;
    }


    @RequestMapping("/sendstatistical")
    public String sendStatistical(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                  @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                  @RequestParam(required = false,defaultValue = "") String begintime,
                                  @RequestParam(required = false,defaultValue = "") String endtime,
                                  Model model,HttpSession session) throws UnsupportedEncodingException {

        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        String cpName = "";
        if (!"1".equals(userRoleId)){
            cpName = loginuser.getComp();
            //分页查询
            Result result = smsStatisticsService.querySendCount(pageNum, pageSize, begintime, endtime,cpName);
            model.addAttribute("result",result);
            return "/smsstatistics/cpsendcount";
        }else{
            //查询所有渠道账号
            List<SmsCp> smsCps = sendSmsService.queryCp();
            //查询所有通道账号
            List<SmsChannel> smsChannels = smsStatisticsService.queryChannel();
            //分页查询
            Result result = smsStatisticsService.querySendCount(pageNum, pageSize, begintime, endtime,cpName);
            model.addAttribute("result",result);
            model.addAttribute("smsCps",smsCps);
            model.addAttribute("smsChannel",smsChannels);
            return "/smsstatistics/sendcount";
        }
    }

    @RequestMapping("/checksendcount")
    @ResponseBody
    public Result checkSendCount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                  @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                  @RequestParam String cp,
                                  @RequestParam String channel,
                                  @RequestParam String byway,
                                  @RequestParam String begintime,
                                  @RequestParam String endtime
                                  ) throws UnsupportedEncodingException {
        cp = URLDecoder.decode(cp,"UTF-8");
        channel = URLDecoder.decode(channel,"UTF-8");
        log.info("渠道:{}", cp);
        log.info("通道:{}", channel);
        log.info("渠道:{}", byway);

        //分页查询
        Result result = smsStatisticsService.querySendCountByWay(cp,channel,byway,pageNum, pageSize, begintime, endtime);
        return result;
    }

    @RequestMapping("/checkcpsendcount")
    @ResponseBody
    public Result checkCpSendCount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                 @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                 @RequestParam String begintime,
                                 @RequestParam String endtime,
                                  HttpSession session
    ) throws UnsupportedEncodingException {
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        String cp = loginuser.getComp();
        log.info("渠道:{}", cp);
        //分页查询
        Result result = smsStatisticsService.querySendCount(pageNum, pageSize, begintime, endtime,cp);
        return result;
    }


    @RequestMapping("/smssubmit")
    public String smsSubmit(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                  @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                  @RequestParam(required = false,defaultValue = "") String begintime,
                                  @RequestParam(required = false,defaultValue = "") String endtime,
                                  Model model,HttpSession session) throws UnsupportedEncodingException {
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        String cpName = "";
        if (!"1".equals(userRoleId)){
            cpName = loginuser.getComp();
            //分页统计
            Result result = smsStatisticsService.querySmsSubmit(pageNum, pageSize, begintime, endtime,cpName);
            model.addAttribute("result",result);
            return "/smsstatistics/cpsubmitcount";
        }else{
            //查询所有渠道账号
            List<SmsCp> smsCps = sendSmsService.queryCp();
            //查询所有通道账号
            List<SmsChannel> smsChannels = smsStatisticsService.queryChannel();
            //分页统计
            Result result = smsStatisticsService.querySmsSubmit(pageNum, pageSize, begintime, endtime,cpName);
            model.addAttribute("result",result);
            model.addAttribute("smsCps",smsCps);
            model.addAttribute("smsChannel",smsChannels);
            return "/smsstatistics/submitcount";
        }
    }

    @RequestMapping("/checksubmitcount")
    @ResponseBody
    public Result checkSubmitCount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                            @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                            @RequestParam String cp,
                            @RequestParam String channel,
                            @RequestParam String byway,
                            @RequestParam String begintime,
                            @RequestParam String endtime
                            ) throws UnsupportedEncodingException {
        cp = URLDecoder.decode(cp,"UTF-8");
        channel = URLDecoder.decode(channel,"UTF-8");
        log.info("渠道:{}", cp);
        log.info("通道:{}", channel);
        log.info("渠道:{}", byway);

        //分页统计
        Result result = smsStatisticsService.queryCpSmsSubmit(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        return result;
    }

    @RequestMapping("/checkcpsubmitcount")
    @ResponseBody
    public Result checkCpSubmitCount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                   @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                   @RequestParam String begintime,
                                   @RequestParam String endtime,
                                   HttpSession session
    ) throws UnsupportedEncodingException {
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        String cp = loginuser.getComp();
        log.info("渠道:{}", cp);

        //分页统计
        Result result = smsStatisticsService.querySmsSubmit(pageNum, pageSize, begintime, endtime,cp);
        return result;
    }


    @RequestMapping("/smssuccess")
    public String smsSuccess(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                            @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                            @RequestParam(required = false,defaultValue = "") String begintime,
                            @RequestParam(required = false,defaultValue = "") String endtime,
                            Model model,HttpSession session) throws UnsupportedEncodingException {
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        String cpName = "";
        if (!"1".equals(userRoleId)){
            cpName = loginuser.getComp();
            //分页统计
            Result result = smsStatisticsService.querySmsSuccess(pageNum, pageSize, begintime, endtime,cpName);
            model.addAttribute("result",result);
            return "/smsstatistics/cpsuccesscount";
        }else{
            //查询所有渠道账号
            List<SmsCp> smsCps = sendSmsService.queryCp();
            //查询所有通道账号
            List<SmsChannel> smsChannels = smsStatisticsService.queryChannel();
            //分页统计
            Result result = smsStatisticsService.querySmsSuccess(pageNum, pageSize, begintime, endtime,cpName);
            model.addAttribute("result",result);
            model.addAttribute("smsCps",smsCps);
            model.addAttribute("smsChannel",smsChannels);
            return "/smsstatistics/successcount";
        }
    }

    @RequestMapping("/checksuccesscount")
    @ResponseBody
    public Result checkSuccessCount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                   @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                   @RequestParam String cp,
                                   @RequestParam String channel,
                                   @RequestParam String byway,
                                   @RequestParam String begintime,
                                   @RequestParam String endtime
    ) throws UnsupportedEncodingException {
        cp = URLDecoder.decode(cp,"UTF-8");
        channel = URLDecoder.decode(channel,"UTF-8");
        log.info("渠道:{}", cp);
        log.info("通道:{}", channel);
        log.info("渠道:{}", byway);

        //分页统计
        Result result = smsStatisticsService.querySmsSuccByWay(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        return result;
    }

    @RequestMapping("/checkcpsuccesscount")
    @ResponseBody
    public Result checkCpSuccessCount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                    @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                    @RequestParam String begintime,
                                    @RequestParam String endtime,
                                     HttpSession session
    ) throws UnsupportedEncodingException {
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        String cp = loginuser.getComp();
        log.info("渠道:{}", cp);
        //分页统计
        Result result = smsStatisticsService.querySmsSuccess(pageNum, pageSize, begintime, endtime,cp);
        return result;
    }


    @RequestMapping("/smsfail")
    public String smsFail(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                             @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                             @RequestParam(required = false,defaultValue = "") String begintime,
                             @RequestParam(required = false,defaultValue = "") String endtime,
                             Model model,HttpSession session) {
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        String cpName = "";
        if (!"1".equals(userRoleId)){
            cpName = loginuser.getComp();
            //分页统计
            Result result = smsStatisticsService.querySmsFail(pageNum, pageSize, begintime, endtime,cpName);
            model.addAttribute("result",result);
            return "/smsstatistics/cpfailcount";
        }else{
            //查询所有渠道账号
            List<SmsCp> smsCps = sendSmsService.queryCp();
            //查询所有通道账号
            List<SmsChannel> smsChannels = smsStatisticsService.queryChannel();
            //分页统计
            Result result = smsStatisticsService.querySmsFail(pageNum, pageSize, begintime, endtime,cpName);
            model.addAttribute("result",result);
            model.addAttribute("smsCps",smsCps);
            model.addAttribute("smsChannel",smsChannels);
            return "/smsstatistics/failcount";
        }
    }

    @RequestMapping("/checkfailcount")
    @ResponseBody
    public Result checkFailCount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                    @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                    @RequestParam String cp,
                                    @RequestParam String channel,
                                    @RequestParam String byway,
                                    @RequestParam String begintime,
                                    @RequestParam String endtime
    ) throws UnsupportedEncodingException {
        cp = URLDecoder.decode(cp,"UTF-8");
        channel = URLDecoder.decode(channel,"UTF-8");
        log.info("渠道:{}", cp);
        log.info("通道:{}", channel);
        log.info("渠道:{}", byway);

        //分页统计
        Result result = smsStatisticsService.querySmsFailByWay(cp, channel, byway, pageNum, pageSize, begintime, endtime);
        return result;
    }

    @RequestMapping("/checkcpfailcount")
    @ResponseBody
    public Result checkCpFailCount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                 @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                 @RequestParam String begintime,
                                 @RequestParam String endtime,
                                  HttpSession session
    ) throws UnsupportedEncodingException {

        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        String cp = loginuser.getComp();
        //分页统计
        Result result = smsStatisticsService.querySmsFail(pageNum, pageSize, begintime, endtime,cp);
        return result;
    }

    @RequestMapping("/querystatus")
    public String smsStatus(HttpSession session){
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        if (!"1".equals(userRoleId)){
            return "/smsstatistics/cpsmsstatus";
        }else{
            return "/smsstatistics/smsstatus";
        }
    }


    @RequestMapping("/checkmobilestatus")
    @ResponseBody
    public Result checkstatus(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                 @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                 @RequestParam String mobile,
                                 @RequestParam String begintime,
                                 @RequestParam String endtime,
                                 HttpSession session
    ){
        log.info("渠道:{}", mobile);
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限,查询所有的数据
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        String cpName = "";
        if (!"1".equals(userRoleId)){
            cpName = loginuser.getComp();
        }
        //分页统计
        Result result = smsStatisticsService.querySmsstatus(mobile, pageNum, pageSize, begintime, endtime,cpName);
        return result;
    }

    @RequestMapping("/infomsg")
    @ResponseBody
    public Result infoMsg(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                              @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                              @RequestParam String infoId
    ){
        log.info("批次号:{}", infoId);

        //分页统计
        Result result = smsStatisticsService.querySmsInfoMsg(infoId, pageNum, pageSize);
        return result;
    }

    @RequestMapping("/checkinfomsg")
    @ResponseBody
    public Result checkInfoMsg(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                          @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                          @RequestParam String infoId,
                          @RequestParam String resultstatus,
                          @RequestParam String mobile
    ){
        log.info("批次号:{}", infoId);
        log.info("状态:{}", resultstatus);
        log.info("手机号:{}", mobile);
        //分页统计
        Result result = smsStatisticsService.checkSmsInfoMsg(infoId, resultstatus, mobile, pageNum, pageSize);
        return result;
    }

    @RequestMapping("/smssendcount")
    public String smsSendCount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                  @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                  @RequestParam(required = false,defaultValue = "") String begintime,
                                  @RequestParam(required = false,defaultValue = "") String endtime,
                                  Model model,HttpSession session) throws UnsupportedEncodingException {

        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        String cpName = "";
        if (!"1".equals(userRoleId)){
            cpName = loginuser.getComp();
            //分页查询
            Result result = smsStatisticsService.querySmsSendCount(pageNum, pageSize, begintime, endtime,cpName);
            model.addAttribute("result",result);
            return "/smsstatistics/cpsmssendcount";
        }else{
            //查询所有渠道账号
            List<SmsCp> smsCps = sendSmsService.queryCp();
            //查询所有通道账号
            List<SmsChannel> smsChannels = smsStatisticsService.queryChannel();
            //分页查询
            Result result = smsStatisticsService.querySmsSendCount(pageNum, pageSize, begintime, endtime,cpName);
            model.addAttribute("result",result);
            model.addAttribute("smsCps",smsCps);
            model.addAttribute("smsChannel",smsChannels);
            return "/smsstatistics/smssendcount";
        }
    }


    @RequestMapping("/checksmssendcount")
    @ResponseBody
    public Result checkSmsSendCount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                 @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                 @RequestParam String cp,
                                 @RequestParam String channel,
                                 @RequestParam String byway,
                                 @RequestParam String begintime,
                                 @RequestParam String endtime
    ) throws UnsupportedEncodingException {
        cp = URLDecoder.decode(cp,"UTF-8");
        channel = URLDecoder.decode(channel,"UTF-8");
        log.info("渠道:{}", cp);
        log.info("通道:{}", channel);
        log.info("渠道:{}", byway);

        //分页查询
        Result result = smsStatisticsService.querySmsSendCountByWay(cp,channel,byway,pageNum, pageSize, begintime, endtime);
        return result;
    }

    @RequestMapping("/checkcpsmssendcount")
    @ResponseBody
    public Result checkCpSmssendcount(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
                                   @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                                   @RequestParam String begintime,
                                   @RequestParam String endtime,
                                   HttpSession session
    ) throws UnsupportedEncodingException {

        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        String cp = loginuser.getComp();
        //分页统计
        Result result = smsStatisticsService.querySmsSendCount(pageNum, pageSize, begintime, endtime,cp);
        return result;
    }

    @RequestMapping("/mobilefilter")
    @ResponseBody
    public Result mobileFilter(@RequestParam String infoId){
        log.info("批次号:{}", infoId);
        Result result = smsStatisticsService.queryMobileFilter(infoId);
        return result;
    }

    @RequestMapping("/exportmobilemsg")
    @ResponseBody
    public Result exportMsg(@RequestParam String infoId, HttpServletResponse response){
        log.info("批次号:{}", infoId);
        Result result = new Result();
        try {
            List<SmsNotify> smsNotifies = smsStatisticsService.exportMobileMsg(infoId);
            ExportParams params = new ExportParams("批次详情", null, "批次详情");
            Workbook workbook = ExcelExportUtil.exportExcel(params, SmsNotify.class, smsNotifies);
            File targetFile = new File("D:\\java\\apache-tomcat-7.0.99\\webapps\\down\\temp.xls");
            String absolutePath = targetFile.getAbsolutePath();
            log.info("保存地址:{}",absolutePath);
            FileOutputStream fos = new FileOutputStream(targetFile);
            workbook.write(fos);
            fos.close();
            result.setSuccess(true);
        }catch (Exception e){
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }

}
