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
    <link href="${basePath}/assets/css/table-responsive.css" rel="stylesheet">
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
                        <h4><i class="fa fa-angle-right"></i>用户列表</h4>
                        <section id="no-more-tables">
                            <button type="button" class="btn btn-primary" style="float:left;" onclick="window.location.href='${basePath}/user/adduser'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                            <br>
                            <hr style="clear:both;">
                            <table class="table  table-bordered table-striped table-condensed">
                                    <thead>
                                    <tr >
                                        <th>#</th>
                                        <th><input type="checkbox"></th>
                                        <th>账号</th>
                                        <th>手机号码</th>
                                        <th>邮箱地址</th>
                                        <th>状态</th>
                                        <th>公司</th>
                                        <th colspan="3">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${sysUsers}" var="item" varStatus="status">
                                        <tr>
                                            <td data-title="#">${status.index + 1}</td>
                                            <td data-title="选择"><input type="checkbox"></td>
                                            <td data-title="账号">${item.userName}</td>
                                            <td data-title="手机号码">${item.telePhone}</td>
                                            <td data-title="邮箱地址">${item.email}</td>
                                            <c:if test="${item.status == 0}">
                                                <td data-title="状态">正常</td>
                                            </c:if>
                                            <c:if test="${item.status == 1}">
                                                <td data-title="状态">冻结</td>
                                            </c:if>
                                            <td data-title="公司">${item.comp}</td>
                                            <td data-title="操作">
                                                <button type="button" class="btn btn-success btn-xs" onclick="adduserrole(${item.id});"><i class=" glyphicon glyphicon-check">角色</i></button>
                                            </td>
                                            <td data-title="操作">
                                                <button type="button" class="btn btn-primary btn-xs" onclick="edituser(${item.id});"><i class=" glyphicon glyphicon-pencil">修改</i></button>
                                            </td >
                                            <td data-title="操作">
                                                <button type="button" class="btn btn-danger btn-xs" onclick="deleteuser(${item.id});"><i class=" glyphicon glyphicon-remove">删除</i></button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                        <tfoot>
                                        <tr>
                                            <td colspan="10" align="center">
                                                <ul class="pagination">
                                                    <c:if test="${pageNum > 1}">
                                                        <li><a href="#" onclick="changePageNum(${pageNum - 1})">上一页</a></li>
                                                    </c:if>
                                                    <c:if test="${pageNum == 1 && totalPage>0}">
                                                        <li class="disabled"><a href="#">上一页</a></li>
                                                    </c:if>
                                                    <c:forEach begin="1" end="${totalPage}" varStatus="status">
                                                        <c:if test="${pageNum == status.count}">
                                                            <li class="active"><a href="#">${status.count}<span class="sr-only">(current)</span></a></li>
                                                        </c:if>
                                                        <c:if test="${pageNum != status.count}">
                                                            <li><a href="#" onclick="changePageNum(${status.count})">${status.count}</a></li>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${pageNum == totalPage}">
                                                        <li class="disabled"><a href="#">下一页</a></li>
                                                    </c:if>
                                                    <c:if test="${pageNum < totalPage}">
                                                        <li><a href="#" onclick="changePageNum(${pageNum + 1})">下一页</a></li>
                                                    </c:if>
                                                </ul>
                                            </td>
                                        </tr>
                                        </tfoot>
                                </table>
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
    function edituser(userId) {
        window.location.href = "${basePath}/user/edituser?userId="+userId;
    }
    function deleteuser(userId) {
        layer.confirm("是否确定删除用户信息?",{icon: 3,title:'提示'},function(cindex){
            $.ajax({
                type:"GET",
                url:"${basePath}/user/deleteuser",
                data:{"userId":userId},
                success:function (result) {
                    if (result.success){
                        layer.msg("删除用户成功！", {time:3000, icon:6, shift:2}, function(){});
                        window.setTimeout("window.location.href='${basePath}/user/userlist'",2000);
                    }else{
                        layer.msg("删除用户失败！", {time:3000, icon:6, shift:2}, function(){});
                    }
                }
            });
            layer.close(cindex);
        },function (cindex) {
            layer.close(cindex);
        });

    }
    //翻页
    function changePageNum(pageNum){
        window.location.href = "${basePath}/user/userlist?pageNum="+pageNum;
    }
    function adduserrole(userId) {
        window.location.href = "${basePath}/user/addassign?userId="+userId;
    }
</script>
</body>
</html>

