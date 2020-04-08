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
        <table border="1" id="carlist">
            <tr>
                <th>书名</th>
                <th>价格</th>
            </tr>
            <tr th:each="book: ${books}">
                <td th:text="book.bookname"><a class="book" id="isbn" th:attr="data-ISBN=${book.isbn}"></a></td>
                <td th:text="book.price"></td>
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
    $(".book").click(function () {
        let isbn =  $("#isbn").data('ISBN');
        const finalUrl = "/book/search.action?" + encodeSearchParams(isbn)
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