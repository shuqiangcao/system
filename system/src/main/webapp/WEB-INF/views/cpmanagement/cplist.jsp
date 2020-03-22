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
	<script src="${basePath}/assets/js/jquery.js"></script>
	<script src="${basePath}/bootstrap/js/jqpaginator.min.js"></script>
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
			<h3><i class="fa fa-angle-right"></i>渠道管理/渠道信息</h3>
			<div class="row mt">
				<div class="col-lg-12 col-xs-12">
						<h4><i class="fa fa-angle-right"></i>渠道列表</h4>
						<section id="unseen">
							<button type="button" class="btn btn-primary" style="float:left;" onclick="window.location.href='${basePath}/cp/addcp'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
							<br>
							<br>
							<br>
							<div class="table-responsive">
								<table class="table  table-bordered">
									<thead>
									<tr >
										<th width="30">#</th>
										<th width="30"><input type="checkbox"></th>
										<th>渠道名称</th>
										<th>账号</th>
										<th>密码</th>
										<th>余额</th>
										<th>回调地址</th>
										<th>连接数</th>
										<th>码号</th>
										<th>权重</th>
										<th>流量</th>
										<th>白名单</th>
										<th>接入方式</th>
										<th width="10%" colspan="3">操作</th>
									</tr>
									</thead>
									<tbody>
									<c:forEach items="${result.data}" var="item" varStatus="status">
										<tr>
											<td>${status.index + 1}</td>
											<td><input type="checkbox"></td>
											<td>${item.account}</td>
											<td>${item.name}</td>
											<td>${item.passWord}</td>
											<td>${item.balance}</td>
											<td>${item.url}</td>
											<td>${item.connections}</td>
											<td>${item.srcId}</td>
											<td>${item.weight}</td>
											<td>${item.flowRate}</td>
											<td>${item.whiteList}</td>
											<td>${item.accessMode}</td>
											<td>
												<button type="button" class="btn btn-primary btn-xs" onclick="cppay(${item.id});"><i class=" glyphicon glyphicon-usd">充值</i></button>
											</td>
											<td>
												<button type="button" class="btn btn-primary btn-xs" onclick="editcp(${item.id});"><i class=" glyphicon glyphicon-pencil">修改</i></button>
											</td>
											<td>
												<button type="button" class="btn btn-danger btn-xs" onclick="deletecp(${item.id});"><i class=" glyphicon glyphicon-remove">删除</i></button>
											</td>
										</tr>
									</c:forEach>
									</tbody>
									<tfoot>
									<tr >
										<td colspan="16" align="center">
											<ul class="pagination" id="cpcountpage">
												<input type="hidden" value="${result.totalPage}" id="totalpage">
												<input type="hidden" value="${result.pageNum}" id="pagenum">
												<input type="hidden" value="${result.pageSize}" id="pagesize">
												<input type="hidden" value="${result.countNum}" id="countnum">
											</ul>
											<ul id="cpcountpagecount">
											</ul>
											</ul>
										</td>
									</tr>

									</tfoot>
								</table>
							</div>
						</section>

				</div><!-- /col-lg-9 END SECTION MIDDLE -->

				<!-- **********************************************************************************************************************************************************
                RIGHT SIDEBAR CONTENT
                *********************************************************************************************************************************************************** -->
			</div><! --/row -->
		</section>
	</section>
	<!--main content end-->
</section>
<%--充值页面--%>
<div>
	<form id="cppayform">
		<%--data-backdrop="static"  禁止点击空白处关闭弹窗--%>
		<div class="modal fade" id="cppayModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">渠道充值</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="cpname">渠道名称</label>
							<input type="text" name="cpname" class="form-control" id="cpname" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="cpaccount">渠道账号</label>
							<input type="text" name="cpaccount" class="form-control" id="cpaccount" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="cpbalance">渠道余额</label>
							<input type="text" name="cpbalance" class="form-control" id="cpbalance" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="cppaymoney">充值金额</label>
							<input type="text" name="cppaymoney" class="form-control" id="cppaymoney">
						</div>
					</div>
					<div class="modal-footer">
						<%--data-dismiss="modal"  让按钮有关闭弹窗的作用--%>
						<%--data-dismiss="modal"  让按钮有关闭弹窗的作用--%>
						<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
						<button type="button" id="btn_submit" class="btn btn-primary" onclick="savecppay();"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>充值</button>
						<button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i>重置</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- js placed at the end of the document so the pages load faster -->
<script src="${basePath}/assets/js/bootstrap.min.js"></script>
<script class="include" type="text/javascript" src="${basePath}/assets/js/jquery.dcjqaccordion.2.7.js"></script>
<script src="${basePath}/assets/js/jquery.scrollTo.min.js"></script>
<script src="${basePath}/assets/js/jquery.nicescroll.js" type="text/javascript"></script>
<!--common script for all pages-->
<script src="${basePath}/assets/js/common-scripts.js"></script>
<script src="${basePath}/layer/layer.js"></script>
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
	$.jqPaginator('#cpcountpage', {
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
	$("#cpcountpagecount").append("<li><span>共"+pagesum+"页"+countnum+"条记录</span></li>")

	//展示充值模拟框页面
	function cppay(cpId){
		$.ajax({
			type: "POST",
			url:"${basePath}/cp/cpmsg",
			data:{"cpId":cpId},
			success:function (result) {
				if (result.success){
					var dataStr = result.data;
					$("#cpname").val(dataStr.account);
					$("#cpaccount").val(dataStr.name);
					$("#cpbalance").val(dataStr.balance);
				}
			}
		});
		$("#cppayModal").modal();
	}

	function savecppay(){
		var name = $("#cpname").val();
		var account = $("#cpaccount").val();
		var balance = $("#cpbalance").val();
		var money = $("#cppaymoney").val();
		//金额校验
		if(money!= null && money != ""&& money!="0"){
			var exp = /^(([1-9]\d*)|\d)(\.\d{1,2})?$/;
			if (!exp.test(money)){
				layer.msg("输入充值金额格式不正确，请输入正确的金额", {time:2000, icon:5, shift:2}, function(){});
				return;
			}
		}
		$.ajax({
			type: "POST",
			url:"${basePath}/cp/cppay",
			data:{"name":name,"account":account,"balance":balance,"money":money},
			success:function (result) {
				if (result.success){
					layer.msg("充值成功！", {time:3000, icon:6, shift:2}, function(){});
					window.setTimeout("window.location.href='${basePath}/cp/cpmessage'",2000);
				}else{
					layer.msg("充值失败！", {time:3000, icon:6, shift:2}, function(){});
				}
			}
		});
	}

	//监听关闭弹窗事件，关闭之后清除弹窗数据
	$('#cppayModal').on('hidden.bs.modal', function (){
		document.getElementById("cppayform").reset();
	});


	function editcp(cpId) {
		window.location.href = "${basePath}/cp/editcp?cpId="+cpId;
	}
	function deletecp(cpId) {
		layer.confirm("是否确定删除渠道信息?",{icon: 3,title:'提示'},function(cindex){
			$.ajax({
				type:"POST",
				url:"${basePath}/cp/deletecp",
				data:{"cpId":cpId},
				success:function (result) {
					if (result.success){
						layer.msg("删除渠道信息成功！", {time:3000, icon:6, shift:2}, function(){});
						window.setTimeout("window.location.href='${basePath}/cp/cpmessage'",2000);
					}else{
						layer.msg("删除渠道信息失败！", {time:3000, icon:6, shift:2}, function(){});
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
		window.location.href = "${basePath}/cp/cpmessage?pageNum="+pageNum;
	}
</script>
</body>
</html>

