package com.gy.dao;

import com.gy.entity.SysUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @ClassName SmsUserDao
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/12 17:04
 **/
public interface SmsUserDao {
    //查询用户总数，计算总页码
    public int findUserCount();

    //查询所有用户信息
    public List<SysUser> findAllUser(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

    //新增用户
    public int saveUser(SysUser sysUser);

    //id查询用户(修改用户信息跳转修改页面展示数据)
    public SysUser findUserById(Integer userId);

    public int updateSysUser(SysUser sysUser);
    //删除用户
    public int deleteSysUser(Integer userId);
    //删除已删除用户的角色记录
    public int deleteUserRole(Integer userId);

    //新增用户查询用户是否已存在
    public int findByUsername(String userName);

    //增加用户角色关系表数据
    public void insertUserRoles(Map<String,Object> map);

    //删除关系表数据
    public void deleteUserRoles(Map<String,Object> map);

    public List<Integer> findRoleIdsByUserId(Integer userId);

}
