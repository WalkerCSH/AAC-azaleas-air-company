<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="aac.domain.dataCategory.FlightRoute"%>
<%@page import="aac.domain.dataCategory.Airport"%>
<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<style>
    #flight_search{
        position: absolute;
        left: 15%;
        display: inline-flex;
    }
    #ticketorder_search{
        position: absolute;

        left: 15%;
        display: inline-flex;
    }
    #search_left{
        width: 220px;
        height: auto;
        background: #ffffff;
        padding: 0;
        z-index: 55;
    }
    #ticketOrderSearch_left{
        width: 220px;
        height: auto;
        background: #ffffff;
        padding: 0;
        z-index: 50;
    }
    .flight_search_title{                
        padding: 8px 35px;
        background: #9999ff;
        box-sizing: border-box;
        color: white;
        cursor: pointer;
    }
    .flight_type{                
        padding: 8px 15px;
        background: #eeeeee;
        box-sizing: border-box;                
    }
    .flight_airport{
        text-align: center;
        padding: 5px 0 0 0;
    }
    .flight_airport select{
        font-size: 14px;
        padding: 4px 18px;
        margin: 10px 0 0 0;
        border-radius: 4px;
    }
    .blank_option{
        color: white;
    }
    #search_right{
        width: auto;
        height: 100%;
        background: white;
        padding: 10px 20px;
        display: flex;
        text-align: center;
        flex-direction: column;
    }
    #ticketOrderSearch_right{
        width: auto;
        height: 100%;
        background: white;
        padding: 10px 20px;
        display: flex;
        text-align: center;
        flex-direction: column;
    }
    #ticketOrderSearch_right input{
        margin: 0px 20px 10px;
        width: 200px;
        box-sizing: border-box;
        border-radius: 4px;
        font-size:14px;
        padding: 6px 14px;
        cursor: pointer;
    }
    .booking_system_search_flight_date{
        text-align: center;
        padding: 0;
        display: flex;
        flex-direction: column;
    }
    .booking_system_search_flight_date input{
        margin: auto;
        width: 200px;
        box-sizing: border-box;
        border-radius: 4px;
        font-size:14px;
        padding: 6px 14px;
        background: no-repeat 90% 4px;
        background-image: url("/aac/image/icon/calender.gif");
        cursor: pointer;
    }    
    .passenger_set{
        list-style: none;
        padding: 0px;
        margin: 8px 0 ;
        display: inline-flex;flex-direction: row;
    }
    .passenger_set li{
        background: #9999ff;
        margin: 0px 4px;
        font-size: 14px;
        padding: 6px 4px;
        text-align: center;
        border-radius: 4px;
        color: white;        
    }
    .passenger_set li input{
        text-align: center;
        color: #6699ff;
        padding: 4px 6px;
        margin: 4px 0;
        cursor: pointer;
        font-size: 18px;
        width: 50px;
    }
    .coupon{
        padding:0;
        margin: 0 0 16px 0;        
    }
    #coupon{
        font-size: 12px;
        padding: 4px 10px;
        border-radius: 4px;
        margin:10px;
        width: 160px;
        cursor: pointer;
        /*        display: none;*/
    }
    .booking_system_search_search_button{
        padding: 10px 0 0;                                
    }
    #booking_search_submit{
        width:180px;
        font-family: 'cwtexhei', serif;
        font-size: 16px;
        padding: 8px 0 8px 34px;
        border-radius: 4px;
        color: white;
        background: #9999ff 12% 50%;
        background-image: url("/aac/image/booking/search_w.png");
        background-repeat: no-repeat;
        background-size:25px;
        cursor: pointer;
    }
    #ticketorder_search_submit{
        margin: auto;
        width:180px;
        font-family: 'cwtexhei', serif;
        font-size: 16px;
        padding: 8px 0 8px 34px;
        border-radius: 4px;
        color: white;
        background: #9999ff 12% 50%;
        background-image: url("/aac/image/booking/search_w.png");
        background-repeat: no-repeat;
        background-size:25px;
        cursor: pointer;
    }
