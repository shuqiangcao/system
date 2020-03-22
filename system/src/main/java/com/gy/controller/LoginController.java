package com.gy.controller;

import com.gy.dto.Result;
import com.gy.entity.Permission;
import com.gy.entity.SysUser;
import com.gy.service.PermissionService;
import com.gy.service.SendSmsService;
import com.gy.service.SmsLoginService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * @ClassName TestController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/6 14:03
 **/
@Controller
@RequestMapping("/sms")
@Slf4j
public class LoginController {

    @Autowired
    private SmsLoginService smsLoginService;

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private SendSmsService sendSmsService;

    //登录页面
    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    //主页
    @RequestMapping("/main")
    public String main(Model model,HttpSession session){
        SysUser loginuser = (SysUser)session.getAttribute("loginuser");
        log.info("用户:{}",loginuser);
        //判断用户是否是超级管理员(查询角色id) 1:超级管理员，拥有所有权限
        String userRoleId = sendSmsService.queryUserAccess(loginuser.getId());
        String cpName = "";
        //查询折线图数据,前七天的发送数
        if (!"1".equals(userRoleId)){
            cpName = loginuser.getComp();
            Result result = smsLoginService.queryCpSendNum(cpName);
            model.addAttribute("result",result);
        }else{
            Result result = smsLoginService.querySendNum();
            model.addAttribute("result",result);
        }
        return "main";
    }

    //登录
    @ResponseBody
    @PostMapping("/submitlogin")
    public Object submitLogin(@RequestParam String username, @RequestParam String password, HttpSession session){
        log.info("用户名密码:{},{}",username,password);
        Result result = new Result();
        SysUser sysUser = smsLoginService.loginUser(username,password);
        if (sysUser != null){
            //获取用户权限信息
            Permission root = null;
            List<Permission> permissions = permissionService.queryPermissionsByUser(sysUser);
            Map<Integer,Permission> permissionMap = new HashMap<Integer, Permission>();
            Set<String> permissionSet = new HashSet<String>();
            for (Permission permission : permissions){
                permissionMap.put(permission.getId(),permission);
                if (permission.getUrl() != null && !"".equals(permission.getUrl())){
                    permissionSet.add(permission.getUrl());
                }
            }
            session.setAttribute("permissionSet",permissionSet);
            for (Permission permission : permissions){
                Permission child = permission;
                if (child.getPid() == 0){
                    root = permission;
                }else{
                    Permission parent = permissionMap.get(child.getPid());
                    parent.getChildren().add(child);
                }
            }
            session.setAttribute("rootPermission",root);
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        session.setAttribute("loginuser",sysUser);
        return result;
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:login";
    }
}
