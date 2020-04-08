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
    <p th:if="${price}==-1"><span th:text="库存不足"></p>
    <form id="car">
        <table border="1" id="carlist">
            <tr>
                <th>勾选状态</th>
                <th>书名</th>
                <th>数量</th>
                <th>价格</th>
            </tr>
            <tr th:each="car: ${cars}">
                <td class="cid"><input type="checkbox" th:attr="data-cid=${car.cid}" class="title"></td>
                <td th:text="${car.bookname}"></td>
                <td class="number"><input type="number" th:value="${car.ccount}" min="0" class="num"></td>
                <td th:attr="data-pri=${car.pri}" class="pri"></td>
            </tr>
        </table>
        <p><input type="button" id="pay" value="支付" th:attr="data-uid = ${session.user.uid}"><input type="button"
                id="update" value="更新"></p>
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
    $("#pay").click(function () {
        let $select = [];
        let $chkBoxes = $('#carlist').find('input:checked'); //找到被选中的checkbox集
        let obj ={};
        if ($chkBoxes.length == 0) { //如果不勾选弹出警告框
            alert('请至少选择一个结账');
            return false;
        } else if ($chkBoxes.length == 1) {
            $($chkBoxes).each(function () {
                 obj = {
                    cid:$(this).data("cid"),
                    ccount: $(this).parent().next().next().children().val()
                }
            })
            console.log(encodeSearchParams(obj));
            const finalUrl = "/car/pay?" + encodeSearchParams(obj)
            $.ajax({
                url: finalUrl,
                type: "post",
                contentType: "application/json;charset=UTF-8",
                dataType: "text",
                success: function (data) {
                    ajaxobj = eval("(" + data + ")");
                    if(ajaxobj.res == -1.0){
                        alert("库存不足");
                    }else
                        alert("付款成功,总价为" + ajaxobj.res);
                        window.location.href ="/car/check"
                }
            })
        } else {
            console.log($chkBoxes)
            //遍历被选中的checkbox集
            $($chkBoxes).each(function () {
                const obj = {
                    cid:$(this).data("cid"),
                    ccount: $(this).parent().next().next().children().val()
                }
                $select.push(obj); //找到对应checkbox中data-id属性值，然后push给空数组$ids
            });
            console.log($select);
            const finalUrl = "/car/payall"
            $.ajax({
                url: finalUrl,
                type: "post",
                contentType: "application/json;charset=UTF-8",
                data:JSON.stringify($select),
                dataType: "text",
                success: function (data) {
                    ajaxobj = eval("(" + data + ")");
                    if(ajaxobj.res == -1.0){
                        alert("库存不足");
                    }else
                        alert("付款成功,总价为" + ajaxobj.res);
                        window.location.href ="/car/check"


                }
            })
        }

    })

    $(function () {
        $('tr').each(function(){
            let price = $(this).children(".pri").data("pri");
            let num = $(this).children(".number").children(".num").val();
            $(this).children('.pri').html((Number(price * num)).toFixed(2));
        })
    });

    $(".num").click(function () {
        $('tr').each(function(){
            let price = $(this).children(".pri").data("pri");
            let num = $(this).children(".number").children(".num").val();
            $(this).children('.pri').html((Number(price * num)).toFixed(2));
        })
    })
</script>

</html>