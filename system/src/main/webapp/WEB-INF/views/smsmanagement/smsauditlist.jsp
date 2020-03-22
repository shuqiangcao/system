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
	<link rel="stylesheet" href="${basePath}/datetimepicket/css/bootstrap-datetimepicker.css">
	<link rel="stylesheet" href="${basePath}/bootstrap/css/select-mania.css">
	<link rel="stylesheet" href="${basePath}/bootstrap/css/select-mania-theme-darkblue.css">
	<link rel="stylesheet" href="${basePath}/bootstrap/css/zebra_tooltips.css">
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
			<h3><i class="fa fa-angle-right"></i>短信管理/短信审核</h3>
			<div class="row mt">
				<div class="col-lg-12 col-xs-12">
					<h4><i class="fa fa-angle-right"></i>审核列表</h4>
					<%--<div class="panel-heading">--%>
						<%--<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>短信发送审核列表</h3>--%>
					<%--</div>--%>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-3 col-md-3 col-sm-3 mb">
								<div style="font-size: large">账号</div>
								<%--<input class="form-control has-success" type="text">--%>
								<select class="form-control auditcp" id="auditcp">
									<option value="" selected>全部</option>
									<c:forEach items="${cp}" var="item" varStatus="status">
										<option value="${item.account}">${item.account}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-lg-3 col-md-3 col-sm-3 mb">
								<div style="font-size: large">审核</div>
								<%--<input class="form-control has-success" type="text">--%>
								<select class="form-control" id="isaudit">
									<option value="" selected>全部</option>
									<option value="0">审核</option>
									<option value="1">已审核</option>
								</select>
							</div>
							<div class="col-lg-3 col-md-3 col-sm-3 mb">
								<div style="font-size: large">起始时间</div>
								<%--<input class="form-control has-success" type="text">--%>
								<div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
									<input class="form-control formattime" type="text" value="" placeholder="" id="begintime">
									<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
									<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
								</div>
								<input type="hidden" id="dtp_input2" value="" />
							</div>
							<div class="col-lg-3 col-md-3 col-sm-3 mb">
								<div style="font-size: large">起止时间</div>
								<%--<input class="form-control has-success" type="text">--%>
								<div class="input-group date form_date_1" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input3" data-link-format="yyyy-mm-dd">
									<input class="form-control formattime" type="text" value="" placeholder="" id="endtime">
									<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
									<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
								</div>
								<input type="hidden" id="dtp_input3" value=""/>
							</div>
							<div class="col-lg-3 col-md-3 col-sm-3 mb">
								<button type="button" class="btn btn-warning" onclick="checkaudit(1);"><i class="glyphicon glyphicon-search"></i>查询</button>
							</div>
						</div>
					</div>
				</div><!-- /col-lg-9 END SECTION MIDDLE -->
				<div class="table-responsive">
					<table class="table  table-bordered">
						<thead>
						<tr>
							<th width="30">#</th>
							<th width="30"><input type="checkbox"></th>
							<th>ID</th>
							<th>账号</th>
							<th>模板id</th>
							<th>通道</th>
							<th>价格</th>
							<th>号码数</th>
							<th>发送时间</th>
							<th colspan="3">操作</th>
						</tr>
						</thead>
						<tbody class="auditmsg">
						<c:forEach items="${result.data}" var="item" varStatus="status">
							<tr class="audit_tr">
								<td>${status.index+1}</td>
								<td><input type="checkbox"></td>
								<td>${item.id}</td>
								<td>${item.cp}</td>
								<td>${item.templateId}</td>
								<td>${item.channel}</td>
								<td>${item.price}</td>
								<td>${item.mobileCount}</td>
								<td>${item.sendTime}</td>
									<%--<td><fmt:formatDate value="${item.operateTime}" pattern="yyyy-MM-dd HH:dd:ss"/></td>--%>
									<%--<td>--%>
									<%--<button type="button" class="btn btn-primary btn-xs" onclick="editsign(${item.id});" data-toggle="modal" data-target="#myModaledit"><i class=" glyphicon glyphicon-pencil">编辑</i></button>--%>
									<%--</td>--%>
								<c:if test="${item.status == 0}">
									<td>
										<button type="button" class="btn btn-danger btn-xs" onclick="doaudit(${item.id});"><i class=" glyphicon glyphicon-pencil">审核</i></button>
									</td>
									<td>
										<button type="button" class="btn btn-danger btn-xs" onclick="deleteaudit(${item.id});"><i class=" glyphicon glyphicon-remove">驳回</i></button>
									</td>
								</c:if>
								<c:if test="${item.status == 1}">
									<td>
										<button type="button" class="btn btn-danger btn-xs" disabled="disabled"><i class=" glyphicon glyphicon-pencil">已审核</i></button>
									</td>
									<td>
										<button type="button" class="btn btn-danger btn-xs" disabled="disabled"><i class=" glyphicon glyphicon-remove">驳回</i></button>
									</td>
								</c:if>
								<td>
									<button type="button" class="btn btn-success btn-xs" onclick="showmobile(${item.id});">查看号码</button>
								</td>
							</tr>
						</c:forEach>
						</tbody>
						<tfoot class="auditfoot">
						<tr >
							<td colspan="12" align="center">
								<ul class="pagination" id="auditpagefoot">
									<input type="hidden" value="${result.totalPage}" id="totalpage">
									<input type="hidden" value="${result.pageNum}" id="pagenum">
									<input type="hidden" value="${result.pageSize}" id="pagesize">
									<input type="hidden" value="${result.countNum}" id="countnum">
								</ul>
								<ul id="auditpagecount">
								</ul>
							</td>
						</tr>
						</tfoot>
					</table>
				</div>

				<!-- **********************************************************************************************************************************************************
                RIGHT SIDEBAR CONTENT
                *********************************************************************************************************************************************************** -->
			</div><! --/row -->
		</section>
	</section>
	<!--main content end-->
