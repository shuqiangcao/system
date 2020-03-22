package com.gy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @ClassName SmsCpConsume
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/27 17:25
 **/
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SmsCpConsume {
    private Integer id;
    private String account;
    private BigDecimal balance;
    private BigDecimal beforeBalance;
    private BigDecimal consumeMoney;
    private Date operateTime;
    private BigDecimal sumMoney;
}
