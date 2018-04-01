<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.cookie.js"></script>
<script type="text/javascript">
	//获取浏览器中的cookie
	var token = $.cookie("SHOP_USER_TOKEN");
	//alert(token);

	$(function() {

		//跨域请求数据
		$.ajax({
			async : false,
			url : "http://localhost:8081/shop-rest/rest/findCategoryList",
			type : "GET",
			dataType : 'jsonp',
			//jsonp的值自定义,如果使用jsoncallback,那么服务器端,要返回一个jsoncallback的值对应的对象. 
			jsonp : 'jsoncallback',
			//要传递的参数,没有传参时，也一定要写上 
			data : null,
			timeout : 5000,
			//返回Json类型 
			contentType : "application/json;utf-8",
			//服务器段返回的对象包含name,data属性. 
			success : function(result) {

				//集合
				var $cateUl = $("#category_ul");
				$.each(result, function(index, cate) {

					$(
							"<li><a href='${pageContext.request.contextPath}/findProductByCid?cid="
									+ cate.cid + "'>" + cate.cname
									+ "</a></li>").appendTo($cateUl);

				})

				//alert(result);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});

		getUserInfo();

	})

	//根据token获取用户信息
	function getUserInfo() {

		//跨域请求数据
		$.ajax({
			async : false,
			url : "http://localhost:8085/shop-sso/sso/user/token/" + token,
			type : "GET",
			dataType : 'jsonp',
			//jsonp的值自定义,如果使用jsoncallback,那么服务器端,要返回一个jsoncallback的值对应的对象. 
			jsonp : 'callback',
			//要传递的参数,没有传参时，也一定要写上 
			data : null,
			timeout : 5000,
			//返回Json类型 
			contentType : "application/json;utf-8",
			//服务器段返回的对象包含name,data属性. 
			success : function(result) {

				if (result.status == 200) {
					//成功
					var $ul = $("#list_userinfo");

					$ul.empty();//清空之前的
					var userInfo = result.data;

					var $li = $("<li>欢迎:" + userInfo.username + "</li>");
					var $li2 = $("<li><a href='#'>退出登录</a></li>");
					var $li3 = $("<li><a href='cart.jsp'>购物车</a></li>");

					$ul.append($li).append($li2);
				}

			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});

	}
</script>

<div class="container-fluid">

	<!--
            	时间：2015-12-30
            	描述：菜单栏
            -->
	<div class="container-fluid">
		<div class="col-md-4">
			<img src="${pageContext.request.contextPath}/img/logo2.png" />
		</div>
		<div class="col-md-5">
			<img src="${pageContext.request.contextPath}/img/header.png" />
		</div>
		<div class="col-md-3" style="padding-top: 20px">
			<ol class="list-inline" id="list_userinfo">
				<li><a href="http://localhost:8085/shop-sso/sso/page/login">登录</a></li>
				<li><a href="http://localhost:8085/shop-sso/sso/page/register">注册</a></li>
				<li><a href="cart.jsp">购物车</a></li>
			</ol>
		</div>
	</div>
	<!--
            	时间：2015-12-30
            	描述：导航条
            -->
	<div class="container-fluid">
		<nav class="navbar navbar-inverse">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
						aria-expanded="false">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">首页</a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav" id="category_ul">
						<!-- 						<li class="active"><a href="product_list.jsp">手机数码<span -->
						<!-- 								class="sr-only">(current)</span></a></li> -->
						<!-- 						<li><a href="#">电脑办公</a></li> -->
						<!-- 						<li><a href="#">电脑办公</a></li> -->
						<!-- 						<li><a href="#">电脑办公</a></li> -->
					</ul>
					<form class="navbar-form navbar-right" role="search"
						action="${pageContext.request.contextPath}/searchProductIteam">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Search"
								name="keyWords">
						</div>
						<button type="submit" class="btn btn-default">Submit</button>
					</form>

				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>
	</div>