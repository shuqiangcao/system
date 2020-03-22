<%--
  Created by IntelliJ IDEA.
  User: 10396
  Date: 2020/1/7
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">

    <!-- Bootstrap core CSS -->
    <link href="${basePath}/assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="${basePath}/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="${basePath}/assets/css/style.css" rel="stylesheet">
    <link href="${basePath}/assets/css/style-responsive.css" rel="stylesheet">
    <style>
        table th{text-align: center;vertical-align: middle;white-space: nowrap;}
        table tbody td{text-align: center;vertical-align: middle;white-space: nowrap;word-wrap: break-word;}
    </style>
</head>

<body>

<section id="container" >
    <!-- **********************************************************************************************************************************************************
    TOP BAR CONTENT & NOTIFICATIONS
    *********************************************************************************************************************************************************** -->
    <!--header start-->
    <header class="header black-bg">
        <div class="sidebar-toggle-box">
            <div class="fa fa-bars tooltips" data-placement="right" ></div>
        </div>
        <!--logo start-->
        <a class="logo"><b>${loginuser.comp}</b></a>
        <!--logo end-->
        <div class="top-menu">
            <ul class="nav pull-right top-menu">
                <li><a class="logout" href="${basePath}/sms/logout">退出系统</a></li>
            </ul>
        </div>
    </header>
    <!--header end-->
    <!-- **********************************************************************************************************************************************************
    MAIN SIDEBAR MENU
    *********************************************************************************************************************************************************** -->
    <!--sidebar start-->
    <aside>
        <div id="sidebar"  class="nav-collapse ">
            <!-- sidebar menu start-->
            <ul class="sidebar-menu" id="nav-accordion">
                <p class="centered"><a href="javascript:;"><img src="${basePath}/assets/img/ui-sam.jpg" class="img-circle" width="60"></a></p>
                <h5 class="centered">${loginuser.userName}</h5>
                <c:forEach items="${rootPermission.children}" var="permission">
                    <c:if test="${empty permission.children}">
                        <li class="mt" >
                            <a href="${basePath}${permission.url}"><i class="fa fa-dashboard"></i>${permission.name}</a>
                        </li>
                    </c:if>
                    <c:if test="${not empty permission.children}">
                        <li class="sub-menu">
                            <a  href="javascript:;"><i class="fa fa-desktop"></i><span>${permission.name}</span></a>
                            <ul class="sub">
                                <c:forEach items="${permission.children}" var="child">
                                    <li>
                                        <a href="${basePath}${child.url}">${child.name}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
            <!-- sidebar menu end-->
        </div>
    </aside>
    <!--sidebar end-->

    <!-- **********************************************************************************************************************************************************
    MAIN CONTENT
    *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <h3><i class="fa fa-angle-right"></i>权限管理/用户维护</h3>
            <div class="row mt">
                <div class="col-lg-12 col-xs-12">
                    <div class="content-panel">
                        <h4><i class="fa fa-angle-right"></i>分配角色</h4>
                        <section id="unseen">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <form id="roleForm" role="form" class="form-inline">
                                        <input type="hidden" name="userId" value="${user.id}">
                                        <div class="form-group">
                                            <label>未分配角色列表</label><br>
                                            <select id="leftList" name="unassignroleids" class="form-control" multiple size="10" style="width:100px;overflow-y:auto;">
                                                <c:forEach items="${unassignRoles}" var="role">
                                                    <option value="${role.id}">${role.roleName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <ul>
                                                <li id="left2right" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                                <br>
                                                <li id="right2left" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                                            </ul>
                                        </div>
                                        <div class="form-group" style="margin-left:40px;">
                                            <label>已分配角色列表</label><br>
                                            <select id="rightList" name="assignroleids" class="form-control" multiple size="10" style="width:100px;overflow-y:auto;">
                                                <c:forEach items="${assignRoles}" var="role">
                                                    <option value="${role.id}">${role.roleName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </section>
                    </div>
                </div><!-- /col-lg-9 END SECTION MIDDLE -->

                <!-- **********************************************************************************************************************************************************
                RIGHT SIDEBAR CONTENT
                *********************************************************************************************************************************************************** -->
            </div><! --/row -->
        </section>
    </section>

    <!--main content end-->
</section>

<!-- js placed at the end of the document so the pages load faster -->
<script src="${basePath}/assets/js/jquery.js"></script>
<script src="${basePath}/assets/js/bootstrap.min.js"></script>
<script class="include" type="text/javascript" src="${basePath}/assets/js/jquery.dcjqaccordion.2.7.js"></script>
<script src="${basePath}/assets/js/jquery.scrollTo.min.js"></script>
<script src="${basePath}/assets/js/jquery.nicescroll.js" type="text/javascript"></script>
<!--common script for all pages-->
<script src="${basePath}/assets/js/common-scripts.js"></script>
<script src="${basePath}/layer/layer.js"></script>
<!--script for this page-->
<script>
    $("#left2right").click(function () {
        var opts = $("#leftList :selected");
        if (opts.length == 0){
            layer.msg("请选择需要分配的角色！", {time:3000, icon:5, shift:6}, function(){});
        }else{
            $.ajax({
                type:"POST",
                url:"${basePath}/user/doAssign",
                data:$("#roleForm").serialize(),
                success:function (result) {
                    if (result.success){
                        $("#rightList").append(opts);
                        layer.msg("分配角色成功！", {time:3000, icon:6, shift:2}, function(){});
                    }else{
                        layer.msg("分配角色失败！", {time:3000, icon:5, shift:6}, function(){});
                    }
                }
            });
        }
    });

    $("#right2left").click(function () {
        var opts = $("#rightList :selected");
        if (opts.length == 0){
            layer.msg("请选择需要取消分配的角色！", {time:3000, icon:5, shift:6}, function(){});
        }else{
            $.ajax({
                type:"POST",
                url:"${basePath}/user/dounAssign",
                data:$("#roleForm").serialize(),
                success:function (result) {
                    if (result.success){
                        $("#leftList").append(opts);
                        layer.msg("取消角色成功！", {time:3000, icon:6, shift:2}, function(){});
                    }else{
                        layer.msg("取消角色失败！", {time:3000, icon:5, shift:6}, function(){});
                    }
                }
            });
        }
    });
</script>
</body>
</html>

