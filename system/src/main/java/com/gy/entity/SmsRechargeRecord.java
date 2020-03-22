package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @ClassName SmsRechargeRecord
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/13 18:39
 **/
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SmsRechargeRecord {
    private Integer id;
    private String account;
    private BigDecimal balance;
    private BigDecimal afterBalance;
    private BigDecimal rechargeMoney;
    private String operator;
    private String name;
    private Date operateTime;
}
