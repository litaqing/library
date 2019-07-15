<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<script type="text/javascript" src="statics/js/jquery-3.3.1.js"></script>

<script type="text/javascript">

    function userLogin(){
        $.ajax({
            type : "post",
            url : "login",
            dataType:"json",
            data:{
                username:$("#username").val(),
                password:$("#password").val()
            },
            success : function(data) {
                if(data.code == "0"){
                    window.location.href = "index.jsp";
                }else {
                    alert(data.errorInfo+"");
                    $("#showMessage").val(data.errorInfo+"");
                }
            }
        });
    }
</script>
<body>

用户名：<input type="text" name="username" id="username"/><br/>
密  码：<input type="password" name="password" id="password"/><br/>
<input type="button" name="login" value="登录" onclick="userLogin()"/><br/>
<textarea id="showMessage" style="border: none;"></textarea>
</body>
</html>