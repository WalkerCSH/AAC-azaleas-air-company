<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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

    .booking_status{
        width: auto;
        height: auto;                
        position: absolute;
        background: #d3cdff;
        top: 16px;
        left: 30%;
        padding: 0px 4px 0px 10px;
        display: inline-flex;
        border-radius: 16px;
    }
    .status,.status_doing{
        padding: 2px 8px;
        display: inline-flex;
    }
    .status_doing{                
        border-radius: 16px;
        background: white;
    }
    .status img,.status_doing img{
        width:24px;
        height: 24px;
        margin: 6px 0;
    }
    .status_name{
        font-size: 14px;
        color: #666666;
        margin: 0 6px 0 0;
        padding: 5px;
    }
    .status_name_done{
        font-size: 14px;
        color: #3a3eff;
        margin: 0 6px 0 0;
        padding: 5px;
    }
    .arrow img{
        width: 14px;
        padding: 7px 6px 7px 0;
    }
    .search_condition{
        padding:15px 2%;
        text-align: center;
        box-sizing: border-box;
        height: auto;
        width: 100%;
        background:#3a3eff;
    }
    #trip_type{
        width: 20px;
        height: 20px;
    }
    .search_condition>div{
        display: inline-flex;                
        color: #ffffff;
        margin: 0 10px;
    }
    .search_condition>div>div{
        margin: 0 6px;
    }
    .search_condition>div>div>span{
        font-family: 'Muli', sans-serif;
        margin: 0 6px;
    }
    #display_area{
        margin:0;
        width: 100%;
        height: auto;
        background: #e2deff;
        display: flex;
    }
    #display_area_left{
        margin:0;
        width: 70%;
        height: auto;
        background: #e2deff;
        box-sizing: border-box;
    }
    #display_area_right{
        margin:0;
        width: 30%;
        height: auto;
        background: #e2deff;
        box-sizing: border-box;
    }
</style> 
<%
    String check_out = request.getRequestURI();
    if (!check_out.endsWith("login.jsp") && !check_out.endsWith("update.jsp")) {
        session.setAttribute("url_origin", request.getRequestURI());
        System.out.println("session.get" + session.getAttribute("url_origin"));
    }
    int bsPage = (int) session.getAttribute("bs_page");
    List<String> errors = (ArrayList) session.getAttribute("errorlist");
    // 為何errors會是null???? 
    // 更改名稱後就可以抓得到值了...
