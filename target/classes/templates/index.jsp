<!DOCTYPE HTML>
<html xmlns = "http://www.thymeleaf.org">
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
    <ul>
        <li><span><a href="/book/search.action?bookname=">查询书籍</a></span></li>
        <li><span><a href="/car/check">查看购物车</a></span></li>
        <li th:if = "${session.user.plimit}"><span><a href="/book/addBook">添加新商品</a></span></li>
        <li th:if = "${session.user.plimit}"><span><a href="/book/addBooknum">商品进货</a></span></li>
    </ul>
  </body>
</html>