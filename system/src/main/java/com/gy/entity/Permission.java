package com.gy.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName Permission
 * @Description TODO
 * @Author caoshuqiang
 * @Date 2019/11/18 0:21
 */
@Data
public class Permission {
    private Integer id;
    private String name;
    private String url;
    private Integer pid;
    private String operator;
    private String operateTime;
    private boolean open = true;
    private boolean checked = false;
    private List<Permission> children = new ArrayList<Permission>();
}
