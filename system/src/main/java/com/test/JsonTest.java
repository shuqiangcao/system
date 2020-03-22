package com.test;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

/**
 * @ClassName JsonTest
 * @Description: TODO
 * @Author 曹树强
 * @Date 2019/12/31 10:00
 **/
public class JsonTest {
    public static void main(String[] args) {
        ObjectMapper objectMapper = new ObjectMapper();
        ObjectNode node = objectMapper.createObjectNode();
        node.put("1111","adfadsfa");
        node.put("2222","fdafasf");
        System.out.println(node.toString());
    }
}
