package com.gy.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName BasePathInterceptor
 * @Description TODO
 * @Author caoshuqiang
 * @Date 2019/11/19 23:21
 */
@Slf4j
public class BasePathInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();
        String contextPath = request.getContextPath();
        String basePath = scheme+"://"+serverName+":"+serverPort+contextPath;
        log.info("访问路径:{}",basePath);
        request.setAttribute("basePath",basePath);
        return true;
    }
}