</style>
<script type="text/javascript">
    var searchRight = 0;
    var ticketOrderSearchRight = 0;
    function searchRightOpenHandler() {
        if (searchRight === 0 && ticketOrderSearchRight === 0) {
            $("#search_right").removeAttr("style");
            searchRight = 1;
            event.stopPropagation();
        }
    }
    function searchRightCloseHandler() {
        if (searchRight === 1) {
            $("#search_right").attr("style", "display:none;");
            searchRight = 0;
            event.stopPropagation();
        }
    }
    function roundtripHandler() {
//        alert("roundtripHandler");
        $("#booking_return_date").removeAttr("style");
        $("#booking_return_date").attr("required", "");
    }
    function onewayHandler() {
//        alert("onewayHandler");
        $("#booking_return_date").removeAttr("required");
        $("#booking_return_date").attr("style", "display:none;");
    }
    var destinationArray = [
        {id: 0, name: "TSA", city: "台北"},
        {id: 1, name: "BKK", city: "曼谷"},
        {id: 2, name: "HND", city: "東京"},
        {id: 3, name: "SIN", city: "新加坡"}
    ];
    var departureArray = [
        {id: 0, name: "TSA", destination: [destinationArray[1], destinationArray[2], destinationArray[3]]},
        {id: 1, name: "BKK", destination: [destinationArray[0]]},
        {id: 2, name: "HND", destination: [destinationArray[0]]},
        {id: 3, name: "SIN", destination: [destinationArray[0]]}
    ];
    function departureChangeHandler() {
//        alert("departureChangeHandler");
        $("#dt").attr("style", "display:none;");
        if (($("#departure").val().length > 0)) {
            var departure = $("#departure").val();
            $("#destination").empty();
//            $("#destination").append('<option id=dn class=blank_option value="">想要去哪兒?</option>');
            var destinations = departureArray[departure].destination;
            for (i = 0; i < destinations.length; i++) {
                var optionStr =
                        '<option value="' + destinations[i].id + '">' + destinations[i].name + ' / ' + destinations[i].city + '</option>';
                $("#destination").append(optionStr);
            }
        }
    }
    function destinationChangeHandler() {
//         alert("departureChangeHandler");
        $("#dn").attr("style", "display:none;");
    }
    $(function () {
        var dateFormat = "yy-mm-dd";
        $("#booking_departure_date").datepicker({
            changeMonth: true,
            changeYear: true,
            numberOfMonths: 3,
            showButtonPanel: true,
            minDate: 0, maxDate: "+180D"
        }).on("change", function () {
            var date = $("#booking_departure_date").val();
            $("#booking_return_date").datepicker("option", "minDate", getDate(date));
        });
        $("#booking_return_date").datepicker({
            changeMonth: true,
            changeYear: true,
            numberOfMonths: 3,
            showButtonPanel: true,
            minDate: 0, maxDate: "+180D"
        }).on("change", function () {
            var date = $("#booking_return_date").val();
            $("#booking_departure_date").datepicker("option", "maxDate", getDate(date));
        });
        $("#booking_departure_date").datepicker("option", "dateFormat", "yy-mm-dd");
        $("#booking_return_date").datepicker("option", "dateFormat", "yy-mm-dd");
        function getDate(element) {
            var date;
            try {
                date = $.datepicker.parseDate(dateFormat, element);
            } catch (error) {
                date = null;
            }
            return date;
        }
    });
    function ticketOrderSearchOpenHandler() {
        if (searchRight === 0 && ticketOrderSearchRight === 0) {
            $("#ticketOrderSearch_right").removeAttr("style");
            ticketOrderSearchRight = 1;
            event.stopPropagation();
        }
    }
    function ticketOrderSearchCloseHandler() {
        if (ticketOrderSearchRight === 1) {
            $("#ticketOrderSearch_right").attr("style", "display:none;");
            ticketOrderSearchRight = 0;
            event.stopPropagation();
        }
    }
    var adults = 1;
    var children = 0;
    var infants = 0;
    function numberChecker() {
        adults_input = parseInt($("#adult").val());
        children_input = parseInt($("#child").val());
        infants_input = parseInt($("#infant").val());
        var errors = 0;
        if (adults_input > 4) {
            alert("成人數量不可多於四人。");
            errors++;
        }
        if ((adults_input + children_input) > 4) {
            alert("乘客總數不可超過四人。");
            errors++;
        }
        if (children_input > adults_input) {
            alert("孩童數量不可多於成人。");
            errors++;
        }
        if (infants_input > adults_input) {
            alert("每一位幼童需要一位成人陪伴。");
            errors++;
        }
        if (errors === 0) {
            adults = adults_input;
            children = children_input;
            infants = infants_input;
        }
        $("#adult").val(adults);
        $("#child").val(children);
        $("#infant").val(infants);
//        alert("adults= " + adults + ",child= " + children + ",infant= " + infants);
    }
