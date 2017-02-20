<%@page import="aac.domain.TicketOrder"%>
<%@page import="aac.domain.Passenger"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="aac.domain.PassengerList"%>
<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<style>
    .booking_system_title_name{
        width: 100%;
        text-align: center;
    }
    #prepare_aboard_statement{
        margin: 20px 0;
        padding: 0 30px;
        font-size: 16px;
        color:#888888;
        text-align: left;
    }
    #display_1{
        display: flex;
        flex-direction: row;
    }
    #prepare_aboard_credit_pay_status{
        width: 240px;
        padding: 30px;
        font-size: 20px;
    }
    #prepare_aboard_passengers_info_review{
        padding: 20px;
        width: 100%;
        box-sizing: border-box;
    }
    #prepare_aboard_passengers_info_review_title{
        padding: 4px;
        font-size: 22px;
    }
    .prepare_aboard_passengers_info_individual{
        margin: 10px 0 0;
        display: inline-flex;
        color:#666666;
    }
    .prepare_aboard_passengers_info_individual img{
        width: 30px;
        height: 30px;
        border-radius: 20px;
    }
    .passenger_dividual_honor{
        font-size: 20px;
        padding: 3px 6px;
    }

    #prepare_aboard_flight_schedule_title{
        padding: 4px;
        font-size: 22px;
    }
    .flight_schedule_content_part{
        display: inline-flex;
        flex-direction: row;
        color: white;
        margin: 10px 0;
    }
    .flight_schedule_content_part>div{
        padding: 10px 30px;
        background: #aaaaaa;
    }
    .arrow3 img{
        width: 20px;
        height: 20px;
        margin: 20px 0;
        border-radius: 10px;
    }

    #prepare_aboard_member_mileage_charge{
        display: inline-flex;
        flex-direction: row;
        margin: 20px 0;
    }
    #prepare_aboard_member_mileage_charge_statement{
        margin: 20px 0;
        padding: 0 30px;
        font-size: 16px;
        color: #888888;
        text-align: left;
    }
    #register_first_step{
        width: 240px;
        padding: 30px;
        font-size: 20px;
    }
    #register_email{
        margin: 0;
        padding: 4px 10px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
    }

</style>
<script>
    function gotoUrl(url)
{
    // 取得歷史網址的長度
    var len = history.length;    
    // 先回到 IE 啟動時的第一頁
    history.go(-len);
    // 再將網址轉向到目的頁面 ( 注意: 一定要用 location.replace 函式 )
    location.replace(url);
    return false;
    // 資料來源 http://blog.miniasp.com/post/2009/03/18/How-to-clear-browser-history-by-using-JavaScript.aspx
}
</script>
<%
    SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfWeekdayName = new SimpleDateFormat("E");
    SimpleDateFormat sdfFull = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String[] passengerName = {"passenger_r", "passenger_1", "passenger_2", "passenger_3"};
    PassengerList pl = (PassengerList) session.getAttribute("passenger_list_done");
    int totalPassengers = pl.getAdultNumber() + pl.getChildNumber();
    Passenger[] passengersInfos = pl.getPassengerInfo();
    TicketOrder to = (TicketOrder) session.getAttribute("ticket_order_done");
