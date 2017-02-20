<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="aac.domain.PassengerList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="aac.domain.PriceSheet"%>
<%@page import="aac.model.PriceSheetServices"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="aac.domain.dataCategory.CabinClass"%>
<%@page import="aac.domain.TicketOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<style>
    .flight_table{
        background: white;
        height: auto;
    }
    .departure_flight,.return_flight{                               
        width: 660px;
        margin: 20px 0 ;
        display: inline-block;
    }            

    .flight_route{
        width: inherit;
        box-sizing: border-box;
        display: inline-flex;
        font-size: 20px;
        background: #888888;
        color: white;
        padding: 4px 12px;
    }
    .status_icon img{
        height: 28px;
    }
    .flight_route>div{
        margin: 8px 4px 0;
    }
    .flight_route>div span{
        padding: 0 2px;
    }
    .flight_route>div>span:first-child{
        font-family: 'Muli', sans-serif;
    }

    .week_schedule{
        width: inherit;
        box-sizing: border-box;
        display: inline-flex;
        background: #e2deff;
        padding: 8px 4px;
    }
    .week_arrow{
        padding: 31px 2px;
        margin: 0 2px;
        background: #ffffff;
        cursor: pointer;
    }
    .week_arrow img{
        height: 16px;
    }
    .weekday{
        border: #ffffff 2px solid;
        width: 82px;
        font-size: 18px;
        margin: 0 2px;
        padding: 4px;
        color: #222222;
        font-family: 'Muli', sans-serif;
        cursor: pointer;
    }            
    .weekday>div:nth-child(2){
        font-size:16px;
        color: #666666;
        font-family: 'cwtexhei', serif;
    }
    .weekday_selected{
        border: #ffffff 2px solid;
        width: 82px;
        font-size: 18px;
        margin: 0 2px;
        padding: 4px;
        color: #ffffff;
        font-family: 'Muli', sans-serif;
        background: #3a3eff;
        cursor: pointer;
    }
    .weekday_selected>div:nth-child(2){
        font-size:16px;
        color: #dddddd;
        font-family: 'cwtexhei', serif;
    }

    .date_and_flight_class{
        width: inherit;
        box-sizing: border-box;
        display: inline-flex;
        border: #e2deff 2px solid;                
        font-size: 20px;
        padding: 8px 4px;
    }
    .date_and_flight_class>div{
        margin: 0 6px;
    }
    .date_and_flight_class>div:last-child{
        display:-webkit-flex;
        margin:  0 10px 0 49px;
    }
    .date_and_flight_class>div:last-child>div{
        width: 130px;
        box-sizing: border-box;
        padding: 0 6px;
        border-bottom: red 2px solid;
    }

    .flight{
        width: inherit;
        box-sizing: border-box;
        font-size: 18px;
        font-family: 'Muli', sans-serif;
        display: inline-flex;
        padding: 8px 4px;
        border: #e2deff 2px solid;
        border-top: none;
        box-sizing: border-box;
        background: #c8c5fe;
    }
    .flight_even{
        width: inherit;
        box-sizing: border-box;
        font-size: 18px;
        font-family: 'Muli', sans-serif;
        display: inline-flex;
        padding: 8px 4px;
        border: #e2deff 2px solid;
        border-top: none;
        box-sizing: border-box;
        background: #e2deff;
    }
    .flight>div{
        margin: 0 6px;                 
    }
    .flight>div:last-child{
        display:-webkit-flex;
        margin:  0 10px 0 56px;
    }
    .flight>div:last-child>div{
        padding: 0 10px 0 0px;
        border-bottom: red 2px solid;
        width: 130px;
    }
    .flight_number{
        width: 50px;
        box-sizing: border-box;
    }
    .flight_schedule{        
        box-sizing: border-box;
    }
    .fares_flight_class{
        width: 90px;
        box-sizing: border-box;
    }
    .fares_flight_class>span{
        cursor: pointer;
    }
    .fares_flight_class>img{
        /*                width: 12px;*/
        height: 16px;
        margin: 0 4px;
        cursor: pointer;
    }

