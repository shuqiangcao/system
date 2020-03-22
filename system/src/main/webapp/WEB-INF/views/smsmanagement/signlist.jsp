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
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			<h3><i class="fa fa-angle-right"></i>短信管理/短信签名</h3>
			<div class="row mt">
				<div>
					<h4><i class="fa fa-angle-right"></i>签名列表</h4>
					<section id="unseen">
						<button type="button" class="btn btn-primary" style="float:left;" onclick="addsign();"><i class="glyphicon glyphicon-plus"></i> 新增</button>
						<br>
						<br>
						<br>
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
								<tr >
									<th width="30">#</th>
									<th width="30"><input type="checkbox"></th>
									<th>ID</th>
									<th>签名id</th>
									<th>签名</th>
									<th>渠道</th>
									<th>通道</th>
									<th>创建时间</th>
									<th width="10%" colspan="2">操作</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${result.data}" var="item" varStatus="status">
									<tr>
										<td>${status.index+1}</td>
										<td><input type="checkbox"></td>
										<td>${item.id}</td>
										<td>${item.signId}</td>
										<td>${item.signName}</td>
										<td>${item.cp}</td>
										<td>${item.channel}</td>
										<td><fmt:formatDate value="${item.operateTime}" type="both"/></td>
										<td>
											<button type="button" class="btn btn-primary btn-xs" onclick="editsign(${item.id});" data-toggle="modal" data-target="#myModaledit"><i class=" glyphicon glyphicon-pencil">编辑</i></button>
										</td>
										<td>
											<button type="button" class="btn btn-danger btn-xs" onclick="deletesign(${item.id});"><i class=" glyphicon glyphicon-remove">删除</i></button>
										</td>
									</tr>
								</c:forEach>
								</tbody>
								<tfoot>
								<tr >
									<td colspan="10" align="center">
										<ul class="pagination" id="signcountpage">
											<input type="hidden" value="${result.totalPage}" id="totalpage">
											<input type="hidden" value="${result.pageNum}" id="pagenum">
											<input type="hidden" value="${result.pageSize}" id="pagesize">
											<input type="hidden" value="${result.countNum}" id="countnum">
										</ul>
										<ul id="signcountpagecount">
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
<form id="form" action="${basePath}/sign/savesign" method="post">
	<%--data-backdrop="static"  禁止点击空白处关闭弹窗--%>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="addmyModalLabel">新增签名</h4>
				</div>
				<div class="modal-body">

					<div class="form-group">
						<label for="signid">签名id</label>
						<input type="text" name="signid" class="form-control" id="signid" placeholder="签名id">
					</div>
					<div class="form-group">
						<label for="signname">签名</label>
						<input type="text" name="signname" class="form-control" id="signname" placeholder="签名">
					</div>
					<div class="form-group">
						<label for="cp">渠道</label>
						<input type="text" name="cp" class="form-control" id="cp" placeholder="渠道">
					</div>
					<div class="form-group">
						<label for="channel">通道</label>
						<input type="text" name="channel" class="form-control" id="channel" placeholder="通道">
					</div>
				</div>
				<div class="modal-footer">
					<%--data-dismiss="modal"  让按钮有关闭弹窗的作用--%>
					<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
					<button type="button" id="btn_submit" class="btn btn-primary" onclick="savesign();"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存</button>
					<button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i>重置</button>
				</div>
			</div>
		</div>
	</div>
</form>
<form id="form1" action="${basePath}/sign/savesign" method="post">
	<input type="hidden" id="inputid">
	<%--data-backdrop="static"  禁止点击空白处关闭弹窗--%>
	<div class="modal fade" id="myModaledit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">编辑签名</h4>
				</div>
				<div class="modal-body">

					<div class="form-group">
						<label for="signid1">签名id</label>
						<input type="text" name="signid1" class="form-control" id="signid1" placeholder="签名id">
					</div>
					<div class="form-group">
						<label for="signname1">签名</label>
						<input type="text" name="signname1" class="form-control" id="signname1" placeholder="签名">
					</div>
					<div class="form-group">
						<label for="cp1">渠道</label>
						<input type="text" name="cp1" class="form-control" id="cp1" placeholder="渠道">
					</div>
					<div class="form-group">
						<label for="channel1">通道</label>
						<input type="text" name="channel1" class="form-control" id="channel1" placeholder="通道">
					</div>
				</div>
				<div class="modal-footer">
					<%--data-dismiss="modal"  让按钮有关闭弹窗的作用--%>
					<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
					<button type="button" id="btn_submit" class="btn btn-primary" onclick="saveeditsign();"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存</button>
					<button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i>重置</button>
				</div>
			</div>
		</div>
	</div>
