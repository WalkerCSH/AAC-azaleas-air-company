<%@page import="aac.domain.flight.SeatDistribute"%>
<%@page import="aac.domain.Flight"%>
<%@page import="aac.model.service.FlightSellingStatusServices"%>
<%@page import="aac.domain.PassengerList"%>
<%@page import="aac.domain.dataCategory.CabinClass"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="aac.domain.TicketOrder"%>
<%@page import="aac.domain.dataCategory.Aircraft"%>
<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%
    TicketOrder to = (TicketOrder) session.getAttribute("ticket_order");
%>
<link href="/aac/asset/css/seats_select_design.css" rel="stylesheet" type="text/css"/>
<style>
    <%
        FlightSellingStatusServices fsss = new FlightSellingStatusServices();
        Flight departFlight = new Flight(to.getDepartDate(), to.getDepartFlightRoute());
        Flight returnFlight = null;
        departFlight = fsss.search(departFlight.getId());
        if (to.getTripType().ordinal() == 0) {
            returnFlight = new Flight(to.getReturnDate(), to.getReturnFlightRoute());
            returnFlight = fsss.search(returnFlight.getId());
        }
        Aircraft typename = departFlight.getType() != null ? departFlight.getType() : Aircraft.A330;
        int seatsGloryCol = typename.getGloryCapacity() / typename.getGloryColumns();
        int seatsFancyCol = typename.getFancyCapacity() / typename.getFancyColumns();
        int seatsHappyCol = typename.getHappyCapacity() / typename.getHappyColumns();
        int aislesGlory = typename.getGloryAisle();
        int aislesFancy = typename.getFancyAisle();
        int aislesHappy = typename.getHappyAisle();
    %>
    <% int gloryRow = 50;%>   
    .glory_seats_area{
        position:relative;
        top: 50px;
        margin: auto;
        padding: 50px 0 0;
        width: 340px;
        height: <%= (seatsGloryCol + aislesGlory) * gloryRow%>px;
        display: inline-flex;
    }
    .glory_aisle_row{
        height: <%= gloryRow - 10%>px;
        margin: 5px 0;
        background: #dddddd;
        box-sizing:border-box;
    }
    <% int fancyRow = 40;%>
    .fancy_seats_area{
        position:relative;
        top: 50px;
        margin: auto;
        padding: 50px 0 0;
        width: 340px;
        height: <%= (seatsFancyCol + aislesFancy) * fancyRow%>px;
        display: inline-flex;
    }
    .fancy_aisle_row{
        height:<%=  fancyRow%>px;
        margin: 5px 0;
        background: #dddddd;
        box-sizing:border-box;
    }    
    #shift_menu{
        display: <%= to.getTripType().ordinal() == 1 ? "none" : "block"%>;
        width: 400px;
        position: relative;
        left: 25%;
    }
    .shift_menu_button{
        cursor: pointer;
    }
    .shift_menu_button_clicked{
        border:#003eff 2px solid;
        padding:12px 16px 0 14px;
        border-radius: 15px;
    }

    <% int happyRow = 40;%>
    .happy_seats_area{
        position:relative;
        top: 50px;
        margin: auto;
        padding: 50px 0 0;
        width: 340px;
        height: <%= (seatsHappyCol + aislesHappy) * happyRow%>px;
        display: inline-flex;
    }
    .happy_aisle_row{
        height:<%= happyRow - 10%>px;
        margin: 5px 0;
        background: #dddddd;
        box-sizing:border-box;
    }
    .direction{
         position: relative;
         top:-2px;
    }
</style>
<%
    session.setAttribute("bs_page", 21);
    if (to.getCabinClass() == null) {
        CabinClass[] cc = {CabinClass.HAPPY, CabinClass.HAPPY};
        to.setCabinClass(cc);
    }
    PassengerList pl = (PassengerList) session.getAttribute("passenger_list");
    int totalPassengers = pl.getAdultNumber() + pl.getChildNumber();
