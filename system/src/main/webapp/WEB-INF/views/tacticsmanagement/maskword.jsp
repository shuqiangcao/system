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
            <h3><i class="fa fa-angle-right"></i>策略配置/敏感词配置</h3>
            <div class="row mt">
                <div class="col-lg-12 col-xs-12">
                    <div class="content-panel">
                        <section id="no-more-tables">
                            <div class="input-group col-lg-6">
                                <input type="text" class="form-control" placeholder="请输入查询敏感词" id="maskword">
                                <span class="input-group-btn">
                                <button  class="btn btn-warning" onclick="checkmaskword();"><i class="glyphicon glyphicon-search"></i>敏感词查询</button>
                                </span>
                            </div>
                            <br>
                            <button type="button" class="btn btn-primary" onclick="addmaskword();"><i class="glyphicon glyphicon-plus"></i>敏感词添加</button>
                            <hr style="clear:both;">
                            <div class="table-responsive" id="tablemaskword">

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
<div class="modal fade" id="addmaskwordModal" tabindex="-1" role="dialog" aria-labelledby="addmyModalLabel" data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addmyModalLabel">添加敏感词</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="addword">敏感词</label>
                    <input type="text" name="addword" class="form-control" id="addword" placeholder="">
                </div>
            </div>
            <div class="modal-footer">
                <%--data-dismiss="modal"  让按钮有关闭弹窗的作用--%>
                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                <button type="button" id="btn_submit" class="btn btn-primary" onclick="savemaskword();"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>添加</button>
                <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i>重置</button>
            </div>
        </div>
    </div>
</div>

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

    //监听编辑模板模拟框关闭弹窗事件，关闭之后清除弹窗数据
    $('#addmaskwordModal').on('hidden.bs.modal', function (){
        $("#addword").val("");
    });

    function addmaskword() {
        $("#addmaskwordModal").modal();
    }

    function savemaskword() {
        var maskword = $("#addword").val();
        if (maskword == ""){
            layer.msg("敏感词不能为空，请输入敏感词", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        //数据校验通过后关闭弹窗
        $("#addmaskwordModal").modal("hide");
        var loadingIndex = null;
        $.ajax({
            type:"POST",
            url:"${basePath}/policy/savemaskword",
            data:{"maskword":encodeURIComponent(maskword)},
            beforeSend:function () {
                loadingIndex =  layer.msg('处理中...', {icon: 3});
            },
            success:function (result) {
                if (result.success){
                    layer.close(loadingIndex);
                    layer.msg("添加成功！", {time:4000, icon:6, shift:2}, function(){});
                    window.setTimeout("window.location.href='${basePath}/policy/sensitive'",2000);
                }else{
                    layer.msg("添加失败！", {time:4000, icon:5, shift:6}, function(){});
                }
            }
        });
    }

    function checkmaskword() {
        var maskword = $("#maskword").val();
        if (maskword == ""){
            layer.msg("敏感词不能为空，请输入查询敏感词", {time:2000, icon:5, shift:2}, function(){});
            return;
        }
        $.ajax({
            type:"POST",
            url:"${basePath}/policy/checkmaskword",
            data:{"maskword":encodeURIComponent(maskword)},
            success:function (result){
                var dataStr = result.data;
                console.log(dataStr);
                //清空表格数据
                $("#tablemaskword").html("");
                if (dataStr !== null) {
                    //动态生成表格数据
                    $("#tablemaskword").append("<table class='table  table-bordered'>" +
                        "<thead>" +
                        "<tr>" +
                        "<th>敏感词</th>"+
                        "<th>添加时间</th>"+
                        "</tr>"+
                        "</thead>" +
                        "<tbody>" +
                        "<tr>"+
                        "<td data-title='敏感词'>"+dataStr.word+"</td>"+
                        "<td data-title='添加时间'>"+timeStamp(dataStr.operate_time)+"</td>"+
                        "</tr>"+
                        "</tbody>"+
                        "</table>");
                }else{
                    $("#tablemaskword").append("<table class='table  table-bordered'>" +
                        "<thead>" +
                        "<tr>" +
                        "<th>敏感词</th>"+
                        "<th>添加时间</th>"+
                        "</tr>"+
                        "</thead>" +
                        "<tbody>" +
                        "<tr>"+
                        "<td colspan='11' align='right'><ul class='pagination'>未查询到符合条件敏感词！</ul></td>"+
                        "</tr>"+
                        "</tbody>"+
                        "</table>");
                }

            }
        });
    }
    function timeStamp(dateStamp){
        let date = new Date(dateStamp);
        let Y = date.getFullYear() + '-';
        let M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
        let D = (date.getDate() < 10 ? '0' + date.getDate() : date.getDate()) + ' ';
        let H = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
        let Mi = (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':';
        let S = (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds());
        let tempDate = Y + M + D + H + Mi + S;
        console.log("时间戳转换", tempDate)
        return tempDate;
    }
</script>
</body>
</html>

