package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @ClassName SysRole
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/14 17:05
 **/
@Data
@NoArgsConstructor
@ToString
@AllArgsConstructor
public class SysRole {
    private Integer id;
    private String roleName;
    private String remark;
    private String operator;
    private String operateTime;
}
