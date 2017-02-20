<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="aac.model.PriceSheetServices"%>
<%@page import="aac.domain.PriceSheet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="aac.domain.TicketOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<style>
    .booking_summary{
        padding: 0 ;
        width: 260px;
        box-sizing: border-box;
        background: #ffffff;
        text-align: center;
    }
    .summary_title{
        font-size: 22px;
        padding: 10px 0;
        color: #3a3eff;
        box-sizing: border-box;
        text-align: center;
    }
    .summary_content{
        width: inherit;
        box-sizing: border-box;
    }
    .summary_date{
        background: #888888;
        color:#ffffff;
        font-size: 18px;                
        padding: 4px;
        text-align: left;
        box-sizing: border-box;
    }
    .summary_date>span{
        font-family: 'Muli', sans-serif;
        margin: 0 10px;                
    }
    .summary_detail{
        display: inline-flex;
        margin: 8px 0 0 0;
    }
    .takeoff_port>div:not(:nth-child(2)),.land_port>div:not(:nth-child(2)){
        font-family: 'Muli', sans-serif;
        margin: 0 10px;
        color: #666666;
    }
    .arrow3{
        padding: 12px 10px;
        font-family: 'Muli', sans-serif;
        color: #bbbbbb;
    }
    .arrow3 img{
        width: 16px;
        height: 16px;
    }
    .button_back_next{
        margin: 0;
        width: 240px;
        display: inline-flex;
        box-sizing: border-box;
        padding: 4px 0 10px 0px;
    }
    .button{
        width: inherit;
        height: 40px;
        padding:auto;
        border: #222222 2px solid;
        box-sizing: border-box;
        font-size: 18px;
        font-family: 'Muli', sans-serif;
        margin: 0 10px;
    }
    #next{
        padding: 6px 0;
        background: #444444;
        color: #ffffff;
        cursor: pointer;
    }
    #back{
        padding: 6px 0;
        background:#bbbbbb;
        color: #ffffff;
        cursor: pointer;
    }
    .summary_fares{
        width: inherit;
        height: auto;
        padding: 12px 0;
        display: inline-flex;
        font-size:16px;
        color: #aaaaaa;
    }
    .fares_item{
        margin: 0  0 0 10px;
        width: 160px;
        box-sizing: border-box;
        text-align: left;
    }
    .fares_price{
        width: 80px;
        font-family: 'Muli', sans-serif;
        text-align: right;
    }
    .fares_item>div,.fares_price>div{
        height: 30px;
        padding: 0px 12px 0 0;
        box-sizing: border-box;
    }
    .subtotal{
        font-size: 18px;
        border-bottom: 2px #cccccc solid;
    }
    #fares_total{
        display: inline-flex;
        margin: 20px 0 40px;
    }
    #fares_total_item{
        width: 60px;
        font-size: 18px;
        color: #333333;
        text-align: left;
    }
    #fares_total_price{
        width: 180px;
        padding: 30px 0 10px;
        font-size: 22px;
        text-align: right;
        color: #333333;
        font-family: 'Muli', sans-serif;
        border-bottom: #333333 2px solid;   
    }

</style>

<%
    TicketOrder to = (TicketOrder) session.getAttribute("ticket_order");
    int bsPage = (Integer) session.getAttribute("bs_page");
    SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfWeekdayName = new SimpleDateFormat("E");
    int[] pricelist = null;
    if (session.getAttribute("pricelist") != null) {
        pricelist = (int[]) session.getAttribute("pricelist");
    }
    NumberFormat priceFormat = new DecimalFormat("$#,###");
%>
<script>
    function classSelectConfirmHandler() {
        var depart_flight_class_value = $("#depart_flight_class_value").val();
        if (depart_flight_class_value.length === 0) {
            alert("請選擇出發航班艙等");
        }
//        alert(depart_flight_class_value);
    <% if (to.getTripType().ordinal() == 0) {%>
        var return_flight_class_value = $("#return_flight_class_value").val();
        if (return_flight_class_value.length === 0) {
            alert("請選擇返回航班艙等");
        }
//        alert(return_flight_class_value);
    <%}%>
    }
</script>

<div style="padding: 10px 20% 10px 0;">
    <div class="booking_summary">
        <div class="summary_title">訂位內容</div>
        <div class="summary_content">

            <div class="summary_date">
                <span><%= sdfDateOnly.format(to.getDepartDate())%>
                </span><%= sdfWeekdayName.format(to.getDepartDate())%>
            </div>
            <div class="summary_detail">
                <div class="takeoff_port">
                    <div><%= to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getTakeoffAirport().name()%></div>
                    <div><%= to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getTakeoffAirport().getCity()%></div>
                    <div><%= to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getTakeoffScheduleTime()%></div>                        
                </div>
                <div class="arrow3"><div><%=to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().name()%></div><img src="/aac/image/arrows/big_gray.png" alt=""/></div>
                <div class="land_port">
                    <div><%=  to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getLandingAirport().name()%></div>
                    <div><%=  to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getLandingAirport().getCity()%></div>
                    <div><%=  to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getLandingScheduleTime()%></div>   
                </div>
            </div>
            <div class="summary_fares">
                <div class="fares_item">
                    <div id="depart_class_name"><%= pricelist == null ? "" : to.getCabinClass()[0].name() + "票價(含稅)"%></div>                    
                </div>
                <div class="fares_price">
                    <div id="depart_class_price_totalamount"><%= pricelist == null ? "" : priceFormat.format(pricelist[1])%></div>
                </div>
            </div>
            <% if (to.getFlightType().ordinal() == 0) {%>
            <div class="summary_date">
                <span><%= sdfDateOnly.format(to.getReturnDate())%>
                </span><%= sdfWeekdayName.format(to.getReturnDate())%>
            </div>
            <div class="summary_detail">
                <div class="takeoff_port">
                    <div><%=  to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getTakeoffAirport().name()%></div>
                    <div><%=  to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getTakeoffAirport().getCity()%></div>
                    <div><%=  to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getTakeoffScheduleTime()%></div>
                </div>
                <div class="arrow3"><div><%=to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().name()%></div><img src="/aac/image/arrows/big_gray.png" alt=""/></div>                                
                <div class="land_port">
                    <div><%=  to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getLandingAirport().name()%></div>
                    <div><%=  to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getLandingAirport().getCity()%></div>
                    <div><%=  to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getLandingScheduleTime()%></div>
                </div>
            </div>
            <div class="summary_fares">
                <div class="fares_item">
                    <div id="return_class_name"><%= pricelist == null ? "" : to.getCabinClass()[1].name() + "票價(含稅)"%></div>                    
                </div>
                <div class="fares_price">
                    <div id="return_class_price_totalamount"><%= pricelist == null ? "" : priceFormat.format(pricelist[2])%></div>
                </div>
            </div>
            <%}%>
            <div id="fares_total">
                <div id="fares_total_item" <%= pricelist == null ? "style='display:none'" : ""%>>總計</div>
                <div id="fares_total_price" <%= pricelist == null ? "style='display:none'" : ""%>><span class="currency"><%= to.getCabinClass() == null ? "" : "TWD"%></span><%= to.getCabinClass() == null ? "" : priceFormat.format(pricelist[0])%> </div>
            </div>

            <div class="button_back_next"  <%= bsPage == 21 ? "style='display:none;'" : ""%>>
                <div class="button" id="back"><span>Back</span></div>
                <input type="submit" class="button" id="next" value=<%= bsPage == 3 ?"Submit":"Next" %> <%= bsPage == 1 ? "onclick='classSelectConfirmHandler()'" : ""%>>
            </div>
        </div>
    </div>
</div>
