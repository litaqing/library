<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>修改图书</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                   <%-- 基于SSM框架的管理系统：简单实现增、删、改、查。--%>
                </h1>
            </div>
        </div>
    </div>

    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                    <small>修改图书</small>
                </h1>
            </div>
        </div>
    </div>

    <form action="" name="userForm">
        <input type="hidden" name="paperId" value="${book.id}"/>
        图书名称：<input type="text" name="paperName" value="${book.name}"/>
        图书数量：<input type="text" name="paperNum" value="${book.num}"/>
        图书详情：<input type="text" name="paperDetail" value="${book.detail }"/>
        <input type="button" value="提交" onclick="updatePaper()"/>
    </form>
    <script type="text/javascript">
        function updatePaper() {
            var form = document.forms[0];
            form.action = "<%=basePath %>book/updateBook";
            form.method = "post";
            form.submit();
        }
    </script>
</div>