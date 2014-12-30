<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
    <title>2015“钥出彩”游园会</title>
    <script src="js/default.js"></script>
    <script src="js/base64.js"></script>
    <script src="js/booth_info.js"></script>
    <link href="css/default.css" rel="stylesheet" />
</head>
<body id="body">
    <!-- Snow -->
    <div class="hidden-sm hidden-xs" style="position: fixed; left: 0px; top: 0px" id="large-header">
        <canvas id="demo-canvas"></canvas>
    </div>

    <!-- Wrapper -->
    <div id="wrapper">

        <!-- Nav -->
        <nav id="nav">
            <a id="icon1" href="#" class="fa fa-key invisible active"></a>
            <a id="icon2" href="#" class="fa fa-pencil invisible"></a>
            <a id="icon3" href="#" class="fa fa-arrow-right invisible"></a>
            <a id="icon4" href="#" class="fa fa-group invisible"></a>
        </nav>

        <div id="loading" class="spinner"></div>
        <div id="loading2"></div>

        <!-- Main -->
        <div id="main" class="hide">

            <!-- default -->
            <article id="default" class="panel invisible" style="font-family: YouYuan, Microsoft Yahei Light, Microsoft Yahei, Hiragino Sans GB, WenQuanYi Micro Hei, sans-serif">
                <header>
                    <h1>“钥出彩”游园会欢迎您！</h1>
                    <p><small style="font-size: 70%">填写、修改摊位信息，或跳转至摊位、游戏页面</small></p>
                </header>
                <a id="me-btn" href="#" class="jumplink pic">
                    <span class="arrow icon fa-chevron-right"><span></span></span>
                    <img id="me" src="/images/me.jpg" alt="" />
                </a>
            </article>
            <!-- bulletin -->
            <article id="bulletin" class="panel">
                <header>
                    <h3>游园会摊位信息填写</h3>
                </header>
                <div class="row">
                    <span id="span1" style="font-size: 17px">输入我们发送的密钥后，请<span class="underline">先获取当前摊位信息</span>，再进行修改与上传。</span>
                    <span id="span2" class="hide" style="font-size: 17px">若密钥通过后上传按钮没有显示，请<span class="underline">按Ctrl+F5或手动清除缓存</span>。拨打18682050251联系工作人员</span>
                    <span id="span3" class="hide" style="font-size: 17px">若信息无法提交，拨打18682050251联系工作人员寻求帮助。</span>
                </div>
                <div class="row">
                    <div class="col-lg-11 col-md-11">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon">摊主密钥</span>
                            <input onkeypress = "if(event.keyCode==13) fetchinfo()" type="text" class="form-control" placeholder="输入您持有的大写字母密钥" id="key">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-11 col-md-11">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon">&#12288;&#12288;&#12288;&#12288;</span>
                            <button id="fetchinfo" class="btn btn-lg btn-info btn-block" onclick="fetchinfo()">获取当前摊位信息</button>
                            <button id="applyinfo" class="btn btn-lg btn-download btn-block hide invisible" onclick="applyinfo()">确认提交摊位信息</button>
                        </div>
                    </div>
                </div>
                <br />
                <div class="row halfvisible" id="row1">
                    <div class="col-lg-5 col-md-5">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon">摊主姓名</span>
                            <input type="text" class="form-control" placeholder="中文姓名" id="aname">
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon">联系方式</span>
                            <input type="text" class="form-control" placeholder="请填写摊主的电话" id="phone">
                        </div>
                    </div>
                </div>
                <br />
                <div class="row halfvisible" id="row2">
                    <div class="col-lg-5 col-md-5">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon">摊位名称</span>
                            <input type="text" class="form-control" placeholder="在此填写您的摊位名称" id="name">
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 hidden-sm hidden-xs">
                        <div class="btn-group btn-group-lg pull-right" id="boothtypegroup">
                            <button type="button" class="btn btn-default disabled">饮食</button>
                            <button type="button" class="btn btn-default disabled">创意</button>
                            <button type="button" class="btn btn-default disabled">游戏</button>
                            <button type="button" class="btn btn-default disabled">社团</button>
                            <button type="button" class="btn btn-default disabled">单元</button>
                            <button type="button" class="btn btn-default disabled">其他</button>
                        </div>
                    </div>
                </div>
                <br />
                <div class="row halfvisible" id="row3">
                    <div class="col-lg-11 col-md-11">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon">摊位简介</span>
                            <textarea style="height: 90px; width: 100%; border: 1px solid #ccc; border-radius: 2px; font-size: 16px; padding: 6px 12px" placeholder="请不要超过500字" id="introduction"></textarea>
                        </div>
                    </div>
                </div>
                <br />
                <div class="row halfvisible" id="row4">
                    <div class="col-lg-11 col-md-11">
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon">优惠规则</span>
                            <input type="text" class="form-control" placeholder="可采用任意形式；请不要超过20字；留空则代表不参与本次优惠活动" id="activity">
                        </div>
                    </div>
                </div>
            </article>

            <!-- guidance -->
            <article id="guidance" class="panel">
                <div class="jumbotron" id="boothlarge">
                    <div class="col-md-offset-1 col-lg-offset-1">
                        <h1>摊位</h1>
                        <p>我钥好评，我钥聚惠！点击了解更多</p>
                        <p><a class="btn btn-primary btn-lg" href="#" role="button" onclick="alert('即将开放，敬请期待！')">详细信息</a></p>
                    </div>
                </div>
                <div class="jumbotron" id="gamelarge">
                    <div class="col-md-offset-1 col-lg-offset-1">
                        <h1>游戏</h1>
                        <p>更加精彩的线上线下互动游戏，还在等什么！</p>
                        <p><a class="btn btn-primary btn-lg" href="#" role="button" onclick="alert('将于游园会当天开放！')">详细信息</a></p>
                    </div>
                </div>
            </article>

            <!-- info -->
            <article id="info" class="panel">
                <header>
                    <h2>开发人员&nbsp;<small>网络组</small></h2>
                </header>
                <article>
                    <div>
                        <h3>简介</h3>
                        <p><small>网络组隶属于深圳中学学生活动中心技术部，于2013年9月份首次设立，负责学生活动中心网络活动规划及网站建设。</small></p>
                        <h3>成员</h3>
                        <p><small>2013级（现高二级）：陈俊任、余浩民、赵浩达</small></p>
                        <p><small>2014级（现高一级）：高正月、刘慧琳、李奕阳、叶紫阳</small></p>
                        <h3>网站</h3>
                        <p><small>访问我们的<a href="http://202.96.165.238" target="_blank">官方网站</a></small></p>
                        <p><small>学生活动中心技术部网络组对网站及其一切内容拥有最终解释权。</small></p>
                    </div>
                </article>
            </article>
        </div>

        <!-- Footer -->
        <div id="footer">
            <ul class="copyright">
                <li id="footer-left" class="invisible">&copy; 深圳中学学生活动中心</li>
                <li id="footer-right" class="invisible">Design: 网络组</li>
            </ul>
        </div>
    </div>
    
    <script src="js/snow.js"></script>
    <script>

        function change(changetime) {
            var bodycolor = 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';
            $('#body').animate({ backgroundColor: bodycolor }, changetime);
        }
        change(1800);

        window.onload = function () {

            setTimeout(function () {
                change(1000);
                $('#loading').addClass('hide');
                $('#loading2').addClass('spinner-static');
                $("#loading2").animate({ marginLeft: '0px', width: '100%' }, 500);
                $("#loading2").animate({ height: '400px' }, 500);
            }, 1800);

            setTimeout(function () {
                $("#footer-left").animate({ opacity: '0.8' }, 900);
                $("#footer-right").animate({ opacity: '0.8' }, 900);
            }, 600);

            setTimeout(function () {
                change(500);
                $('#loading2').addClass('hide');
                $('#main').removeClass('hide');
                $("#default").animate({ opacity: '1' }, 500);
                setTimeout(function () {
                    $("#icon1").animate({ opacity: '1' }, 200);
                }, 0);
                setTimeout(function () {
                    $("#icon2").animate({ opacity: '1' }, 200);
                }, 100);
                setTimeout(function () {
                    $("#icon3").animate({ opacity: '1' }, 200);
                }, 200);
                setTimeout(function () {
                    $("#icon4").animate({ opacity: '1' }, 200);
                }, 300);
                $("#me-btn").attr("href", "#bulletin");
                $("#icon1").attr("href", "#default");
                $("#icon2").attr("href", "#bulletin");
                $("#icon3").attr("href", "#guidance");
                $("#icon4").attr("href", "#info");
            }, 2800);

            setTimeout(function () {
                $('#boothlarge').addClass('booth-background');
                $('#gamelarge').addClass('game-background');
            }, 1800);

            setTimeout(function () {
                $('#body').addClass('body-background');
            }, 4200)

        }

        var fetchtimes = 0;

        $("#fetchinfo").click(function () {
            fetchtimes += 1;
            if (fetchtimes == 2) {
                $('#span1').fadeOut('1000');
                $('#span2').fadeIn('1000');
                $("#span1").addClass('hide');
                $("#span2").addClass('show');
            }
        });

        var applytimes = 0;

        $("#applyinfo").click(function () {
            applytimes += 1;
            if (applytimes == 2) {

                if (fetchtimes >= 2) {
                    $('#span2').fadeOut('1000');
                } else {
                    $('#span1').fadeOut('1000');
                }

                $('#span3').fadeIn('1000');

                if (fetchtimes >= 2) {
                    $("#span2").removeClass('show');
                } else {
                    $("#span1").addClass('hide');
                }

                $("#span3").addClass('show');
            }
        });
    </script>
</body>
</html>