</script>

<div id="search">
    <form id="flight_search"  method="POST" action="booking_system">
        <div id="search_left">
            <div onclick="searchRightOpenHandler()">
                <div class="flight_search_title">搜尋航班</div>
                <div class="flight_type">
                    <input id="round_trip" type="radio" name="flight_type" value="0" onchange="roundtripHandler()" checked/>
                    <label for="round_trip" style="cursor: pointer;">來回</label>
                    <input id="one-way" type="radio" name="flight_type" value="1" onchange="onewayHandler()"/>
                    <label for="one-way" style="cursor: pointer;">單程</label>
                </div>
                <div class='flight_airport'>
                    <select id='departure' name="departure" style="cursor: pointer;width:155px;" onchange="departureChangeHandler()" required>
                        <option class='blank_option' id="dt" value="">從哪兒出發?</option>
                        <%
                            for (Airport ap : Airport.values()) {
                        %>
                        <option value="<%= ap.ordinal()%>"><%= ap.name()%> / <%= ap.getCity()%></option>
                        <%}%>
                    </select>
                    <select id='destination' name="destination" style="cursor: pointer;width:155px;" onchange="destinationChangeHandler()" required>
                        <option class='blank_option' id="dn" value="">想要去哪兒?</option>                    
                    </select>
                    <div class="coupon">
                        <input type="text" id="coupon" name="coupon" placeholder="優惠代碼 敬請期待" readonly="">
                    </div>                
                </div>
            </div>
            <div class="flight_search_title" onclick="ticketOrderSearchOpenHandler()"><!--a href="ticketorder_search.jsp" style="text-decoration: none;color: white;"--> 查詢訂單<!--/a--></div>
        </div>
        <div id="search_right" style="display:none;">
            <img src="<%=request.getContextPath()%>/image/icon/btn_close.png" style="width:20px;height: 20px;cursor: pointer;" onclick="searchRightCloseHandler()" alt=""/>
            <div class="booking_system_search_flight_date">                
                <input type="text" autocomplete="off" id="booking_departure_date" name="booking_departure_date" placeholder="何時出發" required>
                <input type="text" autocomplete="off" id="booking_return_date" name="booking_return_date" placeholder="何時返回" required>                
            </div>
            <ul class="passenger_set">
                <li id="passenger_set_adult" >
                    <div>成人</div>
                    <input type="number" id="adult" name="adult" max="4" min="1" value="1" onchange="numberChecker()">
                    <div>12+</div>
                </li>
                <li id="passenger_set_child">
                    <div>孩童</div>
                    <input type="number" id="child" name="child" max="4" min="0" value="0" onchange="numberChecker()">
                    <div>2~11</div>
                </li>
                <li id="passenger_set_infant">
                    <div>幼童</div>
                    <input type="number" id="infant" name="infant" max="4" min="0" value="0" onchange="numberChecker()">
                    <div>0~1</div>
                </li>
            </ul>            
            <div class="booking_system_search_search_button">                                            
                <input type="submit" id="booking_search_submit" value="搜尋航班" name="booking_search_submit">
            </div>
        </div>
    </form>
    <form id="ticketorder_search" method="POST" action="ticketorder_search">
        <div id="ticketOrderSearch_left"></div>
        <div id='ticketOrderSearch_right' style="display:none;" >
            <img src="<%=request.getContextPath()%>/image/icon/btn_close.png" style="width:20px;height: 20px;" onclick="ticketOrderSearchCloseHandler()" alt=""/>
            <input type="text" autocomplete="off" id="tickerorder_ordernumber" name="tickerorder_ordernumber" placeholder="請輸入訂位代號" required="">
            <input type="text" autocomplete="off" id="tickerorder_email" name="tickerorder_email" placeholder="請輸入連絡電子郵件信箱" required="">
            <input type="submit" id='ticketorder_search_submit' value="查詢訂單內容" >
        </div>
    </form>
</div>