</style>
<%
    PassengerList pl = (PassengerList) session.getAttribute("passenger_list");
    TicketOrder to = (TicketOrder) session.getAttribute("ticket_order");
    List<String> errors = (ArrayList) session.getAttribute("errors");
%>
<script>
    <% if (errors!=null && !errors.isEmpty()) {
            for (String error : errors) {%>
    alert("<%= error%>");
    <%}
        }%>
    function priceStrIntChanger(unitStr) {
        unitStr = unitStr.replace("$", "");
        unitStr = unitStr.replace(",", "");
//        alert(unitStr);
        var unitPrice = parseInt(unitStr);
//        alert(unitPrice * 2);
        return unitPrice;
    }

    var departClassArr = ["depart_glory", "depart_fancy", "depart_happy"];
    var departClassImgArr = ["depart_glory_img", "depart_fancy_img", "depart_happy_img"];
    var depart_price_totalamount;
    function checkDepartGloryFunctioner() {
        for (var i = 0; i < departClassArr.length; i++) {
            $("#" + departClassImgArr[i]).attr("src", "/aac/image/icon/uncheck.png");
        }
        $("#" + departClassImgArr[0]).attr("src", "/aac/image/icon/check.png");
        $("#depart_flight_class_value").val(0);
        var unitStr = $("#depart_glory_price").text();
        var unitPrice = priceStrIntChanger(unitStr);
        depart_price_totalamount = unitPrice *<%=pl.getAdultNumber()%> +
                unitPrice * 0.5 * <%=pl.getChildNumber()%> + unitPrice * 0.1 * <%=pl.getInfantNumber()%>;
        var price_totalamountStr = "$" + moneyFormater(depart_price_totalamount);
        $("#depart_class_name").text("GLORY票價(含稅)");
        $("#depart_class_price_totalamount").text(price_totalamountStr);
        faresTotalPriceComputer();
    }
    function checkDepartFancyFunctioner() {
        for (var i = 0; i < departClassArr.length; i++) {
            $("#" + departClassImgArr[i]).attr("src", "/aac/image/icon/uncheck.png");
        }
        $("#" + departClassImgArr[1]).attr("src", "/aac/image/icon/check.png");
        $("#depart_flight_class_value").val(1);
        var unitStr = $("#depart_fancy_price").text();
        var unitPrice = priceStrIntChanger(unitStr);
        depart_price_totalamount = unitPrice *<%=pl.getAdultNumber()%> +
                unitPrice * 0.5 * <%=pl.getChildNumber()%> + unitPrice * 0.1 * <%=pl.getInfantNumber()%>;
        var price_totalamountStr = "$" + moneyFormater(depart_price_totalamount);
        $("#depart_class_name").text("FANCY票價(含稅)");
        $("#depart_class_price_totalamount").text(price_totalamountStr);
        faresTotalPriceComputer();
    }
    function checkDepartHappyFunctioner() {
        for (var i = 0; i < departClassArr.length; i++) {
            $("#" + departClassImgArr[i]).attr("src", "/aac/image/icon/uncheck.png");
        }
        $("#" + departClassImgArr[2]).attr("src", "/aac/image/icon/check.png");
        $("#depart_flight_class_value").val(2);
        var unitStr = $("#depart_happy_price").text();
        var unitPrice = priceStrIntChanger(unitStr);
        depart_price_totalamount = unitPrice *<%=pl.getAdultNumber()%> +
                unitPrice * 0.5 * <%=pl.getChildNumber()%> + unitPrice * 0.1 * <%=pl.getInfantNumber()%>;
        var price_totalamountStr = "$" + moneyFormater(depart_price_totalamount);
        $("#depart_class_name").text("HAPPY票價(含稅)");
        $("#depart_class_price_totalamount").text(price_totalamountStr);
        faresTotalPriceComputer();
    }

    var returnClassArr = ["return_glory", "return_fancy", "return_happy"];
    var returnClassImgArr = ["return_glory_img", "return_fancy_img", "return_happy_img"];
    var return_price_totalamount;
    function checkReturnGloryFunctioner() {
        for (var i = 0; i < returnClassArr.length; i++) {
            $("#" + returnClassImgArr[i]).attr("src", "/aac/image/icon/uncheck.png");
        }
        $("#" + returnClassImgArr[0]).attr("src", "/aac/image/icon/check.png");
        $("#return_flight_class_value").val(0);
        var unitStr = $("#return_glory_price").text();
        var unitPrice = priceStrIntChanger(unitStr);
        return_price_totalamount = unitPrice *<%=pl.getAdultNumber()%> +
                unitPrice * 0.5 * <%=pl.getChildNumber()%> + unitPrice * 0.1 * <%=pl.getInfantNumber()%>;
        var price_totalamountStr = "$" + moneyFormater(return_price_totalamount);
        $("#return_class_name").text("GLORY票價(含稅)");
        $("#return_class_price_totalamount").text(price_totalamountStr);
        faresTotalPriceComputer();
    }
    function checkReturnFancyFunctioner() {
        for (var i = 0; i < returnClassArr.length; i++) {
            $("#" + returnClassImgArr[i]).attr("src", "/aac/image/icon/uncheck.png");
        }
        $("#" + returnClassImgArr[1]).attr("src", "/aac/image/icon/check.png");
        $("#return_flight_class_value").val(1);
        var unitStr = $("#return_fancy_price").text();
        var unitPrice = priceStrIntChanger(unitStr);
        return_price_totalamount = unitPrice *<%=pl.getAdultNumber()%> +
                unitPrice * 0.5 * <%=pl.getChildNumber()%> + unitPrice * 0.1 * <%=pl.getInfantNumber()%>;
        var price_totalamountStr = "$" + moneyFormater(return_price_totalamount);
        $("#return_class_name").text("FANCY票價(含稅)");
        $("#return_class_price_totalamount").text(price_totalamountStr);
        faresTotalPriceComputer();
    }
    function checkReturnHappyFunctioner() {
        for (var i = 0; i < returnClassArr.length; i++) {
            $("#" + returnClassImgArr[i]).attr("src", "/aac/image/icon/uncheck.png");
        }
        $("#" + returnClassImgArr[2]).attr("src", "/aac/image/icon/check.png");
        $("#return_flight_class_value").val(2);
        var unitStr = $("#return_happy_price").text();
        var unitPrice = priceStrIntChanger(unitStr);
        return_price_totalamount = unitPrice *<%=pl.getAdultNumber()%> +
                unitPrice * 0.5 * <%=pl.getChildNumber()%> + unitPrice * 0.1 * <%=pl.getInfantNumber()%>;
        var price_totalamountStr = "$" + moneyFormater(return_price_totalamount);
        $("#return_class_name").text("HAPPY票價(含稅)");
        $("#return_class_price_totalamount").text(price_totalamountStr);
        faresTotalPriceComputer();
    }
    var fares_total_price;
    function faresTotalPriceComputer() {
        var departprice = "0";
        departprice = $("#depart_class_price_totalamount").text();
        var returnprice = "0";
        if (<%=to.getTripType().ordinal()%> === 0) {
            returnprice = $("#return_class_price_totalamount").text();
        }
        fares_total_price = priceStrIntChanger(departprice) + priceStrIntChanger(returnprice);
//        alert(fares_total_price);
        if (fares_total_price > 0) {
            $("#fares_total_price").text("TWD$" + moneyFormater(fares_total_price));
            $("#fares_total_item").removeAttr("style");
            $("#fares_total_price").removeAttr("style");
        }
    }

    function departDateChangeHandler(date) {
        $.ajax({
            url: "flight_select.jsp",
            method: "POST",
            data: {departDateStr: date}
        }).done(doneHandler);
    }
    function returnDateChangeHandler(date) {
        $.ajax({
            url: "flight_select.jsp",
            method: "POST",
            data: {returnDateStr: date}
        }).done(doneHandler);
    }
    function doneHandler() {
        location.replace(location);
        // 參考資料-畫面更新 : http://blog.yam.com/htshboy/article/12692684
    }    
    function moneyFormater(number) {
        var num = number.toString();
        var pattern = /(-?\d+)(\d{3})/;
        while (pattern.test(num))
        {
            num = num.replace(pattern, "$1,$2");
        }
        return num;
    }
    // 資料來源 : http://bioankeyang.blogspot.tw/2014/04/jsjavascript.html
