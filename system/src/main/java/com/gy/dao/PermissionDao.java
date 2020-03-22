package com.gy.dao;

import com.gy.entity.Permission;
import com.gy.entity.SysUser;

import java.util.List;

/**
 * @ClassName PermissionDao
 * @Description TODO
 * @Author caoshuqiang
 * @Date 2019/11/18 0:29
 */
public interface PermissionDao {

    public Permission queryRootPermission();

    public List<Permission> queryChildPermissions(Integer id);

    public List<Permission> queryAllPermission();

    public Integer findPerBynameandurl(Permission permission);

    public Integer savePermission(Permission permission);

    public Permission findById(Integer id);

    public Integer updatePermission(Permission permission);

    public Integer deletePermission(Integer id);

    public List<Integer> findRolePermissionids(Integer roleId);

    public List<Permission> findPermissionsByUser(SysUser sysUser);
}
