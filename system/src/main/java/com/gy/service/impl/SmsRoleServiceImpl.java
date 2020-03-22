package com.gy.service.impl;

import com.gy.dao.SmsRoleDao;
import com.gy.entity.SysRole;
import com.gy.service.SmsRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName SmsRoleServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/14 17:34
 **/
@Service
public class SmsRoleServiceImpl implements SmsRoleService {

    @Autowired
    private SmsRoleDao smsRoleDao;

    @Override
    public int roleNum() {
        int roleCount = smsRoleDao.findRoleCount();
        return roleCount;
    }

    @Override
    public List<SysRole> allRole(Integer pageNum, Integer pageSize) {
        List<SysRole> allRole = smsRoleDao.findAllRole(pageNum,pageSize);
        return allRole;
    }

    @Override
    public int saveRole(SysRole sysRole) {
        int i = smsRoleDao.saveRole(sysRole);
        return i;
    }

    @Override
    public int findRepeatRole(String roleName) {
        int rolename = smsRoleDao.findByRolename(roleName);
        return rolename;
    }

    @Override
    public SysRole editRole(Integer roleId) {
        SysRole role = smsRoleDao.findRoleById(roleId);
        return role;
    }

    @Override
    public int updateRole(SysRole sysRole) {
        int i = smsRoleDao.updateSysRole(sysRole);
        return i;
    }

    @Override
    public int deleteSysRole(Integer roleId) {
        int i = smsRoleDao.deleteSysRole(roleId);
        return i;
    }

    @Override
    public List<SysRole> assignAllRoles() {
        return smsRoleDao.findAllRoles();
    }

    @Override
    public Integer insertRolePermission(Map<String, Object> map) {
        return smsRoleDao.saveRolePermission(map);
    }

    @Override
    public Integer deleteRolePermission(Integer roleId) {
        return smsRoleDao.deleteRolePermission(roleId);
    }
}
