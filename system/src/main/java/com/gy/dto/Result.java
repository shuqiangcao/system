package com.gy.dto;

import lombok.Data;
import lombok.ToString;

/**
 * @ClassName Result
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/11/11 14:30
 **/
@Data
@ToString
public class Result {
    private boolean success;
    private boolean repeatUser;
    private boolean repeatPermission;
    private boolean repeatsign;
    private boolean repeatCp;
    private boolean repeatChannel;
    private boolean repeatSubmit;
    private Object data;
    private Integer pageNum;
    private Integer pageSize;
    private Integer totalPage;
    private Integer countNum;
}
