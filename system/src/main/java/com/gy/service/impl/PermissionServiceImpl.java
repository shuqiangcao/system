package com.gy.service.impl;

import com.gy.dao.PermissionDao;
import com.gy.entity.Permission;
import com.gy.entity.SysUser;
import com.gy.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName PermissionServiceImpl
 * @Description TODO
 * @Author caoshuqiang
 * @Date 2019/11/18 0:30
 */
@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionDao permissionDao;

    @Override
    public Permission queryRootPermission() {
        return permissionDao.queryRootPermission();
    }

    @Override
    public List<Permission> queryChildPermissions(Integer id) {
        return permissionDao.queryChildPermissions(id);
    }

    @Override
    public List<Permission> queryAll() {
        return permissionDao.queryAllPermission();
    }

    @Override
    public Integer repeatPermission(Permission permission) {
        return permissionDao.findPerBynameandurl(permission);
    }

    @Override
    public Integer savePermission(Permission permission) {
        return permissionDao.savePermission(permission);
    }

    @Override
    public Permission queryById(Integer id) {
        return permissionDao.findById(id);
    }

    @Override
    public Integer updatePermission(Permission permission) {
        return permissionDao.updatePermission(permission);
    }

    @Override
    public Integer deletePermission(Integer id) {
        return permissionDao.deletePermission(id);
    }

    @Override
    public List<Integer> rolePermissionids(Integer roleId) {
        return permissionDao.findRolePermissionids(roleId);
    }

    @Override
    public List<Permission> queryPermissionsByUser(SysUser sysUser) {
        return permissionDao.findPermissionsByUser(sysUser);
    }
}
