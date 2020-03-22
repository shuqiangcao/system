package com.gy.entity;

import jdk.nashorn.internal.objects.annotations.Constructor;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @ClassName SmsCp
 * @Description TODO
 * @Author caoshuqiang
 * @Date 2019/12/8 20:49
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SmsCp {
    private Integer id;
    private String account;
    private String name;
    private String passWord;
    private BigDecimal balance;
    private String url;
    private Integer connections;
    private String srcId;
    private Integer weight;
    private Integer flowRate;
    private String accessMode;
    private String whiteList;
    private Date operateTime;
}