</form>

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
	$.jqPaginator('#signcountpage', {
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
	$("#signcountpagecount").append("<li><span>共"+pagesum+"页"+countnum+"条记录</span></li>")

	function deletesign(signId) {
		layer.confirm("是否确定删除签名信息?",{icon: 3,title:'提示'},function(cindex){
			$.ajax({
				type:"GET",
				url:"${basePath}/sign/deletesign",
				data:{"signId":signId},
				success:function (result) {
					if (result.success){
						layer.msg("删除签名成功！", {time:3000, icon:6, shift:2}, function(){});
						window.setTimeout("window.location.href='${basePath}/sign/signlist'",2000);
					}else{
						layer.msg("删除签名失败！", {time:3000, icon:6, shift:2}, function(){});
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
		window.location.href = "${basePath}/sign/signlist?pageNum="+pageNum;
	}
	//弹出新增页面
	function addsign() {
		//id:myModal 在addsign.jsp页面
		$("#myModal").modal();
	}
	//弹出编辑页面
	var loadingIndex = null;
	function editsign(signId) {
		$.ajax({
			type:"GET",
			url:"${basePath}/sign/editsign",
			data:{"signId":signId},
			dataType:"json",
			beforeSend:function () {
				loadingIndex =  layer.msg('处理中...', {icon: 16});
			},
			success:function (result) {
				layer.close(loadingIndex);
				if (result.success){
					//JSON.parse()里的参数只能是string类型,返回的本就是json不用在转化
					var dataStr = result.data;
					$("#signid1").attr("value",dataStr.signId);
					$("#signname1").attr("value",dataStr.signName);
					$("#cp1").attr("value",dataStr.cp);
					$("#channel1").attr("value",dataStr.channel);
					$("#inputid").attr("value",dataStr.id);
				}
			}
		});
	}

	//监听关闭弹窗事件，关闭之后清除弹窗数据
	$('#myModal').on('hidden.bs.modal', function (){
		document.getElementById("form").reset();
	});

	//监听关闭弹窗事件，关闭之后清除弹窗数据
	$('#myModal').on('hidden.bs.modal', function (){
		document.getElementById("form").reset();
	});

	function savesign() {
		var signId = $("#signid").val();
		var signName = $("#signname").val();
		var cp = $("#cp").val();
		var channel = $("#channel").val();
		if(signId == ""){
			layer.msg("签名id不能为空，请输入签名id", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(signName == ""){
			layer.msg("签名不能为空，请输入签名", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(cp == ""){
			layer.msg("渠道名称不能为空，请输入渠道名称", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(channel == ""){
			layer.msg("通道名称不能为空，请输入通道名称", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		//数据校验通过后关闭弹窗
		$("#myModal").modal("hide");

		var loadingIndex = null;
		$.ajax({
			type:"POST",
			url:"${basePath}/sign/savesign",
			data:JSON.stringify({"signId":signId,"signName":signName,"cp":cp,"channel":channel}),
			contentType:"application/json;charset=UTF-8",
			beforeSend:function () {
				loadingIndex =  layer.msg('处理中...', {icon: 16});
			},
			success:function (result) {
				layer.close(loadingIndex);
				if (result.success){
					layer.close(loadingIndex);
					layer.msg("新增签名成功！", {time:3000, icon:6, shift:2}, function(){});
					window.setTimeout("window.location.href='${basePath}/sign/signlist'",2000);
				}else if(!result.repeatSign){
					layer.msg("签名已存在！", {time:2000, icon:5, shift:6}, function(){});
				}else{
					layer.msg("新增签名失败！", {time:2000, icon:5, shift:6}, function(){});
				}
			}
		});
	}

	//监听关闭弹窗事件，关闭之后清除弹窗数据
	$('#myModaledit').on('hidden.bs.modal', function (){
		document.getElementById("form1").reset();
	});

	function saveeditsign() {
		var signId = $("#signid1").val();
		var signName = $("#signname1").val();
		var cp = $("#cp1").val();
		var channel = $("#channel1").val();
		var sign_id = $("#inputid").val();
		if(signId == ""){
			layer.msg("签名id不能为空，请输入签名id", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(signName == ""){
			layer.msg("签名不能为空，请输入签名", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(cp == ""){
			layer.msg("渠道名称不能为空，请输入渠道名称", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		if(channel == ""){
			layer.msg("通道名称不能为空，请输入通道名称", {time:2000, icon:5, shift:2}, function(){});
			return;
		}
		//数据校验通过后关闭弹窗
		$("#myModaledit").modal("hide");

		var loadingIndex = null;
		$.ajax({
			type:"POST",
			url:"${basePath}/sign/saveeditsign",
			data:JSON.stringify({"signId":signId,"signName":signName,"cp":cp,"channel":channel,"id":sign_id}),
			contentType:"application/json;charset=UTF-8",
			beforeSend:function () {
				loadingIndex =  layer.msg('处理中...', {icon: 16});
			},
			success:function (result) {
				layer.close(loadingIndex);
				if (result.success){
					layer.msg("编辑签名成功！", {time:3000, icon:6, shift:2}, function(){});
					window.setTimeout("window.location.href='${basePath}/sign/signlist'",2000);
				}else{
					layer.msg("编辑签名失败！", {time:2000, icon:5, shift:6}, function(){});
				}
			}
		});
	}
</script>
</body>
</html>

