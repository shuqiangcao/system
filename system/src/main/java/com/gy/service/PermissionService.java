package com.gy.service;

import com.gy.entity.Permission;
import com.gy.entity.SysUser;

import java.util.List;

/**
 * @ClassName PermissionService
 * @Description TODO
 * @Author caoshuqiang
 * @Date 2019/11/18 0:29
 */
public interface PermissionService {
    public Permission queryRootPermission();

    public List<Permission> queryChildPermissions(Integer id);

    public List<Permission> queryAll();

    public Integer repeatPermission(Permission permission);

    public Integer savePermission(Permission permission);

    public Permission queryById(Integer id);

    public Integer updatePermission(Permission permission);

    public Integer deletePermission(Integer id);

    public List<Integer> rolePermissionids(Integer roleId);

    public List<Permission> queryPermissionsByUser(SysUser sysUser);
}
