<!DOCTYPE HTML>
<html xmlns="http://www.thymeleaf.org">

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
    <form id="searchs">
        <p>书名： <input type="text" name="" id="bookname" ></p>
        <P><input type="button" value="查询" id="search"></P>
    </form>
    <table border="1" id="books">
            
        <tr>
            <th>书名</th>
            <th>作者</th>
        </tr>
        <tr th:each="book: ${books}">
            <td th:text="${book.bookname}"></td>
            <td th:text="${book.autor}"></td>
            <td><input type="button" id="deatil" th:attr="data-isbn=${book.isbn}" value="查看详细"></td>
        </tr>
        
    </table>
</body>
<script>
    function encodeSearchParams(obj) {
        const params = []
    
        Object.keys(obj).forEach((key) => {
            let value = obj[key]
            // 如果值为undefined我们将其置空
            if (typeof value === 'undefined') {
                value = ''
            }
            params.push([key, encodeURIComponent(value)].join('='))
        })
    
        return params.join('&')
    }
    $("#search").click(function () {

        const obj = {
            bookname: $("#bookname").val(),
            
        }
        console.log(encodeSearchParams(obj));
        const finalUrl = "/book/search.action?" + encodeSearchParams(obj)
        $.ajax({
            url: finalUrl,
            type: "post",
            contentType: "application/json;charset=UTF-8",
            dataType: "text",
            success: function (data) {
                window.location.href = finalUrl;
            }
        })
    })
    $("#deatil").click(function () {

        const obj = {
            isbn: $("#deatil").data("isbn"),
            
        }
        console.log(encodeSearchParams(obj));
        const finalUrl = "/book/Bookdetail?" + encodeSearchParams(obj)
        $.ajax({
            url: finalUrl,
            type: "post",
            contentType: "application/json;charset=UTF-8",
            dataType: "text",
            success: function (data) {
                window.location.href = finalUrl;
            }
        })
    })
</script>
</html>