</script>
<%
    session.setAttribute("bs_page", 1);
    int totalPassengers = pl.getAdultNumber() + pl.getChildNumber();
%>

<div style="padding: 10px 0 10px 15%;">
    <div class="booking_system_content">        
        <div class="flight_table">
            <div class="booking_system_title">
                <div class="booking_system_title_name">選擇您的航班</div>                                
            </div>
            <div class="departure_flight">                        
                <div class="flight_route">
                    <div class="status_icon"><img src="/aac/image/booking/flight_takeoff_w.png" alt=""/></div>
                    <div class="takeoff"><%= to.getDepartFlightRoute().getTakeoffAirport().name()%> <%= to.getDepartFlightRoute().getTakeoffAirport().getCity()%></div>
                    <div class="direction"><img src="/aac/image/arrows/big_white.png" alt=""/></div>                    
                    <div class="land"><%= to.getDepartFlightRoute().getLandingAirport().name()%> <%= to.getDepartFlightRoute().getLandingAirport().getCity()%></div>
                    <div class="status_icon"><img src="/aac/image/booking/flight_land_w.png" alt=""/></div>
                </div>
                <div class="week_schedule">

                    <%
                        SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy-MM-dd");
                        Date departDate = to.getDepartDate();
                        Calendar calWeek = new GregorianCalendar();
                        calWeek.setTime(departDate);
                        calWeek.add(Calendar.DATE, -7);
                        Date today = new Date();
                    %>
                    <div class="week_arrow" onclick="departDateChangeHandler('<%= calWeek.getTime().compareTo(today) < 0 ? sdfDateOnly.format(today) : sdfDateOnly.format(calWeek.getTime())%>')"><img src="/aac/image/arrows/step_blue_heavy_left.png" alt=""/></div>
                        <%
                            Calendar cal = new GregorianCalendar();
                            cal.setTime(departDate);

                            SimpleDateFormat sdfMdOnly = new SimpleDateFormat("MM-dd");
                            SimpleDateFormat sdfWeekdayName = new SimpleDateFormat("E");
                            while (!(cal.get(Calendar.DAY_OF_WEEK) == 1)) {
                                cal.add(Calendar.DATE, -1);
                            }
                            NumberFormat priceFormat = new DecimalFormat("$#,###");
                            PriceSheetServices pss = new PriceSheetServices();
                            PriceSheet ps;
                        %>
                        <% for (int i = 0; i < 7; i++) {%>                    
                    <div class="<%= departDate.equals(cal.getTime()) ? "weekday_selected" : "weekday"%>" onclick="departDateChangeHandler('<%= sdfDateOnly.format(cal.getTime())%>')">
                        <div class="date"><%= sdfMdOnly.format(cal.getTime())%></div>
                        <div><%= sdfWeekdayName.format(cal.getTime())%></div>
                        <%
                            ps = pss.getPriceByDateAndFlightRoute(cal.getTime(), to.getDepartFlightRoute());
                        %>
                        <div class="fares"><%= ps != null ? priceFormat.format(ps.getHappyPrice()) : "1,300"%></div>
                    </div>
                    <%cal.add(Calendar.DATE, 1);
                        }%>
                    <%
                        calWeek.add(Calendar.DATE, 14);
                    %>
                    <div class="week_arrow" id="depart_next_week_arrow" onclick="departDateChangeHandler('<%=sdfDateOnly.format(calWeek.getTime())%>')"><img src="/aac/image/arrows/step_blue_heavy.png" alt=""/></div>
                </div>
                <div class="date_and_flight_class">
                    <div class="date_selected" style="font-family: 'Muli', sans-serif;"><%= sdfDateOnly.format(departDate)%></div>
                    <div class="weekday_responded"><%= sdfWeekdayName.format(departDate)%></div>
                    <div>
                        <div class="fares_flight_class">GLORY</div>
                        <div class="fares_flight_class">FANCY</div>                                    
                        <div class="fares_flight_class">HAPPY</div>
                    </div>                            
                </div>
                <div class="flight">
                    <div class="flight_number"><%= to.getDepartFlightRoute().name()%></div>
                    <div class="flight_schedule">
                        <%= to.getDepartFlightRoute().getTakeoffScheduleTime()%> / <%= to.getDepartFlightRoute().getLandingScheduleTime()%>
                    </div>
                    <div>
                        <%  ps = pss.getPriceByDateAndFlightRoute(departDate, to.getDepartFlightRoute());%>
                        <input type="text" style="width:10px;height: 10px;display: none" id="depart_flight_class_value" name="depart_flight_class_value" required>
                        <div class="fares_flight_class" id="depart_glory" onclick="checkDepartGloryFunctioner()">                            
                            <img id="depart_glory_img" src="/aac/image/icon/uncheck.png" alt=""/>
                            <span id="depart_glory_price"><%= priceFormat.format(ps.getGloryPrice())%></span>
                        </div>
                        <div class="fares_flight_class" id="depart_fancy"  onclick="checkDepartFancyFunctioner()">                           
                            <img id="depart_fancy_img" src="/aac/image/icon/uncheck.png" alt=""/>
                            <span id="depart_fancy_price"><%= priceFormat.format(ps.getFancyPrice())%></span>
                        </div>
                        <div class="fares_flight_class" id="depart_happy"  onclick="checkDepartHappyFunctioner()">                            
                            <img id="depart_happy_img" src="/aac/image/icon/uncheck.png" alt=""/>
                            <span id="depart_happy_price"><%= priceFormat.format(ps.getHappyPrice())%></span>
                        </div>
                    </div>
                </div>                        
            </div>
            <% if (to.getFlightType().ordinal() == 0) {%>
            <div class="return_flight">
                <div class="flight_route">
                    <div class="status_icon"><img src="/aac/image/booking/flight_takeoff_w.png" alt=""/></div>
                    <div class="takeoff"><%= to.getReturnFlightRoute().getTakeoffAirport().name()%> <%= to.getReturnFlightRoute().getTakeoffAirport().getCity()%></div>
                    <div class="direction"><img src="/aac/image/arrows/big_white.png" alt=""/></div>                    
                    <div class="land"><%= to.getReturnFlightRoute().getLandingAirport().name()%> <%= to.getReturnFlightRoute().getLandingAirport().getCity()%></div>
                    <div class="status_icon"><img src="/aac/image/booking/flight_land_w.png" alt=""/></div>
                </div>
                <div class="week_schedule">
                    <%
                        Date returnDate = to.getReturnDate();
                        calWeek.setTime(returnDate);
                        calWeek.add(Calendar.DATE, -7);
                    %>
                    <div class="week_arrow" onclick="returnDateChangeHandler('<%= calWeek.getTime().compareTo(today) < 0 ? sdfDateOnly.format(today) : sdfDateOnly.format(calWeek.getTime())%>')"><img src="/aac/image/arrows/step_blue_heavy_left.png" alt=""/></div>
                        <%
                            cal.setTime(returnDate);
                            //SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy/MM/dd");
                            //SimpleDateFormat sdfMdOnly = new SimpleDateFormat("MM/dd");
                            //SimpleDateFormat sdfWeekdayName = new SimpleDateFormat("E");
                            while (!(cal.get(Calendar.DAY_OF_WEEK) == 1)) {
                                cal.add(Calendar.DATE, -1);
                            }
                            //NumberFormat priceFormat = new DecimalFormat("$#,###");;
                            //PriceSheetServices pss = new PriceSheetServices();
                            //PriceSheet ps;
                        %>
                        <% for (int i = 0; i < 7; i++) {%>
                    <div class="<%= returnDate.equals(cal.getTime()) ? "weekday_selected" : "weekday"%>" onclick="returnDateChangeHandler('<%= sdfDateOnly.format(cal.getTime())%>')">
                        <div class="date"><%= sdfMdOnly.format(cal.getTime())%></div>
                        <div class="sunday"><%= sdfWeekdayName.format(cal.getTime())%></div>
                        <%
                            ps = pss.getPriceByDateAndFlightRoute(cal.getTime(), to.getReturnFlightRoute());
                        %>
                        <div class="fares"><%= ps != null ? priceFormat.format(ps.getHappyPrice()) : "1,300"%></div>
                    </div>
                    <%cal.add(Calendar.DATE, 1);
                        }%>
                    <%
                        calWeek.add(Calendar.DATE, 14);
                    %>
                    <div class="week_arrow" onclick="returnDateChangeHandler('<%=sdfDateOnly.format(calWeek.getTime())%>')"><img src="/aac/image/arrows/step_blue_heavy.png" alt=""/></div>
                </div>
                <div class="date_and_flight_class">
                    <div class="date_selected" style="font-family: 'Muli', sans-serif;"><%= sdfDateOnly.format(returnDate)%></div>
                    <div class="weekday_responded"><%= sdfWeekdayName.format(returnDate)%></div>
                    <div>
                        <div class="fares_flight_class">GLORY</div>
                        <div class="fares_flight_class">FANCY</div>                                    
                        <div class="fares_flight_class">HAPPY</div>
                    </div>                            
                </div>
                <div class="flight">
                    <div class="flight_number"><%= to.getReturnFlightRoute().name()%></div>
                    <div class="flight_schedule">
                        <%= to.getReturnFlightRoute().getTakeoffScheduleTime()%> / <%= to.getReturnFlightRoute().getLandingScheduleTime()%>
                    </div>
                    <div>
                        <%  ps = pss.getPriceByDateAndFlightRoute(departDate, to.getReturnFlightRoute());%>
                        <input type="text" style="width:10px;height: 10px;display: none" id="return_flight_class_value" name="return_flight_class_value" required>
                        <div class="fares_flight_class" id="return_glory" onclick="checkReturnGloryFunctioner()">                            
                            <img id="return_glory_img" src="/aac/image/icon/uncheck.png" alt=""/>
                            <span id="return_glory_price"><%= priceFormat.format(ps.getGloryPrice())%></span>
                        </div>
                        <div class="fares_flight_class" id="return_fancy"  onclick="checkReturnFancyFunctioner()">                           
                            <img id="return_fancy_img" src="/aac/image/icon/uncheck.png" alt=""/>
                            <span id="return_fancy_price"><%= priceFormat.format(ps.getFancyPrice())%></span>
                        </div>
                        <div class="fares_flight_class" id="return_happy"  onclick="checkReturnHappyFunctioner()">                            
                            <img id="return_happy_img" src="/aac/image/icon/uncheck.png" alt=""/>
                            <span id="return_happy_price"><%= priceFormat.format(ps.getHappyPrice())%></span>
                        </div>
                    </div>
                </div> 
            </div>
            <%}%>
        </div>        
    </div>
</div>
