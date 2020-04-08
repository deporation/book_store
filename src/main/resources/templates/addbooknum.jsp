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
    <form id="book">
        <p><input type="text"  id="isbn"></p>
        <p><input type="num" id="bcount" min="0"></p>
        <p><input type="button" id="submit" value="提交"></p>
        </table>
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
    $("#submit").click(function () {
        let obj = {
         isbn:$("#isbn").val(),
         bcount :$("#bcount").val(),
        };
        let finalUrl = "/book/addBooknum.action?" + encodeSearchParams(obj);
        $.ajax({
            url: finalUrl,
            type: "post",
            contentType: "application/json;charset=UTF-8",
            dataType: "text",
            success: function (data) {
                ajaxobj = eval("(" + data + ")");
                if(ajaxobj.res == true){
                    alert("增加成功");
                    window.location.href = ajaxobj.url;
                }
            }
        })
    })
</script>

</html>