$(function () {
    /*全选按钮状态显示判断*/
    $("#checklist").find("input[type='checkbox']").click(function () {
        /*初始化选择为TURE*/
        $("#all")[0].checked = true;
        /*获取未选中的*/
        var nocheckedList = new Array();
        $("#checklist").find('input:not(:checked)').each(function () {
            nocheckedList.push($(this).val());
        });

        /*状态显示*/
        if (nocheckedList.length == $("#checklist").find('input').length) {
            $("#all")[0].checked = false;
        } else if (nocheckedList.length == 0) {
            $("#all")[0].checked = true;
        } else if (nocheckedList.length) {
            $("#all")[0].checked = false;
        }
    });
    // 全选/取消
    $("#all").click(function () {
        // alert(this.checked);
        if ($(this).is(':checked')) {
            $("#checklist").find('input').each(function () {
                $(this).prop("checked", true);
            });

        } else {
            $("#checklist").find('input').each(function () {
                $(this).removeAttr("checked", false);
                // 根据官方的建议：具有 true 和 false 两个属性的属性，
                // 如 checked, selected 或者 disabled 使用prop()，其他的使用 attr()
                $(this).prop("checked", false);
            });
        }
    });
});
//注册提交
$('#signin').on("click", function () {
    var formObject = {};
    var formArray = $("#signin").serializeArray();
    $.each(formArray, function (i, item) {
        formObject[item.name] = item.value;
    });
    console.log(formArray);
    $.ajax({
        url: "/people/signin.action",
        type: "post",
        contentType: "application/json;charset=UTF-8",
        data: JSON.stringify(formObject),
        dataType: "text",
        success: function (data) {
            ajaxobj = eval("(" + data + ")");
            if (ajaxobj.res == "1") {
                window.location.href = "/people/login";
                alert("注册成功!");
            } else
                alert("请勿重复注册");
        },
        error: function (e) {
            alert("错误！！");
        }
    });
})
//登录验证
$('#login_sub').on("click", function () {
    var formObject = {};
    var formArray = $("#signin").serializeArray();
    $.each(formArray, function (i, item) {
        formObject[item.name] = item.value;
    });
    console.log(formObject);
    $.ajax({
        url: "/user/login.action",
        type: "post",
        contentType: "application/json;charset=UTF-8",
        data: JSON.stringify(formObject),
        dataType: "text",
        success: function (data) {
            ajaxobj = eval("(" + data + ")");
            if (ajaxobj.res) {
                var user = $.session.get('user');
                console.log(user);
                window.location.href = "/user/login";
            }
        }
    });
})
//实验室注册
$('#label_sub').on("click", function () {
    var formObject = {};
    var formArray = $("#labelInfo").serializeArray();
    $.each(formArray, function (i, item) {
        formObject[item.name] = item.value;
    });
    $.ajax({
        url: "/label/signLabel.action",
        type: "post",
        contentType: "application/json;charset=UTF-8",
        data: JSON.stringify(formObject),
        dataType: "text",
        success: function (data) {
            ajaxobj = eval("(" + data + ")");
            if (ajaxobj.res == "1") {
                alert("实验室注册成功！");
            } else {
                $("#alter_mess").html("实验室已被注册请勿重复注册！")
            }
        }
    })
})
//学校注册
$('#school_sub').on('click', function () {
    var formObject = {};
    var formArray = $("#schoolInfo").serializeArray();
    $.each(formArray, function (i, item) {
        formObject[item.name] = item.value;
    });
    $.ajax({
        url: "/school/signSchool.action",
        type: "post",
        contentType: "application/json;charset=UTF-8",
        data: JSON.stringify(formObject),
        dataType: "text",
        success: function (data) {
            ajaxobj = eval("(" + data + ")");
            if (ajaxobj.res == "1") {
                alert("学校注册成功！");
            } else {
                $("#alter_mess").html("学校已被注册请勿重复注册！")
            }
        }
    })
})
//项目注册
$('#project_sub').on('click', function () {
    var projectMap = new Map();
    projectMap.set("pname", $("#project-name").val());
    projectMap.set("pnum", $("#pnum").val());
    projectMap.set("teanum", $("#teacher option:selected").val());
    projectMap.set("label", $("#label option:selected").val());
    let obj = Object.create(null);
    for (let [k, v] of projectMap) {
        obj[k] = v;
    }
    console.log(projectMap);
    $.ajax({
        url: "/project/signProject.action",
        type: "post",
        contentType: "application/json;charset=UTF-8",
        data: JSON.stringify(obj),
        dataType: "text",
        success: function (data) {
            ajaxobj = eval("(" + data + ")");
            if (ajaxobj.res == "1") {
                alert("项目注册成功，等待指导老师审核！");
            } else {
                $("#alter_mess").html("项目已被注册请勿重复注册！")
            }
        }
    })
})

function people() {
    var people = $.session.get('people');
    if (people.plimit == 1) {
        alert("权限不足");
    }
}
//教师审核项目
$("#checkPro_sub").click(function () {
    let $select = [];
    var $chkBoxes = $('#checklist').find('input:checked'); //找到被选中的checkbox集
    if ($chkBoxes.length == 0) { //如果不勾选弹出警告框
        alert('请至少选择一个项目');
        return false;
    }
    console.log($chkBoxes)
    //遍历被选中的checkbox集
    $($chkBoxes).each(function () {
        $select.push($(this).data('pnum')); //找到对应checkbox中data-id属性值，然后push给空数组$ids
    });
    console.log($select);
    $.ajax({
        url: "/projectinfo/updateProjectsta.action",
        type: "post",
        contentType: "application/json;charset=UTF-8",
        data: JSON.stringify($select),
        dataType: "text",
        success: function (data) {
            ajaxobj = eval("(" + data + ")");
            if (ajaxobj.res == "1") {
                alert("更新完毕");
            } else {
                $("#alter_mess").html("更新失败")
            }
        }
    })
})
//学生审核项目
$("#joinPro_sub").click(function () {
    let $select = [];
    let $chkBoxes = $('#checklist').find('input:checked'); //找到被选中的checkbox集
    if ($chkBoxes.length == 0) { //如果不勾选弹出警告框
        alert('请至少选择一个项目');
        return false;
    }
    console.log($chkBoxes)
    //遍历被选中的checkbox集
    $($chkBoxes).each(function () {
        $select.push($(this).data('pnum')); //找到对应checkbox中data-id属性值，然后push给空数组$ids
    });
    console.log($select);
    $.ajax({
        url: "/ppl/agreePpl.action",
        type: "post",
        contentType: "application/json;charset=UTF-8",
        data: JSON.stringify($select),
        dataType: "text",
        success: function (data) {
            ajaxobj = eval("(" + data + ")");
            if (ajaxobj.res == true) {
                alert("已经成功加入");
            } else if (ajaxobj.res == false) {
                alert("未能成功审核");
            } else {
                console.log(ajaxobj.res.length);
                let n = []
                n.push(ajaxobj.res - 1);
                alert("已经通过" + n + "个项目，请勿重复审核！");
            }
        }
    })
})

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
$("#check_self").click(function () {

    const obj = {
        proname: $("#proname").val(),
        pname: $("#pname").val(),
        
    }
    console.log(encodeSearchParams(obj));
    const finalUrl = "/recordtime/record.action?" + encodeSearchParams(obj)
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