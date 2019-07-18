<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<title>注册</title>

	<script src="https://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
	<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


	<style type="text/css">
		body {
			background: url("../../../bootstrap/img/book.jpg");
		}

		.form {
			background: rgba(255, 255, 255, 0.2);
			width: 400px;
			margin: 150px auto;
		}
	</style>

	<script>
        function back(){
            window.open("toLogin", "_self");
        }

        function register() {

            var userName = $('#user').val();
            var passWord = $('#passWord').val();

            $.ajax({
                type: "post",  //post put get 等等
                url: "../system/register",
                async:false,
                dataType:"json",
                data: {
                    "userName": userName,
                    "passWord": passWord
                },
                success: function (data) {
                    if("success" == data.type){
                        alert(data.msg+"")
                        window.location.href="http://localhost:8080/system/toLogin";

                    } else{
                        alert(data.msg+"");

                    }

                },

            });
        }
	</script>

</head>

<body>
<div class="container">

	<div class="form row">
		<div class="form-horizontal col-md-offset-3" id="login_form">
			<h3 class="form-title">注册</h3>
			<div class="col-md-9">
				<div class="form-group">
					<i class="fa fa-user fa-lg"></i>
					<input class="form-control required" type="text" placeholder="Username" id="user" name="username" autofocus="autofocus" maxlength="20" />
				</div>
				<div class="form-group">
					<i class="fa fa-lock fa-lg"></i>
					<input class="form-control required" type="password" placeholder="passWord" id="passWord" name="passWord" maxlength="8" />
				</div>
				<div class="form-group">
					<label class="checkbox">
						<input type="checkbox" name="remember" value="1"/>记住我
					</label>
				</div>
				<div class="form-group col-md-offset-9">
					<button type="submit" class="btn btn-success pull-right" name="submit" onclick="register()">注册</button>
					<button type="button" class="btn btn-link" onclick="back()">返回</button>
				</div>
			</div>
		</div>
	</div>

</div>
</body>

</html>