%>
<script>
    $(document).ready(readyHandler);
    var pageStatus = ["booking_search_submit", "booking_flight_select",
        "booking_passenger_service", "booking_credit_pay", "booking_aboard"];
    var img = ["/aac/image/booking/search.png", "/aac/image/booking/flight_select.png",
        "/aac/image/booking/passenger_service.png", "/aac/image/booking/credit_pay.png", "/aac/image/booking/aboard.png"];
    var img_done = ["/aac/image/booking/search_done.png", "/aac/image/booking/flight_select_done.png",
        "/aac/image/booking/passenger_service_done.png", "/aac/image/booking/credit_pay_done.png", "/aac/image/booking/aboard_done.png"];
    var bsPage = <%= bsPage%>;
    function readyHandler() {
        switch (bsPage) {
            case 0:
                for (var i = bsPage; i < pageStatus.length; i++) {
                    $("#" + pageStatus[i]).removeClass("status_doing").addClass("status");
                    $("#" + pageStatus[i] + ">div").removeClass("status_name_done").addClass("status_name");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img[i]);
                }
                for (var i = 0; i < bsPage + 1; i++) {
                    $("#" + pageStatus[i] + ">div").removeClass("status_name").addClass("status_name_done");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img_done[i]);
                }
                $("#" + pageStatus[0]).removeClass("status").addClass("status_doing");
                break;
            case 1:
                for (var i = bsPage; i < pageStatus.length; i++) {
                    $("#" + pageStatus[i]).removeClass("status_doing").addClass("status");
                    $("#" + pageStatus[i] + ">div").removeClass("status_name_done").addClass("status_name");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img[i]);
                }
                for (var i = 0; i < bsPage + 1; i++) {
                    $("#" + pageStatus[i] + ">div").removeClass("status_name").addClass("status_name_done");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img_done[i]);
                }
                $("#" + pageStatus[1]).removeClass("status").addClass("status_doing");
                break;
            case 2:
                for (var i = bsPage; i < pageStatus.length; i++) {
                    $("#" + pageStatus[i]).removeClass("status_doing").addClass("status");
                    $("#" + pageStatus[i] + ">div").removeClass("status_name_done").addClass("status_name");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img[i]);
                }
                for (var i = 0; i < bsPage + 1; i++) {
                    $("#" + pageStatus[i] + ">div").removeClass("status_name").addClass("status_name_done");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img_done[i]);
                }
                $("#" + pageStatus[2]).removeClass("status").addClass("status_doing");
                break;
            case 21:
                for (var i = 2; i < pageStatus.length; i++) {
                    $("#" + pageStatus[i]).removeClass("status_doing").addClass("status");
                    $("#" + pageStatus[i] + ">div").removeClass("status_name_done").addClass("status_name");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img[i]);
                }
                for (var i = 0; i < 2 + 1; i++) {
                    $("#" + pageStatus[i] + ">div").removeClass("status_name").addClass("status_name_done");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img_done[i]);
                }
                $("#" + pageStatus[2]).removeClass("status").addClass("status_doing");
                break;
            case 3:
                for (var i = bsPage; i < pageStatus.length; i++) {
                    $("#" + pageStatus[i]).removeClass("status_doing").addClass("status");
                    $("#" + pageStatus[i] + ">div").removeClass("status_name_done").addClass("status_name");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img[i]);
                }
                for (var i = 0; i < bsPage + 1; i++) {
                    $("#" + pageStatus[i] + ">div").removeClass("status_name").addClass("status_name_done");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img_done[i]);
                }
                $("#" + pageStatus[3]).removeClass("status").addClass("status_doing");
                break;
            case 4:
                for (var i = bsPage; i < pageStatus.length; i++) {
                    $("#" + pageStatus[i]).removeClass("status_doing").addClass("status");
                    $("#" + pageStatus[i] + ">div").removeClass("status_name_done").addClass("status_name");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img[i]);
                }
                for (var i = 0; i < bsPage + 1; i++) {
                    $("#" + pageStatus[i] + ">div").removeClass("status_name").addClass("status_name_done");
                    $("#" + pageStatus[i] + ">img").removeAttr("src").attr("src", img_done[i]);
                }
                $("#" + pageStatus[4]).removeClass("status").addClass("status_doing");
                break;
        }
    }
</script>
<%
    if (errors != null && !errors.isEmpty()) {
%>
<div id="errors_dialog">
    <% for (String error : errors) {%>
    <div><%= error%></div>
    <%}%>
</div>
<%}
//    session.removeAttribute("errorlist");
%>

<script>
    $(function () {
        $("#errors_dialog").dialog();
    });
</script>

<div id="header_logo">
    <a href="/aac">
        <img src="/aac/image/logo/blue.jpg" alt=""/>
    </a>
</div>            
<div class="booking_status">
    <div class="status" id="booking_search_submit">
        <img src="/aac/image/booking/search.png" alt=""/>
        <div class="status_name">搜尋航班</div>
    </div>
    <div class="arrow">
        <img src="/aac/image/arrows/index_right.png" alt=""/>
    </div>
    <div class="status" id="booking_flight_select">
        <img src="/aac/image/booking/flight_select.png" alt=""/>
        <div class="status_name">選擇航班</div>
    </div>
    <div class="arrow">
        <img src="/aac/image/arrows/index_right.png" alt=""/>
    </div>
    <div class="status" id="booking_passenger_service">
        <img src="/aac/image/booking/passenger_service.png" alt=""/>
        <div class="status_name">旅客服務</div>
    </div>
    <div class="arrow">
        <img src="/aac/image/arrows/index_right.png" alt=""/>
    </div>
    <div class="status" id="booking_credit_pay">
        <img src="/aac/image/booking/credit_pay.png" alt=""/>
        <div class="status_name">刷卡付款</div>                            
    </div>
    <div class="arrow">
        <img src="/aac/image/arrows/index_right.png" alt=""/>
    </div>
    <div class="status" id="booking_aboard">
        <img src="/aac/image/booking/aboard.png" alt=""/>
        <div class="status_name">準備出發</div>
    </div>
</div>
