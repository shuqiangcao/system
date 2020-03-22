package com.gy.service;

import com.gy.entity.SysRole;

import java.util.List;
import java.util.Map;

/**
 * @ClassName SmsRoleService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/14 17:32
 **/
public interface SmsRoleService {

    public int roleNum();

    public List<SysRole> allRole(Integer pageNum, Integer pageSize);

    public int saveRole(SysRole sysRole);

    public int findRepeatRole(String roleName);

    public SysRole editRole(Integer roleId);

    public int updateRole(SysRole sysRole);

    public int deleteSysRole(Integer roleId);

    public List<SysRole> assignAllRoles();

    public Integer insertRolePermission(Map<String, Object> map);

    public Integer deleteRolePermission(Integer roleId);
}
