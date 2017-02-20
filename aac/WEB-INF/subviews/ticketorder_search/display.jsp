<%-- 
    Document   : display
    Created on : 2016/11/10, 下午 01:26:25
    Author     : Walker
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="aac.domain.dataCategory.FlightRoute"%>
<%@page import="aac.domain.Passenger"%>
<%@page import="aac.domain.PassengerList"%>
<%@page import="aac.domain.Customer"%>
<%@page import="aac.domain.TicketOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    #header_block{
        width: 100%;
        height: 70px;
        background-color: #ada8ff;
    }
    #display{
        width: 100%;
        height: 540px;
        background: #e2deff;
        padding: 0 15%;
        box-sizing: border-box;
        font-size: 18px;
    }
    #content{
        position: relative;
        top: 10px;
        background-color: #ffffff;
        width: 100%;
        height: 520px;
        /*margin: 10px 0 ;*/
        padding: 40px 40px;
        box-sizing: border-box;
    }
    .table_title{
        color: #777777;
    }
    .search_condition{
        color: #444444;
    }
    #passenger_data td{
        border: 2px solid #ffffff;
        padding: 0px 10px;
        text-align: center;
    }
    .detail_links{
        font-size: 14px;
        color: #3b3abb;
        text-decoration: underline;
        cursor: pointer;
    }
    #data_title>td{
        font-size: 16px;
        color: #555555;
        background: #e2deff;
    }
    .passenger_odd{
        background: #dddddd;
        color: #444444;
    }
    .passenger_even{
        background: #888888;
        color: #eeeeee;
    }
</style>
<%
    TicketOrder to = (TicketOrder) session.getAttribute("ticket_order");
    Customer c = (Customer) session.getAttribute("customer");
    PassengerList pl = (PassengerList) session.getAttribute("passenger_list");
%>
<script>
    var pd_status = 0;
    function passengerDetailOpener() {
        if (pd_status === 0) {
            $("#passenger_data").removeAttr("style");
            pd_status += 1;
        } else if (pd_status === 1) {
            $("#passenger_data").attr("style","display:none");
            pd_status -= 1;
        }
    }
</script>
<div id="header_block"></div>
<div id="display">
    <div id="content">
        <div class="table_title">您所查詢的訂位代號：<span class="search_condition"><%= to.getOrderNumber()%></span></div>
        <div class="table_title">電子郵件信箱：<span class="search_condition"><%= c.getEmail()%></span></div>
        <div class="table_title">以下為查詢到的訂位內容：</div>
        <br>
        <table>
            <tr>
                <td class="table_title">訂位時間：</td>
                <td><%= to.getOrderTime()%></td>
            </tr>
            <tr>
                <% Passenger pr = pl.getPassengerInfo()[0];%>
                <td class="table_title">乘客代表：</td>
                <td><%= pr.getGender().ordinal() == 0 ? "MR" : "MS"%> <%= pr.getFirstName()%> <%= pr.getLastName()%></td>
            </tr>
            <tr>
                <% int totalPassenger = pl.getAdultNumber() + pl.getChildNumber();%>
                <td class="table_title">乘客人數：</td>
                <td><%= totalPassenger%>位 <span class="detail_links" onclick="passengerDetailOpener()">詳細乘客資訊</span></td>                
            </tr>            
            <tr>
                <%
                    FlightRoute frd = to.getDepartFlightRoute();
                %>
                <td class="table_title">出發機場：</td>
                <td><%= frd.getTakeoffAirport().name() + " " + frd.getTakeoffAirport().getName()%></td>
                <td></td>
                <td class="table_title">目的機場：</td>
                <td><%= frd.getLandingAirport().name() + " " + frd.getLandingAirport().getName()%></td>
            </tr>
            <tr>
                <td class="table_title">出發日期：</td>
                <td><%= to.getDepartDate()%></td>
                <td></td>
                <td class="table_title">出發艙等：</td>
                <td><%= to.getCabinClass()[0].name()%></td>
            </tr>
            <% if (to.getTripType().ordinal() == 0) {%>
            <tr>
                <td class="table_title">回程日期：</td>
                <td><%= to.getReturnDate()%></td>
                <td></td>
                <td class="table_title">回程艙等：</td>
                <td><%= to.getCabinClass()[1].name()%></td>
            </tr>
            <%}%>
        </table>
        <br>
        <table id="passenger_data" style="display: none">            
            <tr id="data_title">
                <td>姓名</td><td>生日</td><td>居住地</td><td>國籍</td><td>護照號碼</td><td>發行地</td><td>有效期限</td>                
            </tr>
            <%
                for (int i = 0; i < totalPassenger; i++) {
                    Passenger p = pl.getPassengerInfo()[i];
            %>
            <tr class='<%= i % 2 == 0 ? "passenger_even" : "passenger_odd"%>'>
                <td><%= p.getGender().ordinal() == 0 ? "MR" : "MS"%> <%= p.getFirstName()%> <%= p.getLastName()%></td>
                <td><%= p.getBirthday()%></td>
                <td><%= p.getResidence().getNameTCN()%></td>
                <td><%= p.getNation().getNameTCN()%></td>
                <td><%= p.getPassportNumber()%></td>
                <td><%= p.getPassportIssuePlace().getNameTCN()%></td>
                <td><%= p.getPassportExpiryDate()%></td>
            </tr>
            <%}%>
        </table>
        <br>
        <div><a href="/aac" style="text-decoration: none;color: #555555;font-weight: 800;float: right;">回到首頁</a></div>
    </div>    
</div>
