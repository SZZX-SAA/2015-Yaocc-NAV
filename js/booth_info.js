function fetchinfo() {
    var key = $('#key').val().trim().toUpperCase();
    var reg = /^[A-Za-z]+$/;
    if (reg.test(key)) {
        $.ajax({
            url: 'ajax/boothinfo.ashx?action=fetchboothinfo&boothkey=' + key,
            type: 'get',
            dataType: 'json',
            async: false,
            cache: false,
            success: function (data) {
                if (data == '-2') {
                    alert('发生未知错误，请检查网络连接，并在稍后重试。');
                }
                else if (data == '-1') {
                    alert('密钥错误，请重试。');
                }
                else if (data == '-9') {
                    alert('服务器拒绝服务。');
                }
                else {
                    $('#fetchinfo').animate({ opacity: '0' }, 300);
                    setTimeout(function () {
                        $('#fetchinfo').addClass('hide');
                        $('#applyinfo').addClass('show');
                    }, 300);
                    setTimeout(function () {
                        $('#applyinfo').animate({ opacity: '1' }, 200);
                    }, 300);
                    setTimeout(function () {
                        $('#row1').animate({ opacity: '1' }, 200);
                    }, 400);
                    setTimeout(function () {
                        $('#row2').animate({ opacity: '1' }, 200);
                    }, 500);
                    setTimeout(function () {
                        $('#row3').animate({ opacity: '1' }, 200);
                    }, 600);
                    setTimeout(function () {
                        $('#row4').animate({ opacity: '1' }, 200);
                    }, 700);
                    setTimeout(function () {
                        $('#aname').val(Base64.decode(data.boothowner));
                        $('#phone').val(data.boothphone);
                        setboothtype(data.boothtype);
                        $('#name').val(Base64.decode(data.boothname));
                        $('#introduction').val(Base64.decode(data.booth_introduction));
                        $('#activity').val(Base64.decode(data.boothacrule));
                    }, 300);
                }
            }
        })
    }
    else {
        alert('密钥输入不正确。');
    }

    $('#fetchinfo').removeClass('disabled');
}

function setboothtype(thetype) {
    $('#boothtypegroup').children().removeClass('active').addClass('disabled');
    var target = 0;
    switch (thetype) {
        case '饮食摊': target = 0; break;
        case '创意摊': target = 1; break;
        case '游戏摊': target = 2; break;
        case '社团摊': target = 3; break;
        case '单元摊': target = 4; break;
        case '其他摊': target = 5; break;
    }
    $($('#boothtypegroup').children()[target]).addClass('active').removeClass('disabled');
}

function applyinfo() {
    $('#fetchinfo').addClass('disabled');

    var flag = true;
    if ($('#aname').val().trim().length > 15) {
        alert('摊主姓名太长');
        flag = false;
    }
    else if ($('#aname').val().trim().length == 0 || $('#name').val().trim().length == 0 || $('#phone').val().trim().length == 0 || $('#introduction').val().trim().length == 0) {
        alert('除优惠规则外其他项不能为空');
        flag = false;
    }
    else if ($('#name').val().trim().length > 50) {
        alert('摊位名称太长');
        flag = false;
    }
    else if ($('#activity').val().trim().length > 30) {
        alert('优惠规则太长');
        flag = false;
    }
    else if (/^[0-9]*$/.test($('#phone').val().trim()) == false || $('#phone').val().trim().length > 15) {
        alert('摊主联系方式填写不正确');
        flag = false;
    }
    else if ($('#introduction').val().trim().length > 501) {
        alert('摊位介绍太长');
        flag = false;
    }

    if (flag) {
        var boothowner = Base64.encodeURI($('#aname').val().trim());
        var boothphone = $('#phone').val().trim();
        var boothname = Base64.encodeURI($('#name').val().trim());
        var booth_introduction = Base64.encodeURI($('#introduction').val().trim());
        var boothrule = Base64.encodeURI($('#activity').val().trim());
        $.ajax({
            url: 'ajax/boothinfo.ashx?action=applyboothinfo',
            type: 'post',
            cache: false,
            data: 'boothowner=' + boothowner + '&boothphone=' + boothphone + '&boothname=' + boothname + '&booth_introduction=' + booth_introduction + '&boothrule=' + boothrule,
            success: function (data) {
                if (data == '-2') {
                    alert('发生未知错误，请检查网络连接，并在稍后重试。');
                }
                else if (data == '-1') {
                    alert('请先获取当前摊位信息。');
                }
                else if (data == '-9') {
                    alert('服务器拒绝服务。');
                }
                else if (data == '1') {
                    alert('摊位信息修改成功，感谢您的配合。');
                }
            }
        })
    }

    $('#fetchinfo').removeClass('disabled');
}