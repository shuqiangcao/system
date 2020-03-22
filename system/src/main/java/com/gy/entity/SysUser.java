package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @ClassName SysUser
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/8 16:38
 **/
@Data
@NoArgsConstructor
@ToString
@AllArgsConstructor
public class SysUser {
    private Integer id;
    private String userName;
    private String passWord;
    private String telePhone;
    private String email;
    private Integer status;
    private String remark;
    private String comp;
    private String operator;
    private String operateTime;
}
