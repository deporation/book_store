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
    <p>书名:<span th:text="${details.book.bookname}"></span></span></p>
    <p>详情:<span th:text="${details.book.detail}"></span></span></p>
    <p>库存:<span th:text="${details.book.bcount}"></span></span></p>
    <form id="addcar">
        <input type="number" name="" id="ccount" th:attr="data-isbn=${details.book.isbn}">
        <input type="button" id="add" value="添加购物车">
    </form>
    <div th:if="${details.comments} != null">
        <table border="1" id="carlist">

            <tr>
                <th>评论人</th>
                <th>评论</th>
            </tr>
            <tr th:each="comment: ${details.comments}">
                <td th:text="${comment.uname}"></td>
                <td th:text="${comment.content}"></td>
            </tr>

        </table>
    </div>
    <form id="comments">
        <p id="isbn" th:attr="data-detail=${details.book.isbn}"><input id="content" type="text"></p>
        <input type="button" id="comment" value="发表评论">
    </form>
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
    $("#comment").click(function () {

        const obj = {
            isbn: $("#isbn").data('detail'),
            content: $("#content").val(),

        }
        console.log(encodeSearchParams(obj));
        const finalUrl = "/comment-info/addComment.action?" + encodeSearchParams(obj)
        $.ajax({
            url: finalUrl,
            type: "post",
            contentType: "application/json;charset=UTF-8",
            dataType: "text",
            success: function (data) {
                ajaxobj = eval("(" + data + ")");
                if (ajaxobj.res == true) {
                    window.location.href = "/book/Bookdetail?isbn=" + $("#isbn").data('detail');
                } else {
                    alert("评论添加失败");
                }

            }
        })
    })
    $("#add").click(function () {
        const obj = {
            isbn: $("#isbn").data('detail'),
            ccount: $("#ccount").val(),
            stat: false
        }
        const finalUrl = "/car/add"
        $.ajax({
            url: finalUrl,
            type: "post",
            contentType: "application/json;charset=UTF-8",
            dataType: "text",
            data: JSON.stringify(obj),
            success: function (data) {
                ajaxobj = eval("(" + data + ")");
                if (ajaxobj.res == 0) {
                    alert("已经添加进购物车");
                } else if (ajaxobj.res == 1) {
                    alert("购物车添加失败");
                } else {
                    alert("请先登录");
                }
            }
        })
    })
</script>

</html>