%>
<div style="margin: 30px 180px;box-sizing: border-box;display: inline-flex;">
    <div class="booking_system_content" style="background: #e2deff">
        <div class="booking_system_title">
            <div class="booking_system_title_name">準備出發</div>
        </div>
        <div id="display_1">
            <div id="prepare_aboard_statement">
                <span>感謝您選擇搭乘杜鵑航空，您的購票交易已完成。</span><br>
                <span>我們會以電子郵件的方式，將以下的交易內容傳送至您的電子郵件信箱。</span><br>                
                <span>請您再次確認資料內容是否有誤。</span><br>
                <br>
                <span>若資料內容正確，請於辦理登機時出示，交由服務人員確認後完成手續。</span><br>
                <span>您也可以使用訂位代號，於網站中查詢您的訂位資訊。</span>
            </div>
            <div id="prepare_aboard_credit_pay_status">
                <span>購票完成</span>
                <div style="color:#777777;background: yellow;">
                    <span>訂位代號:</span>
                    <span class="text_chinese"><%= to.getOrderNumber()%></span>
                </div>
                <span>交易時間</span>                
                <div><%= sdfFull.format(to.getOrderTime())%></div>

            </div>
        </div>
        <div id="prepare_aboard_passengers_info_review">
            <div id="prepare_aboard_passengers_info_review_title">旅客資訊</div>
            <% for (int i = 0; i < totalPassengers; i++) {%>
            <div class="prepare_aboard_passengers_info_individual">
                <img src="/aac/image/booking/logo_small.png" alt=""/>
                <div class="passenger_dividual_honor">
                    <span class="text_english">                        
                        <%= passengersInfos[i].getGender().ordinal() == 0 ? "MR" : "MS"%> <%= passengersInfos[i].getFirstName().toUpperCase()%> <%= passengersInfos[i].getLastName().toUpperCase()%>
                    </span>
                </div>
            </div>
            <%}%>
        </div>  
        <div id="prepare_aboard_flight_schedule">
            <div id="prepare_aboard_flight_schedule_title">飛航行程表</div>
            <div id="flight_schedule_content">
                <div class="flight_schedule_content_part">
                    <div>
                        <div class="flight_schedule_content_part_date"><%= to == null ? "" : sdfDateOnly.format(to.getDepartDate())%></div>
                        <div class="flight_schedule_content_part_weekday"><%= to == null ? "" : sdfWeekdayName.format(to.getDepartDate())%></div>
                        <div class="flight_number_and_cabin"><span><%= to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().name()%></span> <span><%= to.getCabinClass()[0].name()%></span></div>
                    </div>
                    <div class="flight_schedule_content_part_takeoff_port">
                        <div><%= to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getTakeoffAirport().name()%></div>
                        <div><%= to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getTakeoffAirport().getCity()%></div>
                        <div><%= to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getTakeoffScheduleTime()%></div>
                    </div>
                    <div class="arrow3"><img src="/aac/image/arrows/big_gray.png" alt=""/></div>
                    <div class="flight_schedule_content_part_land_port">
                        <div><%=  to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getLandingAirport().name()%></div>
                        <div><%=  to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getLandingAirport().getCity()%></div>
                        <div><%=  to.getDepartFlightRoute() == null ? "" : to.getDepartFlightRoute().getLandingScheduleTime()%></div> 
                    </div>
                </div>
                <% if (to.getTripType().ordinal() == 0) {%>
                <div class="flight_schedule_content_part">
                    <div>
                        <div class="flight_schedule_content_part_date"><%= to == null ? "" : sdfDateOnly.format(to.getReturnDate())%></div>
                        <div class="flight_schedule_content_part_weekday"><%= to == null ? "" : sdfWeekdayName.format(to.getReturnDate())%></div>
                        <div class="flight_number_and_cabin"><span><%= to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().name()%></span> <span><%= to.getCabinClass()[0].name()%></span></div>
                    </div>
                    <div class="flight_schedule_content_part_takeoff_port">
                        <div><%= to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getTakeoffAirport().name()%></div>
                        <div><%= to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getTakeoffAirport().getCity()%></div>
                        <div><%= to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getTakeoffScheduleTime()%></div>
                    </div>
                    <div class="arrow3"><img src="/aac/image/arrows/big_gray.png" alt=""/></div>
                    <div class="flight_schedule_content_part_land_port">
                        <div><%=  to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getLandingAirport().name()%></div>
                        <div><%=  to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getLandingAirport().getCity()%></div>
                        <div><%=  to.getReturnFlightRoute() == null ? "" : to.getReturnFlightRoute().getLandingScheduleTime()%></div> 
                    </div>
                </div>
                <%}%>
            </div>                
        </div>
        <div id="prepare_aboard_member_mileage_charge" style="display: none">
            <div id="prepare_aboard_member_mileage_charge_statement">
                <span>加入杜鵑航空里程俱樂部，成為我們的尊榮會員，
                    除了可以累積里程、享受折扣優惠之外，還有不定期推出的酬賓活動，精彩可期。</span><br>
                <span>現在就輸入電子郵件信箱，接收認證信，加入俱樂部吧!!</span>
            </div>
            <form method="POST" action="register.do">
                <div id="register_first_step">
                    <input type="text" id="register_email" name="register_email" placeholder="輸入電子郵件信箱">
                    <input type="submit" value="加入俱樂部">
                </div>
            </form>
        </div>
        <div style="float: right;">
            <span><a href="/aac" onclick="gotoUrl('/aac')" style="font-size: 16px;">回到首頁</a></span>
        </div>
    </div>
</div>

