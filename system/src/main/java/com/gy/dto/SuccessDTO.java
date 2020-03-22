package com.gy.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @ClassName SuccessDTO
 * @Description: TODO
 * @Author 曹树强
 * @Date 2020/2/18 13:37
 **/
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class SuccessDTO {
    private String dateStr;
    private Integer succNum;
}
