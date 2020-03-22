package com.gy.dao;

import com.gy.entity.SysRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @ClassName SmsRoleDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/14 17:25
 **/
public interface SmsRoleDao {

    public int findRoleCount();

    public List<SysRole> findAllRole(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

    //新增用户
    public int saveRole(SysRole sysRole);

    //新增角色查询角色是否已存在
    public int findByRolename(String roleName);

    public SysRole findRoleById(Integer roleId);

    public int updateSysRole(SysRole sysRole);

    public int deleteSysRole(Integer roleId);

    public List<SysRole> findAllRoles();

    public Integer saveRolePermission(Map<String, Object> map);

    public Integer deleteRolePermission(Integer roleId);
}
