<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!--<!DOCTYPE html>-->
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<style>
    #header_logo{
        position: absolute;
        left: 15%;
        top: 10px;
    }
    #header_logo img{
        width: 180px;
        height: 50px;
    }
    #member_action{
        width: 240px;
        height: auto;
    }
    .club_title{
        width: auto;
        height: 50px;
        text-align: center;
        background:#d3d0ff;
    }
    .club_title_text{
        text-align: center;
        float: left;
        padding: 4px 10px 0 30px;
        box-sizing: border-box;
    }
    #club_content{
        position: relative;
        text-align: center;
        background:#ecebff;
        border-radius: 6px;
    }
    .club_form_title{                
        padding: 5px;
        background: #6699ff;
    }
    .club_form_input{
        margin: 10px 0 0 0;
        padding: 4px 10px;
        border-radius: 4px;
        cursor: pointer;
        font-family: 'cwtexhei', serif;
    }
    .club_form_aside{
        text-align: left;
        font-size: 12px;
        padding: 5px;
    }
    .member_action_submit{
        margin: 10px;
        width:160px;
        font-size: 16px;
        height: 34px;
        border-radius: 4px;
        cursor: pointer;
        font-family: 'cwtexhei', serif;
    }

    #language{
        width: 100px;
        height: auto;
    }
    .header_language_change{                
        padding: 13px;               
        height: 24px;
        cursor: pointer;
        background:#d3d0ff;
    }
    #language_change a{
        vertical-align: top;
    }
    #language_pulldown{                
        margin:0;
        padding:2px 0;
        width: 62px;
        background:#ecebff;
    }
    #language_pulldown li{
        list-style: none;
        background: #bbbbbb;
        padding: 10px;
        height: 23px;
        width:32px; 
        margin:5px;               
    }
</style>
<%
    String check_out = request.getRequestURI();
    if (!check_out.endsWith("login.jsp") && !check_out.endsWith("update.jsp")) {
        session.setAttribute("url_origin", request.getRequestURI());
        System.out.println("session.get" + session.getAttribute("url_origin"));
    }
%>
<header>
    <div id="header_logo"><a href="/aac"><img src="/aac/image/logo/blue.jpg" alt=""/></a></div>
    <div style="position: absolute;left: 60%;top: 10px;display: inline-flex;">
        <div id="language" style="display: none">
            <div class="header_language_change">
                <div id="language_change">                                
                    <a href="<%= request.getContextPath()%>"><img src="/aac/image/index/language_tw.png" alt="tw"/></a>                                    
                    <img id='language_arrow' src="/aac/image/arrows/index_down.png" style="width: 15px;margin:5px 0px 5px 20px ;" alt="arrow"/>                                
                </div>
            </div>                    
            <ul class="display_none" id="language_pulldown">
                <li class="display_none"><a href=""><img src="/aac/image/index/language_tw.png" alt="tw"/></a></li>                                
                <li><a href=""><img src="/aac/image/index/language_en.png" alt="en"/></a></li>
                <li><a href=""><img src="/aac/image/index/language_jp.png" alt="jp"/></a></li>                                
            </ul>
        </div>
        <div id="member_action" style="display: none">
            <div class="club_title">
                <div class="club_title_text">
                    <div style="font-family: 'Lobster', cursive;font-size: 18px;">Azaleas Mileage Club</div>
                    <div>會員登入 / 註冊</div>
                </div>
                <img id='club_arrow' src="/aac/image/arrows/index_down.png" style="width: 15px;margin:17.5px 10px 17.5px 20px;" alt="arrow"/>
            </div>
            <div id='club_content' class="display_none">
                <form method="POST" action="login.do">
                    <div class="member_signin" style="margin:0 0 10px;">                                
                        <div class="club_form_title">會員登入</div>
                        <input class="club_form_input" id="signin_email" type="text" name="signin_email" placeholder="輸入帳號"/><br>
                        <input class="club_form_input" id="signin_Password" type="password" name="signin_Password" placeholder="輸入密碼"/>
                        <div class="club_form_aside" style="margin:10px 0 0;">
                            <input id="remember" type="checkbox" name="remember" style="cursor: pointer;margin: 0 0 0 25px;"/>
                            <label id="check" for="remember" style="cursor: pointer;margin: 0 35px 0 0;">記住登入資訊</label>
                            <a href="" >忘記密碼?</a>
                        </div>
                        <input class="member_action_submit" id="signin_submit" name="signin_submit" type="submit" value="登入"/>
                    </div>
                </form>
                <form method="POST" action="register.do">
                    <div class="member_register" style="margin:0 0 10px;">
                        <div class="club_form_title">會員註冊</div>
                        <div style="width:180px;margin: 10px auto 0px;font-size: 14px;text-align: left;">填寫您的電子郵件信箱，並成為我們超讚的杜鵑航空里程俱樂部會員。</div>
                        <input class="club_form_input" id="register_email" type="text" name="register_email" placeholder="輸入電子郵件信箱"/><br>
                        <input class="member_action_submit" id="submit_resgister" name="submit_resgister" type="submit" value="註冊"/>
                    </div>
                </form>
            </div>                        
        </div>
    </div>
</header>

