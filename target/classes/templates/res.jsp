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
        <a href="/">首页</a>
        <p>总价为<span th:text = "${allprice}"></span></p>
  </body>
  <script>
    
  </script>
</html>