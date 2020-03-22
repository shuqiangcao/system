package com.gy.service.impl;

import com.gy.dao.SmsUserDao;
import com.gy.entity.SysUser;
import com.gy.service.SmsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName SmsUserServiceImpl
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/12 17:11
 **/
@Service
public class SmsUserServiceImpl implements SmsUserService {

    @Autowired
    private SmsUserDao smsUserDao;

    @Override
    public int userNum() {
        int userCount = smsUserDao.findUserCount();
        return userCount;
    }

    @Override
    public List<SysUser> allUser(Integer pageNum,Integer pageSize) {
        List<SysUser> allUser = smsUserDao.findAllUser(pageNum, pageSize);
        return allUser;
    }

    @Override
    public int saveUser(SysUser sysUser) {
        int i = smsUserDao.saveUser(sysUser);
        return i;
    }

    @Override
    public int findRepeatUser(String userName) {
        int username = smsUserDao.findByUsername(userName);
        return username;
    }

    @Override
    public SysUser editUser(Integer userId) {
        SysUser user = smsUserDao.findUserById(userId);
        return user;
    }

    @Override
    public int updateUser(SysUser user) {
        int i = smsUserDao.updateSysUser(user);
        return i;
    }

    @Override
    public int deleteSysUser(Integer userId) {
        //删除用户
        int i = smsUserDao.deleteSysUser(userId);
        //删除用户的角色记录
        if (i == 1){
            smsUserDao.deleteUserRole(userId);
        }
        return i;
    }

    @Override
    public void insertSysUserRole(Map<String, Object> map) {
        smsUserDao.insertUserRoles(map);
    }

    @Override
    public void deleteSysUserRole(Map<String, Object> map) {
        smsUserDao.deleteUserRoles(map);
    }

    @Override
    public List<Integer> findSysUserRoleids(Integer userId) {
        return smsUserDao.findRoleIdsByUserId(userId);
    }
}
