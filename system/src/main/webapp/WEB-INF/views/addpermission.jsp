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
            <h3><i class="fa fa-angle-right"></i>权限管理/权限维护</h3>
            <div class="row mt">
                <div class="col-lg-12 col-xs-12">
                    <div class="content-panel">
                        <h4><i class="fa fa-angle-right"></i>新增权限菜单</h4>
                        <section id="unseen">
                            <div class="panel panel-default">
                                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"></div></div>
                                <div class="panel-body">
                                    <form role="form" action="/user/saveuser" method="post">
                                        <div class="form-group">
                                            <label for="exampleInputPassword1">权限名称</label>
                                            <input type="text" class="form-control" id="exampleInputPassword1" placeholder="请输入权限名称">
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputPassword1">链接地址</label>
                                            <input type="text" class="form-control" id="exampleInputPassword2" placeholder="请输入链接地址">
                                        </div>
                                        <button type="button" class="btn btn-success" onclick="addpermission();"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                                        <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i>重置</button>
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
    function addpermission() {
        var permissionName = $("#exampleInputPassword1").val();
        var permissionUrl = $("#exampleInputPassword2").val();
        var loadingIndex = null;
        if(permissionName == ""){
            layer.msg("权限名称不能为空，请输入权限名称", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        if(permissionUrl == ""){
            layer.msg("链接地址不能为空，请输入链接地址", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        //提交表单数据
        $.ajax({
            type:"POST",
            url:"${basePath}/permission/insert",
            data:{"name":permissionName,"url":permissionUrl,"pid":"${param.id}"},
            beforeSend:function () {
                loadingIndex =  layer.msg('处理中...', {icon: 16});
            },
            success:function (result) {
                if (result.success){
                    layer.msg("新增权限成功！", {time:3000, icon:6, shift:2}, function(){});
                    window.setTimeout("window.location.href='${basePath}/permission/permissionlist'",2000);
                }else if(!result.repeatPermission){
                    layer.msg("权限已存在！", {time:2000, icon:5, shift:6}, function(){});
                }else{
                    layer.msg("新增权限失败！", {time:2000, icon:5, shift:6}, function(){});
                }
            }
        });

    }
</script>
</body>
</html>