</section>
<%--发送号码展示页面--%>
<div>
	<form id="mobileform">
		<%--data-backdrop="static"  禁止点击空白处关闭弹窗--%>
		<div class="modal fade" id="mobileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
			<div class="modal-dialog" style="width:1000px">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">发送号码</h4>
					</div>
					<div class="modal-body" style="height: 700px;">

						<textarea class="form-control" id="allmobile" style="min-width: 700px;min-height: 650px"></textarea>

					</div>
					<div class="modal-footer">
						<%--data-dismiss="modal"  让按钮有关闭弹窗的作用--%>
						<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
					</div>
				</div>
			</div>
		</div>
	</form>
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
<script src="${basePath}/datetimepicket/js/bootstrap-datetimepicker.js"></script>
<script src="${basePath}/datetimepicket/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${basePath}/bootstrap/js/select-mania.js"></script>
<script src="${basePath}/bootstrap/js/zebra_tooltips.min.js"></script>
<script src="${basePath}/bootstrap/js/jqpaginator.min.js"></script>
<!--script for this page-->
<script>
	//使用插件分页
	var pagesum = $("#totalpage").val();
	var pageindex = $("#pagenum").val();
	var pagesize = $("#pagesize").val();
	var countnum = $("#countnum").val();
	if (pagesum == 0 && countnum == 0){
		pagesum = 1;
	}
	$.jqPaginator('#auditpagefoot', {
		totalPages: parseInt(pagesum),
		visiblePages: parseInt(pagesize),
		currentPage: parseInt(pageindex),
		first: '<li class="first"><a href="javascript:void(0);">首页</a></li>',
		prev: '<li class="prev"><a href="javascript:;">上一页</a></li>',
		next: '<li class="next"><a href="javascript:void(0);">下一页</a></li>',
		last: '<li class="last"><a href="javascript:void(0);">尾页</a></li>',
		page: '<li class="page"><a href="javascript:;">{{page}}</a></li>',
		onPageChange: function (num, type) {
			if (type == "change"){
				changePageNum(num);
			}
		}
	});
	$("#auditpagecount").append("<li><span>共"+pagesum+"页"+countnum+"条记录</span></li>")

	//展示号码模拟框
	function showmobile(id){
		$.ajax({
			type:"GET",
			url:"${basePath}/send/showmobile",
			data:{"id":id},
			success:function(result){
				$("#allmobile").val(result.data);
			}
		});
		$("#mobileModal").modal();
	}

	//监听关闭弹窗事件，关闭之后清除弹窗数据
	$('#mobileModal').on('hidden.bs.modal', function (){
		document.getElementById("mobileform").reset();
	});

	$('.form_date').datetimepicker({
		language: 'zh-CN',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
	});
	$('.form_date_1').datetimepicker({
		language: 'zh-CN',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
	});
	$('.form_date').datetimepicker("setDate", new Date());
	$('.form_date_1').datetimepicker("setDate", new Date());

	//翻页
	function changePageNum(pageNum){
		window.location.href = "${basePath}/send/smsaudit?pageNum="+pageNum;
	}

	//条件查询数据
	function checkaudit(pageNum) {
		var loadingIndex = null;
		var auditstatu = $("#isaudit").val();
		var cp = $("#auditcp").val();
		var begintime = $("#begintime").val();
		var endtime = $("#endtime").val();

		if(begintime == ""){
			layer.msg("起始不能为空，请选择起始时间", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(endtime == ""){
			layer.msg("起止不能为空，请选择起止时间", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		$.ajax({
			type:"GET",
			url:"${basePath}/send/checkaudit",
			data:{"cp":encodeURIComponent(cp),"begintime":begintime,"endtime":endtime,"pageNum":pageNum,"status":auditstatu},
			beforeSend:function () {
				loadingIndex =  layer.msg('查询中...', {time:10000, icon:16, shift:10});
			},
			success:function (result) {
				layer.close(loadingIndex);
				//清空表格数据
				$(".auditmsg").empty();
				$(".auditfoot").empty();
				//总页码
				var totalPage = result.totalPage;
				//当前页码
				var pageNum = result.pageNum;
				var pageSize = result.pageSize;
				var countNum = result.countNum;
				if (totalPage == 0 && countNum == 0){
					totalPage = 1;
				}
				//数据
				var dataStr = result.data;
				//动态生成表格数据
				for (var i = 0; i < dataStr.length ; i++) {
					var btnmsg = dataStr[i].status;
					if (btnmsg == 0){
						$(".auditmsg").append("<tr class='audit_tr'>" +
								"<td>"+(i+1)+"</td>" +
								"<td><input type='checkbox' ></td>" +
								"<td>"+dataStr[i].id+"</td>" +
								"<td>"+dataStr[i].cp+"</td>" +
								"<td>"+dataStr[i].templateId+"</td>" +
								"<td>"+dataStr[i].channel+"</td>" +
								"<td>"+dataStr[i].price+"</td>" +
								"<td>"+dataStr[i].mobileCount+"</td>" +
								"<td>"+dataStr[i].sendTime+"</td>" +
								"<td><button type='button' class='btn btn-danger btn-xs' onclick='doaudit("+dataStr[i].id+");'><i class=' glyphicon glyphicon-pencil'>审核</i></button></td>" +
								"<td><button type='button' class='btn btn-danger btn-xs' onclick='deleteaudit("+dataStr[i].id+");'><i class=' glyphicon glyphicon-remove'>驳回</i></button></td>" +
								"<td><button type='button' class='btn btn-success btn-xs' onclick='showmobile("+dataStr[i].id+")'>查看号码</button></td>" +
								"</tr>");
					}else if (btnmsg == 1) {
						$(".auditmsg").append("<tr class='audit_tr'>" +
								"<td>"+(i+1)+"</td>" +
								"<td><input type='checkbox' ></td>" +
								"<td>"+dataStr[i].id+"</td>" +
								"<td>"+dataStr[i].cp+"</td>" +
								"<td>"+dataStr[i].templateId+"</td>" +
								"<td>"+dataStr[i].channel+"</td>" +
								"<td>"+dataStr[i].price+"</td>" +
								"<td>"+dataStr[i].mobileCount+"</td>" +
								"<td>"+dataStr[i].sendTime+"</td>" +
								"<td><button type='button' class='btn btn-danger btn-xs' disabled='disabled'><i class=' glyphicon glyphicon-pencil'>已审核</i></button></td>" +
								"<td><button type='button' class='btn btn-danger btn-xs' disabled='disabled'><i class=' glyphicon glyphicon-remove'>驳回</i></button></td>" +
								"<td><button type='button' class='btn btn-success btn-xs' onclick='showmobile("+dataStr[i].id+")'>查看号码</button></td>" +
								"</tr>");
					}
				}
				$(".auditfoot").append("<tr><td colspan='12' align='center'><ul class='pagination' id='auditpagefoot'></ul><ul id='auditpagecount'></ul></td></tr>");
				//使用插件分页
				$.jqPaginator('#auditpagefoot', {
					totalPages: totalPage,
					visiblePages: pageSize,
					currentPage: pageNum,
					first: '<li class="first"><a href="javascript:void(0);">首页</a></li>',
					prev: '<li class="prev"><a href="javascript:;">上一页</a></li>',
					next: '<li class="next"><a href="javascript:void(0);">下一页</a></li>',
					last: '<li class="last"><a href="javascript:void(0);">尾页</a></li>',
					page: '<li class="page"><a href="javascript:;">{{page}}</a></li>',
					onPageChange: function (num, type) {
						if (type == "change"){
							checkaudit(num);
						}
					}
				});
				$("#auditpagecount").append("<span>共"+totalPage+"页"+countNum+"条记录</span>")
			}
		});
	}

	function doaudit(id) {
		var loadingIndex = null;
		layer.confirm("是否确定审核信息?",{icon: 3,title:'提示'},function(cindex){
			var bt = $("#btnaudit").text("审核");
			$.ajax({
				type:"GET",
				url:"${basePath}/send/isaudit",
				data:{"id":id},
				beforeSend:function () {
					loadingIndex =  layer.msg('审核中...', {time:600000, icon:16, shift:10});
				},
				success:function (result) {
					layer.close(loadingIndex);
					if (result.success){
						layer.msg("审核成功！", {time:3000, icon:6, shift:2}, function(){});
						window.setTimeout("window.location.href='${basePath}/send/smsaudit'",2000);
					}else if(result.repeatSubmit){
						layer.msg("审核失败,此批次号码已成功提交,忽重复提交！", {time:3000, icon:6, shift:2}, function(){});
						window.setTimeout("window.location.href='${basePath}/send/smsaudit'",2000);
					}else{
						layer.msg("审核失败！", {time:3000, icon:6, shift:2}, function(){});
					}
				}
			});
			layer.close(cindex);
		},function (cindex) {
			layer.close(cindex);
		});

	}

	function deleteaudit(id) {
		var loadingIndex = null;
		$.ajax({
			type:"GET",
			url:"${basePath}/send/deleteaudit",
			data:{"id":id},
			beforeSend:function () {
				loadingIndex =  layer.msg('驳回中...', {time:10000, icon:16, shift:10});
			},
			success:function(result){
				layer.close(loadingIndex);
				if (result.success){
					layer.msg("驳回成功！", {time:5000, icon:6, shift:2}, function(){});
					window.setTimeout("window.location.href='${basePath}/send/smsaudit'",2000);
				}else{
					layer.msg("驳回失败！", {time:5000, icon:6, shift:2}, function(){});
				}
			}
		});
	}
</script>
</body>
</html>

