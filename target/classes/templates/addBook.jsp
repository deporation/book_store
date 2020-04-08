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
    <form id="add" >
        <p>ISBN: <input type="text" id="isbn" name="isbn"></p>
        <p>书名：<input type="text" id="bookname" name="bookname"> </p>
        <p>作者：<input type="text" id="autor" name="autor"></p>
        <p>译者：<input type="text" id="transalter" name="transalter"></p>
        <p>出版社：<input type="text" id="press" name="press"></p>
        <p>编辑：<input type="text" id="editor" name="editor"></p>
        <p>出版人：<input type="text" id="publisher" name="publisher"></p>
        <p>版次：<input type="num" id="edition" name="edition" min="1"></p>
        <p>页数：<input type="num" id="pages" name="pages" min="1"></p>
        <p>价格：<input type="text" id="price" name="price"></p>
        <p>库存：<input type="text" id="bcount" name="bcount"></p>
        <p>出版日期：<input type="date" id="btime" name="btime"></p>
        <p>详情介绍：<input type="textarea" id="detail" name="detail"></p>
        <input type="button" id="submit" value="提交">
    </form>
  </body>
  <script>
      $("#submit").click(function(){
        var formObject = {};
        var formArray = $("#add").serializeArray();
        $.each(formArray, function (i, item) {
            
                if(item.name !='btime'){
                    formObject[item.name] = item.value;
                }else{
                    formObject[item.name] = new Date(Date.parse(item.value));
                }
        });
        console.log(formObject);
        $.ajax({
            url: "/book/addBook.action",
            type: "post",
            contentType: "application/json;charset=UTF-8",
            data: JSON.stringify(formObject),
            dataType: "text",
            success: function (data) {
                ajaxobj = eval("(" + data + ")");
                if (ajaxobj.res == true) {
                    alert("注册成功!");
                } else
                    alert("请勿重复注册");
            },
            error: function (e) {
                alert("错误！！");
            }
        });
      })
  </script>
</html>