%>
<script type="text/javascript">
    $(document).ready(readyHandler);
    function readyHandler() {

        var SeatsArea = ["G", "F", "H"];
        var colNameArr = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K"];
        var gloryColArr = ["A", "left", "E", "F", "right", "K"];
        var fancyColArr = ["A", "B", "left", "E", "F", "right", "J", "K"];
        var happyColArr = ["A", "B", "C", "left", "D", "E", "F",
            "G", "right", "H", "J", "K"];

    <% for (int i = 0; i < SeatDistribute.getColName().length; i++) {%>
    <%= "var depart_column_" + SeatDistribute.getColName()[i] + " = '"
            + departFlight.getSeatDistribute().getColBinStr(SeatDistribute.getColName()[i]) + "';"%>
    <% if (to.getTripType().ordinal() == 0) {%>
    <%= "var return_column_" + SeatDistribute.getColName()[i] + " = '"
            + returnFlight.getSeatDistribute().getColBinStr(SeatDistribute.getColName()[i]) + "';"%>
    <%}%>
    <% }%>
        function getSeatStatusIsAvailable(colName, colIndex) {
            var seatDistribute = "";
            switch (colName) {
                case 'A':
                    seatDistribute = depart_column_A;
                    break;
                case 'B':
                    seatDistribute = depart_column_B;
                    break;
                case 'C':
                    seatDistribute = depart_column_C;
                    break;
                case 'D':
                    seatDistribute = depart_column_D;
                    break;
                case 'E':
                    seatDistribute = depart_column_E;
                    break;
                case 'F':
                    seatDistribute = depart_column_F;
                    break;
                case 'G':
                    seatDistribute = depart_column_G;
                    break;
                case 'H':
                    seatDistribute = depart_column_H;
                    break;
                case 'J':
                    seatDistribute = depart_column_J;
                    break;
                case 'K':
                    seatDistribute = depart_column_K;
                    break;
            }
            var status = seatDistribute.charAt(colIndex - 1);
            if (status === '0') {
                return true;
            } else {
                return false;
            }
        }

        function getReturnSeatStatusIsAvailable(colName, colIndex) {
            var seatDistribute = "";
            switch (colName) {
                case 'A':
                    seatDistribute = return_column_A;
                    break;
                case 'B':
                    seatDistribute = return_column_B;
                    break;
                case 'C':
                    seatDistribute = return_column_C;
                    break;
                case 'D':
                    seatDistribute = return_column_D;
                    break;
                case 'E':
                    seatDistribute = return_column_E;
                    break;
                case 'F':
                    seatDistribute = return_column_F;
                    break;
                case 'G':
                    seatDistribute = return_column_G;
                    break;
                case 'H':
                    seatDistribute = return_column_H;
                    break;
                case 'J':
                    seatDistribute = return_column_J;
                    break;
                case 'K':
                    seatDistribute = return_column_K;
                    break;
            }
            var status = seatDistribute.charAt(colIndex - 1);
            if (status === '0') {
                return true;
            } else {
                return false;
            }
        }

        for (var i = 0; i < <%=CabinClass.values().length%>; i++) {
            var seatOrderNumberGloryOrigin;
            var seatOrderNumberFancyOrigin;
            var seatOrderNumberHappyOrigin;
            if (SeatsArea[i] === "G") {
                seatOrderNumberGloryOrigin = 0;
//                alert("seatOrderNumberGloryOrigin = " + seatOrderNumberGloryOrigin);
                $("#depart_seats_map>div:first-child")
                        .append("<div class=\"glory_seats_area\" id=depart_seats_area" + SeatsArea[i] + "></div>");
                for (var j = 0; j < gloryColArr.length; j++) {
                    var seatOrderNumberGlory = seatOrderNumberGloryOrigin;
                    if (gloryColArr[j] === "left") {
                        $("#depart_seats_area" + SeatsArea[i]).
                                append("<div class=\"glory_aisle\" id=depart_glory_aisle_" +
                                        gloryColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else if (gloryColArr[j] === "right") {
                        $("#depart_seats_area" + SeatsArea[i]).
                                append("<div class=\"glory_aisle\" id=depart_glory_aisle_" +
                                        gloryColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else {
                        var sah = $(".glory_seats_area").height();
                        var gloryColSeatNum = <%= seatsGloryCol + aislesGlory%>;
                        $("#depart_seats_area" + SeatsArea[i]).
                                append("<div class=\"glory_colunm\" id=depart_glory_colunm_" +
                                        gloryColArr[j] + "_at_" + SeatsArea[i] + "></div>");
                        for (var k = 1; k <= gloryColSeatNum; k++) {
                            if (k % 2 === 0) {
                                $("#depart_glory_colunm_" + gloryColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<div class='glory_aisle_row' id=></div>");
                            } else {
                                $("#depart_glory_colunm_" + gloryColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<input type='text' readonly class='depart_seat_luxury_<%= to.getCabinClass()[0].ordinal() == 0 ? "available" : "banned"%>' id=depart" +
                                                SeatsArea[i] + gloryColArr[j] + ++seatOrderNumberGlory + " value=" + gloryColArr[j] + seatOrderNumberGlory + ">");
                            }
                        }
                    }
                }
//                alert("seatOrderNumberGlory = " + seatOrderNumberGlory);
                seatOrderNumberFancyOrigin = seatOrderNumberGlory;
            } else if (SeatsArea[i] === "F") {
//                alert("seatOrderNumberFancyOrigin = " + seatOrderNumberFancyOrigin);
                var seatOrderNumberFancy = seatOrderNumberFancyOrigin;
                $("#depart_seats_map>div:first-child")
                        .append("<div class=\"fancy_seats_area\" id=depart_seats_area" + SeatsArea[i] + "></div>");
                for (var j = 0; j < fancyColArr.length; j++) {
                    seatOrderNumberFancy = seatOrderNumberFancyOrigin;
                    if (fancyColArr[j] === "left") {
                        $("#depart_seats_area" + SeatsArea[i]).
                                append("<div class=\"fancy_aisle\" id=depart_fancy_aisle_" +
                                        fancyColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else if (fancyColArr[j] === "right") {
                        $("#depart_seats_area" + SeatsArea[i]).
                                append("<div class=\"fancy_aisle\" id=depart_fancy_aisle_" +
                                        fancyColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else {
                        var sah = $(".fancy_seats_area").height();
                        var fancyColSeatNum = <%= seatsFancyCol + aislesFancy%>;
                        $("#depart_seats_area" + SeatsArea[i]).
                                append("<div class=\"fancy_colunm\" id=depart_fancy_colunm_" +
                                        fancyColArr[j] + "_at_" + SeatsArea[i] + "></div>");
                        for (var k = 1; k <= fancyColSeatNum; k++) {
                            if (k % 6 === 0) {
                                $("#depart_fancy_colunm_" + fancyColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<div class='fancy_aisle_row' id=></div>");
                            } else {
                                $("#depart_fancy_colunm_" + fancyColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<input type='text' readonly class='depart_seat_normal_<%= to.getCabinClass()[0].ordinal() == 1 ? "available" : "banned"%>' id=depart" +
                                                SeatsArea[i] + fancyColArr[j] + ++seatOrderNumberFancy + " value=" + fancyColArr[j] + seatOrderNumberFancy + ">");
                            }
                        }
                    }
                }
//                alert("seatOrderNumberFancy = " + seatOrderNumberFancy);
                seatOrderNumberHappyOrigin = seatOrderNumberFancy;
            } else {
//                alert("seatOrderNumberHappyOrigin = " + seatOrderNumberHappyOrigin);
                var seatOrderNumberHappy = seatOrderNumberHappyOrigin;
                $("#depart_seats_map>div:first-child")
                        .append("<div class=\"happy_seats_area\" id=depart_seats_area" + SeatsArea[i] + "></div>");
                for (var j = 0; j < happyColArr.length; j++) {
                    seatOrderNumberHappy = seatOrderNumberHappyOrigin;
                    if (happyColArr[j] === "left") {
                        $("#depart_seats_area" + SeatsArea[i]).
                                append("<div class=\"happy_aisle\" id=depart_happy_aisle_" +
                                        happyColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else if (happyColArr[j] === "right") {
                        $("#depart_seats_area" + SeatsArea[i]).
                                append("<div class=\"happy_aisle\" id=depart_happy_aisle_" +
                                        happyColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else {
                        var sah = $(".happy_seats_area").height();
                        var happyColSeatNum = sah / 40;
                        $("#depart_seats_area" + SeatsArea[i]).
                                append("<div class=\"happy_colunm\" id=depart_happy_colunm_" +
                                        happyColArr[j] + "_at_" + SeatsArea[i] + "></div>");
                        for (var k = 1; k <= happyColSeatNum; k++) {
                            if (k % 11 === 0) {
                                $("#depart_happy_colunm_" + happyColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<div class='happy_aisle_row' id=></div>");
                            } else {
                                $("#depart_happy_colunm_" + happyColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<input type='text' readonly class='depart_seat_normal_<%= to.getCabinClass()[0].ordinal() == 2 ? "available" : "banned"%>' id=depart" +
                                                SeatsArea[i] + happyColArr[j] + ++seatOrderNumberHappy + " value=" + happyColArr[j] + seatOrderNumberHappy + ">");
                            }
                        }
                    }
                }
            }
            if (i === <%= to.getCabinClass()[0].ordinal()%>) {
                var origin = 1;
                var end = 31;
                switch (i) {
                    case 0:
                        end = seatOrderNumberFancyOrigin;
                        break;
                    case 1:
                        origin = seatOrderNumberFancyOrigin + 1;
                        end = seatOrderNumberHappyOrigin;
                        break;
                    case 2:
                        origin = seatOrderNumberHappyOrigin + 1;
                        break;
                }
                for (var j = 0; j < colNameArr.length; j++) {
                    for (var k = origin; k <= end; k++) {
                        if (!getSeatStatusIsAvailable(colNameArr[j], k)) {
                            switch (i) {
                                case 0:
                                    var classname = "depart_seat_luxury_";
                                    $("#depart" + SeatsArea[i] + colNameArr[j] + k).removeClass(classname + "available");
                                    $("#depart" + SeatsArea[i] + colNameArr[j] + k).addClass(classname + "occupied");
                                    break;
                                default :
                                    var classname = "depart_seat_normal_";
                                    $("#depart" + SeatsArea[i] + colNameArr[j] + k).removeClass(classname + "available");
                                    $("#depart" + SeatsArea[i] + colNameArr[j] + k).addClass(classname + "occupied");
                            }
                        }
                    }
                }
            }
        }
        $(".depart_seat_luxury_available").click(departSeatLuxurySelectHandler);
        $(".depart_seat_normal_available").click(departSeatNormalSelectHandler);

    <% if (to.getTripType().ordinal() == 0) {%>
        for (var i = 0; i < <%=CabinClass.values().length%>; i++) {
            var seatOrderNumberGloryOrigin;
            var seatOrderNumberFancyOrigin;
            var seatOrderNumberHappyOrigin;
            if (SeatsArea[i] === "G") {
                seatOrderNumberGloryOrigin = 0;
//                alert("seatOrderNumberGloryOrigin = " + seatOrderNumberGloryOrigin);
                $("#return_seats_map>div:first-child")
                        .append("<div class=\"glory_seats_area\" id=return_seats_area" + SeatsArea[i] + "></div>");
                for (var j = 0; j < gloryColArr.length; j++) {
                    var seatOrderNumberGlory = seatOrderNumberGloryOrigin;
                    if (gloryColArr[j] === "left") {
                        $("#return_seats_area" + SeatsArea[i]).
                                append("<div class=\"glory_aisle\" id=return_glory_aisle_" +
                                        gloryColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else if (gloryColArr[j] === "right") {
                        $("#return_seats_area" + SeatsArea[i]).
                                append("<div class=\"glory_aisle\" id=return_glory_aisle_" +
                                        gloryColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else {
                        var gloryColSeatNum = <%= seatsGloryCol + aislesGlory%>;
                        $("#return_seats_area" + SeatsArea[i]).
                                append("<div class=\"glory_colunm\" id=return_glory_colunm_" +
                                        gloryColArr[j] + "_at_" + SeatsArea[i] + "></div>");
                        for (var k = 1; k <= gloryColSeatNum; k++) {
                            if (k % 2 === 0) {
                                $("#return_glory_colunm_" + gloryColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<div class='glory_aisle_row' id=></div>");
                            } else {
                                $("#return_glory_colunm_" + gloryColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<input type='text' readonly class='return_seat_luxury_<%= to.getCabinClass()[1].ordinal() == 0 ? "available" : "banned"%>' id=return" +
                                                SeatsArea[i] + gloryColArr[j] + ++seatOrderNumberGlory + " value=" + gloryColArr[j] + seatOrderNumberGlory + ">");
                            }
                        }
                    }
                }
//                alert("seatOrderNumberGlory = " + seatOrderNumberGlory);
                seatOrderNumberFancyOrigin = seatOrderNumberGlory;
            } else if (SeatsArea[i] === "F") {
//                alert("seatOrderNumberFancyOrigin = " + seatOrderNumberFancyOrigin);
                var seatOrderNumberFancy = seatOrderNumberFancyOrigin;
                $("#return_seats_map>div:first-child")
                        .append("<div class=\"fancy_seats_area\" id=return_seats_area" + SeatsArea[i] + "></div>");
                for (var j = 0; j < fancyColArr.length; j++) {
                    seatOrderNumberFancy = seatOrderNumberFancyOrigin;
                    if (fancyColArr[j] === "left") {
                        $("#return_seats_area" + SeatsArea[i]).
                                append("<div class=\"fancy_aisle\" id=return_fancy_aisle_" +
                                        fancyColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else if (fancyColArr[j] === "right") {
                        $("#return_seats_area" + SeatsArea[i]).
                                append("<div class=\"fancy_aisle\" id=return_fancy_aisle_" +
                                        fancyColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else {
                        var sah = $(".fancy_seats_area").height();
                        var fancyColSeatNum = <%= seatsFancyCol + aislesFancy%>;
                        $("#return_seats_area" + SeatsArea[i]).
                                append("<div class=\"fancy_colunm\" id=return_fancy_colunm_" +
                                        fancyColArr[j] + "_at_" + SeatsArea[i] + "></div>");
                        for (var k = 1; k <= fancyColSeatNum; k++) {
                            if (k % 6 === 0) {
                                $("#return_fancy_colunm_" + fancyColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<div class='fancy_aisle_row' id=></div>");
                            } else {
                                $("#return_fancy_colunm_" + fancyColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<input type='text' readonly class='return_seat_normal_<%= to.getCabinClass()[1].ordinal() == 1 ? "available" : "banned"%>' id=return" +
                                                SeatsArea[i] + fancyColArr[j] + ++seatOrderNumberFancy + " value=" + fancyColArr[j] + seatOrderNumberFancy + ">");
                            }
                        }
                    }
                }
//                alert("seatOrderNumberFancy = " + seatOrderNumberFancy);
                seatOrderNumberHappyOrigin = seatOrderNumberFancy;
            } else {
//                alert("seatOrderNumberHappyOrigin = " + seatOrderNumberHappyOrigin);
                var seatOrderNumberHappy = seatOrderNumberHappyOrigin;
                $("#return_seats_map>div:first-child")
                        .append("<div class=\"happy_seats_area\" id=return_seats_area" + SeatsArea[i] + "></div>");
                for (var j = 0; j < happyColArr.length; j++) {
                    seatOrderNumberHappy = seatOrderNumberHappyOrigin;
                    if (happyColArr[j] === "left") {
                        $("#return_seats_area" + SeatsArea[i]).
                                append("<div class=\"happy_aisle\" id=return_happy_aisle_" +
                                        happyColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else if (happyColArr[j] === "right") {
                        $("#return_seats_area" + SeatsArea[i]).
                                append("<div class=\"happy_aisle\" id=return_happy_aisle_" +
                                        happyColArr[j] + "_at_" + SeatsArea[i] + ">" + SeatsArea[i] + "</div>");
                    } else {
                        var sah = $(".happy_seats_area").height();
                        var happyColSeatNum = sah / 40;
                        $("#return_seats_area" + SeatsArea[i]).
                                append("<div class=\"happy_colunm\" id=return_happy_colunm_" +
                                        happyColArr[j] + "_at_" + SeatsArea[i] + "></div>");
                        for (var k = 1; k <= happyColSeatNum; k++) {
                            if (k % 11 === 0) {
                                $("#return_happy_colunm_" + happyColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<div class='happy_aisle_row' id=></div>");
                            } else {
                                $("#return_happy_colunm_" + happyColArr[j] + "_at_" + SeatsArea[i]).
                                        append("<input type='text' readonly class='return_seat_normal_<%= to.getCabinClass()[1].ordinal() == 2 ? "available" : "banned"%>' id=return" +
                                                SeatsArea[i] + happyColArr[j] + ++seatOrderNumberHappy + " value=" + happyColArr[j] + seatOrderNumberHappy + ">");
                            }
                        }
                    }
                }
            }
            if (i === <%= to.getCabinClass()[1].ordinal()%>) {
                var origin = 1;
                var end = 31;
                switch (i) {
                    case 0:
                        end = seatOrderNumberFancyOrigin;
                        break;
                    case 1:
                        origin = seatOrderNumberFancyOrigin + 1;
                        end = seatOrderNumberHappyOrigin;
                        break;
                    case 2:
                        origin = seatOrderNumberHappyOrigin + 1;
                        break;
                }
                for (var j = 0; j < colNameArr.length; j++) {
                    for (var k = origin; k <= end; k++) {
                        if (!getReturnSeatStatusIsAvailable(colNameArr[j], k)) {
                            switch (i) {
                                case 0:
                                    var classname = "return_seat_luxury_";
                                    $("#return" + SeatsArea[i] + colNameArr[j] + k).removeClass(classname + "available");
                                    $("#return" + SeatsArea[i] + colNameArr[j] + k).addClass(classname + "occupied");
                                    break;
                                default :
                                    var classname = "return_seat_normal_";
                                    $("#return" + SeatsArea[i] + colNameArr[j] + k).removeClass(classname + "available");
                                    $("#return" + SeatsArea[i] + colNameArr[j] + k).addClass(classname + "occupied");
                            }
                        }
                    }
                }
            }
        }
        $(".return_seat_luxury_available").click(returnSeatLuxurySelectHandler);
        $(".return_seat_normal_available").click(returnSeatNormalSelectHandler);
    <%}%>

    }

    var number_of_passengers = <%= totalPassengers%>; // JSP代入訂單乘客總數    
    var departPassengerMaxSeats = ["depart_seats_selected_R", "depart_seats_selected_1",
        "depart_seats_selected_2", "depart_seats_selected_3"];
    var returnPassengerMaxSeats = ["return_seats_selected_R", "return_seats_selected_1",
        "return_seats_selected_2", "return_seats_selected_3"];
    var departPassengerSeats = departPassengerMaxSeats.slice(0, number_of_passengers);
    var returnPassengerSeats = returnPassengerMaxSeats.slice(0, number_of_passengers);
    function departSeatLuxurySelectHandler() {
        if (this.className === "depart_seat_luxury_available") {
            if (departPassengerSeats.length === 0) {
                alert("請點選已選取的座位進行取消，謝謝!");
            } else {
//                        alert("目前有" + departPassengerSeats + "正在等待選位");
                $(this).removeClass("depart_seat_luxury_available").addClass("depart_seat_luxury_selected").
                        attr("name", departPassengerSeats[0]);
//                        alert(departPassengerSeats[0] + "已選取, id: " + this.id + ", value: " + this.value);
                switch (departPassengerSeats[0]) {
                    case "depart_seats_selected_R":
                        $("#depart_seats_selected_R").text(this.value);
                        break;
                    case "depart_seats_selected_1":
                        $("#depart_seats_selected_1").text(this.value);
                        break;
                    case "depart_seats_selected_2":
                        $("#depart_seats_selected_2").text(this.value);
                        break;
                    case "depart_seats_selected_3":
                        $("#depart_seats_selected_3").text(this.value);
                        break;
                }
                departPassengerSeats.shift();
//                if (departPassengerSeats.length === 0) {                    
//                            alert("選擇座位完成。如要更換座位請點選已選取的的座位進行取消，謝謝!");
//                        } else {
//                            alert("還有" + departPassengerSeats.length + "位客人選位尚未完成: " + departPassengerSeats);
//                }
            }
        } else {
            for (var i = 0; i < departPassengerMaxSeats.length; i++) {
                if (this.name === departPassengerMaxSeats[i]) {
                    departPassengerSeats.unshift(departPassengerMaxSeats[i]);
//                            alert(passengerSeats[0] + "已放回passengerSeats並取消訂位，id: " + this.id + ", value: " + this.value);
//                            alert("還有" + departPassengerSeats.length + "位客人選位尚未完成: " + departPassengerSeats);
                    $(this).removeClass("depart_seat_luxury_selected").addClass("depart_seat_luxury_available")
                            .removeAttr("name");
                    switch (departPassengerMaxSeats[i]) {
                        case "depart_seats_selected_R":
                            $("#depart_seats_selected_R").text("");
                            break;
                        case "depart_seats_selected_1":
                            $("#depart_seats_selected_1").text("");
                            break;
                        case "depart_seats_selected_2":
                            $("#depart_seats_selected_2").text("");
                            break;
                        case "depart_seats_selected_3":
                            $("#depart_seats_selected_3").text("");
                            break;
                    }
                }
            }
        }
    }

    function departSeatNormalSelectHandler() {
        if (this.className === "depart_seat_normal_available") {
            if (departPassengerSeats.length === 0) {
                alert("若要更改座位，請先點選已選取的座位進行取消再重新選位，謝謝!");
            } else {
//                        alert("目前有" + departPassengerSeats + "正在等待選位");
                $(this).removeClass("depart_seat_normal_available").addClass("depart_seat_normal_selected").
                        attr("name", departPassengerSeats[0]);
//                        alert(departPassengerSeats[0] + "已選取, id: " + this.id + ", value: " + this.value);
                switch (departPassengerSeats[0]) {
                    case "depart_seats_selected_R":
                        $("#depart_seats_selected_R").text(this.value);
                        break;
                    case "depart_seats_selected_1":
                        $("#depart_seats_selected_1").text(this.value);
                        break;
                    case "depart_seats_selected_2":
                        $("#depart_seats_selected_2").text(this.value);
                        break;
                    case "depart_seats_selected_3":
                        $("#depart_seats_selected_3").text(this.value);
                        break;
                }
                departPassengerSeats.shift();
//                        if (departPassengerSeats.length == 0) {
//                            alert("選擇座位完成。如要更換座位請點選已選取的的座位進行取消，謝謝!");
//                        } else {
//                            alert("還有" + departPassengerSeats.length + "位客人選位尚未完成: " + departPassengerSeats);
//                        }
            }
        } else {
            for (var i = 0; i < departPassengerMaxSeats.length; i++) {
                if (this.name === departPassengerMaxSeats[i]) {
                    departPassengerSeats.unshift(departPassengerMaxSeats[i]);
//                            alert(departPassengerSeats[0] + "已放回departPassengerSeats並取消訂位，id: " + this.id + ", value: " + this.value);
//                            alert("還有" + departPassengerSeats.length + "位客人選位尚未完成: " + departPassengerSeats);
                    $(this).removeClass("depart_seat_normal_selected").addClass("depart_seat_normal_available")
                            .removeAttr("name");
                    switch (departPassengerMaxSeats[i]) {
                        case "depart_seats_selected_R":
                            $("#depart_seats_selected_R").text("");
                            break;
                        case "depart_seats_selected_1":
                            $("#depart_seats_selected_1").text("");
                            break;
                        case "depart_seats_selected_2":
                            $("#depart_seats_selected_2").text("");
                            break;
                        case "depart_seats_selected_3":
                            $("#depart_seats_selected_3").text("");
                            break;
                    }
                }
            }
        }
    }

    function returnSeatLuxurySelectHandler() {
        if (this.className === "return_seat_luxury_available") {
            if (returnPassengerSeats.length === 0) {
                alert("請點選已選取的座位進行取消，謝謝!");
            } else {
//                        alert("目前有" + returnPassengerSeats + "正在等待選位");
                $(this).removeClass("return_seat_luxury_available").addClass("return_seat_luxury_selected").
                        attr("name", returnPassengerSeats[0]);
//                        alert(returnPassengerSeats[0] + "已選取, id: " + this.id + ", value: " + this.value);
                switch (returnPassengerSeats[0]) {
                    case "return_seats_selected_R":
                        $("#return_seats_selected_R").text(this.value);
                        break;
                    case "return_seats_selected_1":
                        $("#return_seats_selected_1").text(this.value);
                        break;
                    case "return_seats_selected_2":
                        $("#return_seats_selected_2").text(this.value);
                        break;
                    case "return_seats_selected_3":
                        $("#return_seats_selected_3").text(this.value);
                        break;
                }
                returnPassengerSeats.shift();
//                        if (returnPassengerSeats.length == 0) {
//                            alert("選擇座位完成。如要更換座位請點選已選取的的座位進行取消，謝謝!");
//                        } else {
//                            alert("還有" + returnPassengerSeats.length + "位客人選位尚未完成: " + returnPassengerSeats);
//                        }
            }
        } else {
            for (var i = 0; i < returnPassengerMaxSeats.length; i++) {
                if (this.name === returnPassengerMaxSeats[i]) {
                    returnPassengerSeats.unshift(returnPassengerMaxSeats[i]);
//                            alert(returnPassengerSeats[0] + "已放回returnPassengerSeats並取消訂位，id: " + this.id + ", value: " + this.value);
//                            alert("還有" + returnPassengerSeats.length + "位客人選位尚未完成: " + returnPassengerSeats);
                    $(this).removeClass("return_seat_luxury_selected").addClass("return_seat_luxury_available")
                            .removeAttr("name");
                    switch (returnPassengerMaxSeats[i]) {
                        case "return_seats_selected_R":
                            $("#return_seats_selected_R").text("");
                            break;
                        case "return_seats_selected_1":
                            $("#return_seats_selected_1").text("");
                            break;
                        case "return_seats_selected_2":
                            $("#return_seats_selected_2").text("");
                            break;
                        case "return_seats_selected_3":
                            $("#return_seats_selected_3").text("");
                            break;
                    }
                }
            }
        }
    }

    function returnSeatNormalSelectHandler() {
        if (this.className === "return_seat_normal_available") {
            if (returnPassengerSeats.length === 0) {
                alert("若要更改座位，請先點選已選取的座位進行取消再重新選位，謝謝!");
            } else {
//                        alert("目前有" + returnPassengerSeats + "正在等待選位");
                $(this).removeClass("return_seat_normal_available").addClass("return_seat_normal_selected").
                        attr("name", returnPassengerSeats[0]);
//                        alert(returnPassengerSeats[0] + "已選取, id: " + this.id + ", value: " + this.value);
                switch (returnPassengerSeats[0]) {
                    case "return_seats_selected_R":
                        $("#return_seats_selected_R").text(this.value);
                        break;
                    case "return_seats_selected_1":
                        $("#return_seats_selected_1").text(this.value);
                        break;
                    case "return_seats_selected_2":
                        $("#return_seats_selected_2").text(this.value);
                        break;
                    case "return_seats_selected_3":
                        $("#return_seats_selected_3").text(this.value);
                        break;
                }
                returnPassengerSeats.shift();
//                        if (returnPassengerSeats.length == 0) {
//                            alert("選擇座位完成。如要更換座位請點選已選取的的座位進行取消，謝謝!");
//                        } else {
//                            alert("還有" + returnPassengerSeats.length + "位客人選位尚未完成: " + returnPassengerSeats);
//                        }
            }
        } else {
            for (var i = 0; i < returnPassengerMaxSeats.length; i++) {
                if (this.name === returnPassengerMaxSeats[i]) {
                    returnPassengerSeats.unshift(returnPassengerMaxSeats[i]);
//                            alert(returnPassengerSeats[0] + "已放回returnPassengerSeats並取消訂位，id: " + this.id + ", value: " + this.value);
//                            alert("還有" + returnPassengerSeats.length + "位客人選位尚未完成: " + returnPassengerSeats);
                    $(this).removeClass("return_seat_normal_selected").addClass("return_seat_normal_available")
                            .removeAttr("name");
                    switch (returnPassengerMaxSeats[i]) {
                        case "return_seats_selected_R":
                            $("#return_seats_selected_R").text("");
                            break;
                        case "return_seats_selected_1":
                            $("#return_seats_selected_1").text("");
                            break;
                        case "return_seats_selected_2":
                            $("#return_seats_selected_2").text("");
                            break;
                        case "return_seats_selected_3":
                            $("#return_seats_selected_3").text("");
                            break;
                    }
                }
            }
        }
    }

    <% if (to.getTripType().ordinal() == 0) {%>
    var shift_status = 0;
    function departShiftHandler() {
        if (shift_status === 0) {
            alert("目前正在出發航班選位內容中...");
        } else {
            shift_status = 0;
            $("#depart_passenger_flight_info").removeAttr("style");
            $("#return_passenger_flight_info").attr("style", "display:none;");
            $("#depart_passenger_dividual_info").removeAttr("style");
            $("#return_passenger_dividual_info").attr("style", "display:none;");
            $("#depart_seats_map").removeAttr("style");
            $("#return_seats_map").attr("style", "display:none;");
            
            $("#shift_menu_depart").removeClass("shift_menu_button").addClass("shift_menu_button_clicked");
            $("#shift_menu_return").removeClass("shift_menu_button_clicked").addClass("shift_menu_button");
        }
    }
    function returnShiftHandler() {
        if (shift_status === 1) {
            alert("目前正在回程航班選位內容中...");
        } else {
            shift_status = 1;
            $("#return_passenger_flight_info").removeAttr("style");
            $("#depart_passenger_flight_info").attr("style", "display:none;");
            $("#return_passenger_dividual_info").removeAttr("style");
            $("#depart_passenger_dividual_info").attr("style", "display:none;");
            $("#return_seats_map").removeAttr("style");
            $("#depart_seats_map").attr("style", "display:none;");
            
            $("#shift_menu_return").removeClass("shift_menu_button").addClass("shift_menu_button_clicked");
            $("#shift_menu_depart").removeClass("shift_menu_button_clicked").addClass("shift_menu_button");
        }
    }
    <%}%>
</script>

<%
    SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfWeekdayName = new SimpleDateFormat("E");
%>
<div style="padding: 10px 0 10px 15%;">
    <div class="booking_system_content">
        <div class="passenger_seats_select">
            <div class="passenger_seats_select_title">
                <img src="/aac/image/booking/seats_select_title.png" alt="選擇座位"/>
                <div class="passenger_seats_select_title_name" style="font-size: 24px;">選擇座位</div>
                <% if (to.getTripType().ordinal() == 0) {%>
                <div id="shift_menu">
                    <div id="shift_menu_depart" class="shift_menu_button_clicked" onclick="departShiftHandler()">
                        <div class="direction"><img src="/aac/image/arrows/step_blue_heavy_left.png" alt=""/></div>
                        <div class="flight_shift" >出發航班</div>
                    </div>
                    <div style="width: 140px;"></div>
                    <div id="shift_menu_return" class="shift_menu_button" onclick="returnShiftHandler()">
                        <div class="flight_shift" >回程航班</div>
                        <div class="direction"><img src="/aac/image/arrows/step_blue_heavy.png" alt=""/></div>
                    </div>
                </div>
                <%}%>
            </div>
            <div class="passenger_flight_info" id="depart_passenger_flight_info">
                <div class="order_of_flight">1</div>
                <div style="width:95%;">
                    <div class="date_of_flight">
                        <%= sdfDateOnly.format(to.getDepartDate())%> 
                        <%= sdfWeekdayName.format(to.getDepartDate())%>
                        <%= to.getDepartFlightRoute().name()%>
                    </div>                    
                    <div class="flight_takeoff_and_land">
                        <div class="takeoff_of_flight">
                            <%= to.getDepartFlightRoute().getTakeoffAirport().name()%>
                            <%= to.getDepartFlightRoute().getTakeoffAirport().getCity()%>
                            <%= to.getDepartFlightRoute().getTakeoffScheduleTime()%>
                        </div>
                        <div class="direction"><img src="/aac/image/arrows/big_gray.png" alt=""/></div>
                        <div class="land_of_flight">
                            <%= to.getDepartFlightRoute().getLandingAirport().name()%>
                            <%= to.getDepartFlightRoute().getLandingAirport().getCity()%>
                            <%= to.getDepartFlightRoute().getLandingScheduleTime()%>
                        </div>
                    </div>
                </div>
            </div>
            <% if (to.getTripType().ordinal() == 0) {%>
            <div class="passenger_flight_info" id="return_passenger_flight_info" style="display: none;">
                <div class="order_of_flight">2</div>
                <div style="width:95%;">
                    <div class="date_of_flight">  <!--style="display: none;"-->
                        <%= sdfDateOnly.format(to.getReturnDate())%> 
                        <%= sdfWeekdayName.format(to.getReturnDate())%>
                        <%= to.getReturnFlightRoute().name()%>
                    </div>                                        
                    <div class="flight_takeoff_and_land">
                        <div class="takeoff_of_flight">
                            <%= to.getReturnFlightRoute().getTakeoffAirport().name()%>
                            <%= to.getReturnFlightRoute().getTakeoffAirport().getCity()%>
                            <%= to.getReturnFlightRoute().getTakeoffScheduleTime()%>
                        </div>
                        <div class="direction"><img src="/aac/image/arrows/big_gray.png" alt=""/></div>
                        <div class="land_of_flight">
                            <%= to.getReturnFlightRoute().getLandingAirport().name()%>
                            <%= to.getReturnFlightRoute().getLandingAirport().getCity()%>
                            <%= to.getReturnFlightRoute().getLandingScheduleTime()%>
                        </div>
                    </div>
                </div>
            </div>
            <%}%>
            <div style="width:100%;display:inline-flex;flex-direction: row;height: 500px;">
                <div class="passenger_seats_select_menu">
                    <div id="depart_passenger_dividual_info">
                        <%
                            String[] passengers = {"seats_selected_R", "seats_selected_1", "seats_selected_2", "seats_selected_3"};
                            for (int i = 0; i < totalPassengers; i++) {
                        %>
                        <div class="passenger_dividual_info">
                            <img src="/aac/image/booking/logo_small.png" alt=""/>
                            <div style="width: 160px;display: inline-table;">
                                <div class="passenger_dividual_honor">                                    
                                    <%= pl.getPassengerInfo() == null ? "MR" : pl.getPassengerInfo()[i].getGender().ordinal() == 0 ? "MR" : "MS"%>
                                    <%= pl.getPassengerInfo() == null ? "SHINSHIN WANG" : pl.getPassengerInfo()[i].getFirstName().toUpperCase() + " "
                                            + pl.getPassengerInfo()[i].getLastName().toUpperCase()%>                              
                                </div>
                                <div class="selecting_seats">
                                    <span>選取座位</span>
                                    <img src="/aac/image/arrows/step_white.png" alt=""/>
                                </div>
                            </div>
                            <div class="seat_number" id="depart_<%= passengers[i]%>"></div>                        
                        </div>                    
                        <%}%>
                    </div>
                    <% if (to.getTripType().ordinal() == 0) {%>
                    <div id="return_passenger_dividual_info" style="display: none;">
                        <%  for (int i = 0; i < totalPassengers; i++) {%>
                        <div class="passenger_dividual_info">
                            <img src="/aac/image/booking/logo_small.png" alt=""/>
                            <div style="width: 160px;display: inline-table;">
                                <div class="passenger_dividual_honor">                                    
                                    <%= pl.getPassengerInfo() == null ? "MR" : pl.getPassengerInfo()[i].getGender().ordinal() == 0 ? "MR" : "MS"%>
                                    <%= pl.getPassengerInfo() == null ? "SHINSHIN WANG" : pl.getPassengerInfo()[i].getFirstName().toUpperCase() + " "
                                            + pl.getPassengerInfo()[i].getLastName().toUpperCase()%>                              
                                </div>
                                <div class="selecting_seats">
                                    <span>選取座位</span>
                                    <img src="/aac/image/arrows/step_white.png" alt=""/>
                                </div>
                            </div>
                            <div class="seat_number"  id="return_<%= passengers[i]%>"></div>
                        </div>
                        <%}%>
                    </div>
                    <%}%>
                    <div class="seats_key">
                        <div><div class="seat_available"></div><span>可選擇的座位</span></div>
                        <div><div class="seat_occupied"></div><span>已被預訂的座位</span></div>
                        <div><div class="seat_selected"></div><span>您選擇的座位</span></div>
                        <div><div class="seat_banned"></div><span>無法選擇的座位</span></div>
                        <div style="margin: 20px 0;">請完成所有航段與乘客的座位選擇，再按下"選位確認"即可。</div>
                        <div class="passenger_seats_select_done_button">
                            <input type="submit" id="passenger_seats_select_done_button" class="text_chinese"
                                   name="passenger_seats_select_done_button" value="選位確認">
                        </div>
                    </div>
                </div>
                <div class="seats_map" id="depart_seats_map" >
                    <div></div>
                    <div style="width: inherit;height: 30px;display: inline-block;position:relative;top: 50px;"></div>
                </div>
                <% if (to.getTripType().ordinal() == 0) {  %>
                <div class="seats_map" id="return_seats_map" style="display: none;">
                    <div></div>
                    <div style="width: inherit;height: 30px;display: inline-block;position:relative;top: 50px;"></div>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</div>

