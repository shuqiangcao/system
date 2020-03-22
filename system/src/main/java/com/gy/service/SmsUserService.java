package com.gy.service;

import com.gy.entity.SysUser;

import java.util.List;
import java.util.Map;

/**
 * @ClassName SmsUserService
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/12 17:10
 **/
public interface SmsUserService {

    public int userNum();

    public List<SysUser> allUser(Integer pageNum,Integer pageSize);

    public int saveUser(SysUser sysUser);

    public int findRepeatUser(String userName);

    public SysUser editUser(Integer userId);

    public int updateUser(SysUser user);

    public int deleteSysUser(Integer userId);

    public void insertSysUserRole(Map<String,Object> map);

    public void deleteSysUserRole(Map<String,Object> map);

    public List<Integer> findSysUserRoleids(Integer userId);
}
