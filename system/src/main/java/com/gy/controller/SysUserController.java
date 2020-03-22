package com.gy.controller;

import com.gy.dto.Result;
import com.gy.entity.SysRole;
import com.gy.entity.SysUser;
import com.gy.service.SmsRoleService;
import com.gy.service.SmsUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @ClassName SysUserController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/8 18:25
 **/
@Controller
@RequestMapping("/user")
@Slf4j
public class SysUserController {

    @Autowired
    private SmsUserService smsUserService;

    @Autowired
    private SmsRoleService smsRoleService;

    //用户列表
    //分页查询
    @RequestMapping("/userlist")
    public String userlist(@RequestParam(required = false,defaultValue = "1") Integer pageNum, @RequestParam(required = false,defaultValue = "10") Integer pageSize, Model model){
        //查询总数，计算总页码
        int userNum = smsUserService.userNum();
        int totalPage = 0;
        if (userNum % pageSize == 0){
            totalPage = userNum / pageSize;
        }else{
            totalPage = userNum / pageSize +1;
        }

        //查询数据
        List<SysUser> sysUsers = smsUserService.allUser(pageNum, pageSize);
        model.addAttribute("sysUsers",sysUsers);
        model.addAttribute("pageNum",pageNum);
        model.addAttribute("totalPage",totalPage);
        return "userlist";
    }

    //新增用户表单
    @RequestMapping("/adduser")
    public String addUser(){
        return "adduser";
    }

    //新增保存用户信息
    @ResponseBody
    @RequestMapping("/saveuser")
    public Result saveUser(@RequestParam String userName,@RequestParam String pwd,@RequestParam String mobile,@RequestParam String email,@RequestParam String comp){
        log.info("新增用户参数:{},{},{},{},{}",userName,pwd,mobile,email,comp);
        Result result = new Result();
        int repeatUser = smsUserService.findRepeatUser(userName);
        if(repeatUser == 1){
            result.setRepeatUser(false);
            return result;
        }else{
            SysUser sysUser = new SysUser();
            sysUser.setEmail(email);
            sysUser.setUserName(userName);
            sysUser.setPassWord(pwd);
            sysUser.setTelePhone(mobile);
            sysUser.setComp(comp);
            int i = smsUserService.saveUser(sysUser);
            if (i == 1){
                result.setSuccess(true);
            }
            else{
                result.setSuccess(false);
            }
            return result;
        }
    }

    @RequestMapping("/edituser")
    public String editUser(@RequestParam Integer userId,Model model){
        SysUser sysUser = smsUserService.editUser(userId);
        model.addAttribute("user",sysUser);
        return "edituser";
    }

    @RequestMapping("/addassign")
    public String assign(@RequestParam Integer userId,Model model){
        SysUser sysUser = smsUserService.editUser(userId);
        model.addAttribute("user",sysUser);
        List<SysRole> sysRoles = smsRoleService.assignAllRoles();
        List<SysRole> assignRoles = new ArrayList<SysRole>();
        List<SysRole> unassignRoles = new ArrayList<SysRole>();
        //获取关系表数据
        List<Integer> sysUserRoleids = smsUserService.findSysUserRoleids(userId);
        for (SysRole sysRole : sysRoles){
            if (sysUserRoleids.contains(sysRole.getId())){
                assignRoles.add(sysRole);
            }else{
                unassignRoles.add(sysRole);
            }
        }
        model.addAttribute("sysRoles",sysRoles);
        model.addAttribute("assignRoles",assignRoles);
        model.addAttribute("unassignRoles",unassignRoles);
        return "assignrole";
    }

    @ResponseBody
    @RequestMapping("/doAssign")
    public Result doAssign(@RequestParam Integer userId,@RequestParam Integer[] unassignroleids){
        Result result = new Result();
        try{
            //增加关系表数据
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("userId",userId);
            map.put("roleids",unassignroleids);
            smsUserService.insertSysUserRole(map);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/dounAssign")
    public Result dounAssign(@RequestParam Integer userId,@RequestParam Integer[] assignroleids){
        Result result = new Result();
        try{
            //删除关系表数据
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("userId",userId);
            map.put("roleids",assignroleids);
            smsUserService.deleteSysUserRole(map);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/updateuser")
    public Result update(@RequestParam String userName,@RequestParam String pwd,@RequestParam String mobile,@RequestParam String email,@RequestParam Integer userId,@RequestParam Integer status,@RequestParam String comp){
        log.info("参数：{},{},{},{},{},{},{}",userName,pwd,mobile,email,userId,status,comp);
        Result res = new Result();

        SysUser user = new SysUser();
        user.setEmail(email);
        user.setUserName(userName);
        user.setPassWord(pwd);
        user.setTelePhone(mobile);
        user.setId(userId);
        user.setStatus(status);
        user.setComp(comp);
        int i = smsUserService.updateUser(user);
        if (i == 1){
            res.setSuccess(true);
        }
        else{
            res.setSuccess(false);
        }
        return res;
    }

    @ResponseBody
    @RequestMapping("/deleteuser")
    public Result deleteUser(@RequestParam Integer userId){
        Result result = new Result();
        int i = smsUserService.deleteSysUser(userId);
        if(i == 1){
            result.setSuccess(true);
        }else {
            result.setSuccess(false);
        }
        return result;
    }
}


