<!doctype html>
<html xmlns:th="http://www.thymeleaf.org">

<head>
  <title>index</title>
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
  <!--
	<link rel="stylesheet" type="text/css" href="styles.css">
  -->
  <script src="../static/assets/js/jquery.min.js"></script>
  <script src="../static/assets/js/amazeui.min.js"></script>
  <script src="../static/assets/js/iscroll.js"></script>
  <script src="../static/assets/js/app.js"></script>
  <title>首页</title>
</head>

<body>
  <a href="/usr/login">登录</a>
  <form id="signin" name="signin">
    <fieldset>
      <p>用户名：<input type="text" id="uname" name="uname"></p>
      <p>账号：<input type="text" id="account" name="account"></p>
      <p>密码：<input type="password" id="passwd" name="passwd"></p>
      <p><button type="button" id="signin_sub">注册</button></p>
    </fieldset>
  </form>
</body>
<script>
  $('#signin_sub').on("click", function () {
    var formObject = {};
    var formArray = $("#signin").serializeArray();
    $.each(formArray, function (i, item) {
      formObject[item.name] = item.value;
    });
    console.log(formObject);
    $.ajax({
      url: "/user/signin.action",
      type: "post",
      contentType: "application/json;charset=UTF-8",
      data: JSON.stringify(formObject),
      dataType: "text",
      success: function (data) {
        ajaxobj = eval("(" + data + ")");
        console.log(ajaxobj);
        if (ajaxobj.res) {
          window.location.href = "/";
        }
      }
    });
  })
</script>

</html>