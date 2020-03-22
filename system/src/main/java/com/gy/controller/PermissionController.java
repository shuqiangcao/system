package com.gy.controller;

import com.gy.dto.Result;
import com.gy.entity.Permission;
import com.gy.service.PermissionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName PermissionController
 * @Description TODO
 * @Author caoshuqiang
 * @Date 2019/11/17 22:58
 */
@Controller
@RequestMapping("/permission")
@Slf4j
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    @RequestMapping("/permissionlist")
    public String permissionList(){
        return "permission";
    }

    @ResponseBody
    @RequestMapping("/loadData")
    public Object loadData(){
       List<Permission> permissions = new ArrayList<Permission>();
        List<Permission> permissionList = permissionService.queryAll();
        Map<Integer,Permission> permissionMap = new HashMap<Integer, Permission>();
        for (Permission permission : permissionList){
            permissionMap.put(permission.getId(),permission);
        }
        for (Permission permission : permissionList){
            Permission child = permission;
            if (child.getPid() == 0){
                permissions.add(permission);
            }else{
                Permission parent = permissionMap.get(child.getPid());
                parent.getChildren().add(child);
            }
        }
        return permissions;
    }

    @RequestMapping("/addpermission")
    public String addPermission(){
        return "addpermission";
    }

    @ResponseBody
    @RequestMapping("/insert")
    public Result insertPermission(Permission permission){
        Result result = new Result();
        try {
            Integer integer = permissionService.repeatPermission(permission);
            if (integer == 1){
                result.setRepeatPermission(false);
                return result;
            }else{
                Integer i = permissionService.savePermission(permission);
                if (i == 1){
                    result.setSuccess(true);
                }else{
                    result.setSuccess(false);
                }
                return result;
            }

        }catch(Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/editpermission")
    public String edit(@RequestParam Integer id, Model model){
        Permission permission = permissionService.queryById(id);
        model.addAttribute("permission",permission);
        return "editpermission";
    }

    @ResponseBody
    @RequestMapping("/update")
    public Result updatePermission(Permission permission){
        Result result = new Result();
        try {
            Integer integer = permissionService.repeatPermission(permission);
            if (integer == 1){
                result.setRepeatPermission(false);
                return result;
            }else{
                Integer i = permissionService.updatePermission(permission);
                if (i == 1){
                    result.setSuccess(true);
                }else{
                    result.setSuccess(false);
                }
                return result;
            }

        }catch(Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deletePermission")
    public Result deletePermission(@RequestParam Integer id){
        Result result = new Result();
        Integer integer = permissionService.deletePermission(id);
        if (integer == 1){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/dopermission")
    public String rolePermissionList(){
        return "assignpermission";
    }

    @ResponseBody
    @RequestMapping("/loadpermission")
    public Object rolePermission(@RequestParam Integer roleId){
        List<Permission> permissions = new ArrayList<Permission>();
        List<Permission> list = permissionService.queryAll();
        //当前角色已经分配的权限
        List<Integer> permissionids = permissionService.rolePermissionids(roleId);
        Map<Integer,Permission> permissionMap = new HashMap<Integer, Permission>();
        for (Permission permission : list){
            if (permissionids.contains(permission.getId())){
                permission.setChecked(true);
            }else {
                permission.setChecked(false);
            }
            permissionMap.put(permission.getId(),permission);
        }
        for (Permission permission : list){
            Permission child = permission;
            if (child.getPid() == 0){
                permissions.add(permission);
            }else{
                Permission parent = permissionMap.get(child.getPid());
                parent.getChildren().add(child);
            }
        }
        return permissions;
    }
}
