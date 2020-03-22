package com.gy.controller;

import com.gy.dto.Result;
import com.gy.entity.SysRole;
import com.gy.service.SmsRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName RoleController
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/14 17:19
 **/
@Controller
@RequestMapping("/role")
@Slf4j
public class RoleController {

    @Autowired
    private SmsRoleService smsRoleService;

    //角色列表
    //分页查询
    @RequestMapping("/rolelist")
    public String rolellist(@RequestParam(required = false,defaultValue = "1") Integer pageNum, @RequestParam(required = false,defaultValue = "10") Integer pageSize, Model model){
        //查询总数，计算总页码
        int userNum = smsRoleService.roleNum();
        int totalPage = 0;
        if (userNum % pageSize == 0){
            totalPage = userNum / pageSize;
        }else{
            totalPage = userNum / pageSize +1;
        }

        //查询数据
        List<SysRole> sysRoles = smsRoleService.allRole(pageNum, pageSize);
        model.addAttribute("sysRoles",sysRoles);
        model.addAttribute("pageNum",pageNum);
        model.addAttribute("totalPage",totalPage);
        return "rolelist";
    }

    //新增角色表单
    @RequestMapping("/addrole")
    public String addRole(){
        return "addrole";
    }

    //新增保存用户信息
    @ResponseBody
    @RequestMapping("/saverole")
    public Result saveRole(@RequestParam String roleName){

        Result result = new Result();
        int repeatRole = smsRoleService.findRepeatRole(roleName);
        if(repeatRole == 1){
            result.setRepeatUser(false);
            return result;
        }else{
            SysRole sysRole = new SysRole();
            sysRole.setRoleName(roleName);
            int i = smsRoleService.saveRole(sysRole);
            if (i == 1){
                result.setSuccess(true);
            }
            else{
                result.setSuccess(false);
            }
            return result;
        }
    }

    @RequestMapping("/editrole")
    public String editRole(@RequestParam Integer roleId,Model model){
        SysRole sysRole = smsRoleService.editRole(roleId);
        model.addAttribute("role",sysRole);
        return "editrole";
    }

    @ResponseBody
    @RequestMapping("/updaterole")
    public Result update(@RequestParam String roleName,@RequestParam Integer roleId){

        Result res = new Result();

        SysRole sysRole = new SysRole();
        sysRole.setRoleName(roleName);
        sysRole.setId(roleId);
        int i = smsRoleService.updateRole(sysRole);
        if (i == 1){
            res.setSuccess(true);
        }
        else{
            res.setSuccess(false);
        }
        return res;
    }

    @ResponseBody
    @RequestMapping("/deleterole")
    public Result deleteRole(@RequestParam Integer roleId){
        Result result = new Result();
        int i = smsRoleService.deleteSysRole(roleId);
        if(i == 1){
            result.setSuccess(true);
        }else {
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/doassignPermission")
    public Result doassignPer(@RequestParam Integer roleId,@RequestParam Integer[] permissionids){
        Result result = new Result();
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("roleId",roleId);
        map.put("permissionids",permissionids);
        Integer deleteRolePermission = smsRoleService.deleteRolePermission(roleId);
        if (deleteRolePermission >= 0){
            Integer insertRolePermission = smsRoleService.insertRolePermission(map);
            if (insertRolePermission >= 1){
                result.setSuccess(true);
            }else{
                result.setSuccess(false);
            }
        }else{
            result.setSuccess(false);
        }
        return result;
    }
}
