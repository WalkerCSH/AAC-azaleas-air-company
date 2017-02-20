<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="aac.domain.TicketOrder"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="aac.domain.dataCategory.Country"%>
<%@page import="aac.domain.Passenger"%>
<%@page import="aac.domain.PassengerList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<style>
    #passengers_info_check_and_keyin_passport{
        margin: 20px 0;
    }
    .credit_pay_passenger_individual{
        text-align: left;
        border-bottom: 1px #444444 solid;
    }
    .passenger_individual_basic_info img{
        width: 35px;
        height: 35px;
        border-radius: 10px;
        margin: 6px 0;
    }
    .passenger_individual_basic_info,.passenger_individual_passport_info{
        display: inline-flex;
    } 
    .passenger_individual_basic_info>div{
        display:flex;
        flex-direction: column;
        width: 203px;
        padding: 6px 10px;
        font-size: 18px;
        font-family: 'Lobster', cursive,'cwtexhei', serif;
        border-right: 1px #aaaaaa solid;
    }
    .passenger_individual_basic_info>div>span:first-child{
        font-size: 14px;
        color:#666666;
    }
    .passenger_individual_basic_info>div:nth-child(4){
        width: 50px;
    }
    .passenger_individual_basic_info>div:nth-child(5){
        width: 130px;
        border-right: none;
    }

    .passenger_individual_passport_info{
        border-top: 1px #aaaaaa solid;
        background:#d3cdff;
    }
    .passenger_individual_passport_info>div{
        display:flex;
        flex-direction: column;
        width: 140px;
        padding: 6px 10px;
        font-size: 18px;
        font-family: 'Lobster', cursive,'cwtexhei', serif;
        border-right: 1px #aaaaaa solid;
    }
    .passenger_individual_passport_info>div>label{
        font-size: 14px;
        color:#666666;
    }
    .passenger_individual_passport_info input,.passenger_individual_passport_info select{
        height: 24px;
        box-sizing: border-box;
    }
    .passenger_individual_passport_info>div:nth-child(4){
        width: 172px;
        border-right: none;
    }
    .passenger_individual_passport_info_expiry_date>div{
        display:inline;
    }
    .passport_expiry_date_day{
        width: 50px;
    }
    .passport_expiry_date{
        width: 170px;
    }

    #passenger_contact_info{
        width: 100%;
        display: inline-flex;
        flex-direction: row;
        margin: 20px 0;
        text-align: left;
        background: #d3cdff;
    }
    .passenger_contact_representative_info_title{
        font-size: 14px;
        color: #666666;
    }
    #passenger_contact_info>div{
        width: 50%;
        display: flex;
        flex-direction: column;
    }
    #passenger_contact_info>div>div{
        padding: 10px;
        box-sizing: border-box;
        display: inline-flex;
        flex-direction: column;
    }
    .representative_info_input{
        width: 100%;
        height: 30px;
        font-size:18px;
        padding: 4px 8px;
        box-sizing: border-box;
        margin: 4px 0;
    }
    #representative_info_restore{
        width: 14px;
        height: 14px;
    }
    #passenger_contact_info>div:last-child>div:last-child{
        display: inline-flex;
        flex-direction: row;
        padding: 40px 0 0;
        box-sizing: border-box;
    }

    #credit_pay_info_annotation{
        margin: 20px 0;
        padding: 0 10px;
        font-size: 14px;
        color:#555555;
        text-align: left;
    }
    #credit_pay_info_keyin{
        display: inline-flex;
        flex-direction: row;
        text-align: left;
        width: 100%;
        background: #d3cdff;
    }
    #credit_pay_info_keyin>div{
        padding: 10px;
        display: inline-flex;
        flex-direction: column;
        box-sizing: border-box;
    }
    #credit_pay_info_keyin label{
        font-size: 14px;
        color: #666666;
    }
    #credit_pay_info_keyin_number{
        width: 100%;
        height: 30px;
        font-size:18px;
        padding: 4px 8px;
        box-sizing: border-box;
        margin: 4px 0;
    }
    #credit_pay_info_keyin_expiry{
        display: flex;
        flex-direction: row;
    }
    #credit_pay_info_keyin_expiry_month,#credit_pay_info_keyin_expiry_year{
        height: 30px;
        font-size: 18px;
        padding: 4px 8px;
        box-sizing: border-box;
        margin: 4px 0;
    }
    #credit_pay_info_keyin_expiry_month{
        width: 60px;
    }
    #credit_pay_info_keyin_expiry_year{
        width: 100px;
    }
    #credit_pay_info_keyin_ccvnumber{
        width: 100px;
        height: 30px;
        font-size:18px;
        padding: 4px 8px;
        box-sizing: border-box;
        margin: 4px 0;
    }

    #credit_pay_info_total_amount{
        display: inline-flex;
        flex-direction: row;
        width: 100%;
        background: #d3cdff;
        text-align: right;
        padding: 20px 0;
    }
    #credit_pay_info_total_amount span{
        font-size: 16px;
    }
    #credit_pay_info_total_amount span:last-child{
        font-size: 30px;
        padding: 0 6px;
        margin: 0;
    }
</style>
<%
    SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy-MM-dd");
    String[] passengerName = {"passenger_r", "passenger_1", "passenger_2", "passenger_3"};
    PassengerList pl = (PassengerList) session.getAttribute("passenger_list");
    int totalPassengers = pl.getAdultNumber() + pl.getChildNumber();
    Passenger[] passengersInfos = pl.getPassengerInfo();
//    List<String> errors = (ArrayList) session.getAttribute("errors");
%>
<script>
    <%-- if (errors!=null && !errors.isEmpty()) {
            for (String error : errors) {%>
    alert("<%= error%>");
    <%}
        }--%>

    $(function () {
    <% for (int i = 0; i < totalPassengers; i++) {%>
        $("#passport_expiry_date_<%= passengerName[i]%>").datepicker({
            changeMonth: true,
            changeYear: true,
            numberOfMonths: 1,
            showButtonPanel: true,
            minDate: 0, maxDate: "+20Y"});
        $("#passport_expiry_date_<%= passengerName[i]%>").datepicker("option", "dateFormat", "yy-mm-dd");
    <%}%>
        $("#representative_name").val("<%= passengersInfos[0].getGender().ordinal() == 0 ? "MR" : "MS"%> <%= passengersInfos[0].getFirstName().toUpperCase()%> <%= passengersInfos[0].getLastName().toUpperCase()%>");
                $("#representative_residence").val("<%= passengersInfos[0].getResidence().getNameTCN()%>");
            });

</script>
<div style="padding: 10px 0 10px 15%;">
    <div class="booking_system_content">
        <div class="booking_system_title">
            <div class="booking_system_title_name">確認旅客名單並輸入護照資訊</div>                                
        </div>
        <div id="passengers_info_check_and_keyin_passport">
            <% for (int i = 0; i < totalPassengers; i++) {%>
            <div class="credit_pay_passenger_individual">
                <div class="passenger_individual_basic_info">
                    <img src="/aac/image/booking/logo_small.png" alt=""/>
                    <div class="passenger_individual_basic_info_first_name">
                        <span class="passenger_individual_basic_info_title">名</span>
                        <span><%= passengersInfos[i].getFirstName().toUpperCase()%></span>
                    </div>
                    <div class="passenger_individual_basic_info_last_name">
                        <span class="passenger_individual_basic_info_title">姓</span>
                        <span><%= passengersInfos[i].getLastName().toUpperCase()%></span>
                    </div>
                    <div class="passenger_individual_basic_info_gender">
                        <span class="passenger_individual_basic_info_title">性別</span>
                        <span><%= passengersInfos[i].getGender().ordinal() == 0 ? "男性" : "女性"%></span>
                    </div>
                    <div class="passenger_individual_basic_info_birthday">
                        <span class="passenger_individual_basic_info_title">出生年月日</span>
                        <span><%= sdfDateOnly.format(passengersInfos[i].getBirthday())%></span>
                    </div>
                </div>
                <div class="passenger_individual_passport_info">
                    <div class="passenger_individual_passport_info_nation">
                        <label class="passenger_individual_passport_info_title">國籍</label>
                        <% Country[] countrys = Country.values();%>
                        <select class="text_chinese" name="nation_<%= passengerName[i]%>">
                            <% for (Country c : countrys) {%>
                            <option class="text_chinese" style="font-size:16px;" value="<%= c.ordinal()%>" 
                                    <%= passengersInfos[i].getNation() != null && passengersInfos[i].getNation().ordinal() == c.ordinal() ? "selected=''" : ""%>>
                                <%= c.getNameTCN()%></option>
                                <%}%>
                        </select>
                    </div>                    
                    <div class="passenger_individual_passport_info_number">
                        <label class="passenger_individual_passport_info_title">護照號碼</label>
                        <input type="text" name="passport_number_<%= passengerName[i]%>" value="<%= passengersInfos[i].getPassportNumber() == null ? "" : passengersInfos[i].getPassportNumber()%>" autocomplete="off">
                    </div>
                    <div class="passenger_individual_passport_info_issue_location">
                        <label class="passenger_individual_passport_info_title">發行地</label>
                        <select class="text_chinese" name="issue_location_<%= passengerName[i]%>" autocomplete="off">
                            <% for (Country c : countrys) {%>
                            <option class="text_chinese" style="font-size:16px;" value="<%= c.ordinal()%>" 
                                    <%= passengersInfos[i].getPassportIssuePlace() != null && passengersInfos[i].getPassportIssuePlace().ordinal() == c.ordinal() ? "selected=''" : ""%>>
                                <%= c.getNameTCN()%></option>
                                <%}%>
                        </select>
                    </div>
                    <div class="passenger_individual_passport_info_expiry_date">
                        <label class="passenger_individual_passport_info_title">效期</label>
                        <div>                            
                            <input class="passport_expiry_date" id="passport_expiry_date_<%= passengerName[i]%>" type="text" name="passport_expiry_date_<%= passengerName[i]%>"
                                   value="<%= passengersInfos[i].getPassportNumber() == null ? "" : passengersInfos[i].getPassportNumber()%>" autocomplete="off">
                        </div>
                    </div>
                </div>                             
            </div>
            <%}%>
            <div class="booking_system_title">
                <div class="booking_system_title_name">輸入連絡資訊</div>
            </div> 
            <div id="passenger_contact_info">
                <div>
                    <div>
                        <label class="passenger_contact_representative_info_title">旅客代表姓名</label>
                        <input style="background: #dddddd" class="representative_info_input" type="text" id="representative_name" name="customer_name" readonly>
                    </div>
                    <div>                        
                        <label class="passenger_contact_representative_info_title">居住地</label>
                        <input class="representative_info_input" style="font-family: 'cwtexhei', serif;background: #dddddd" type="text" id="representative_residence" name="customer_residence" autocomplete="off" readonly>
                    </div>
                    <div>
                        <label class="passenger_contact_representative_info_title">連絡電話</label>
                        <input class="representative_info_input" type="text" id="representative_phone" name="customer_phone" autocomplete="off">
                    </div>
                </div>
                <div>
                    <div>
                        <label class="passenger_contact_representative_info_title">電子郵件信箱</label>
                        <input class="representative_info_input" type="text" id="representative_email" name="customer_email" autocomplete="off">
                    </div>
                    <div>
                        <label class="passenger_contact_representative_info_title">再次確認電子郵件信箱</label>
                        <input class="representative_info_input" type="text" id="representative_email_repeat" name="customer_email_repeat" autocomplete="off">
                    </div>
                    <div>
                        <input type="checkbox" id="representative_info_restore" name="customer_info_restore">
                        <label for="representative_info_restore" class="passenger_contact_representative_info_title">儲存您的聯絡資料於下次購票時使用</label>
                    </div>
                </div>
            </div>

            <div class="booking_system_title">
                <div class="booking_system_title_name">輸入信用卡付款資訊</div>   
            </div>
            <div id="credit_pay_info">
                <div id="credit_pay_info_annotation">
                    <span>使用信用卡付款時，我們需要您輸入的驗證號碼，通過發卡公司的驗證並取得確認之後，
                        才會完成您的交易，並且顯示您的訂位代號及行程的畫面之後才確實您的訂位已經取得。 
                        所以在還沒有顯示您的訂位代號及行程的畫面之前，您的訂位是不確實的，敬請注意。</span>
                </div>
                <div id="credit_pay_info_keyin">
                    <div>
                        <div style="display: flex;">
                            <label>信用卡號</label>
                            <div style="margin: 0 6px;padding:0 4px;background: white;">
                                <img style="height: 16px;" src="/aac/image/booking/credit_card.gif" alt=""/>
                            </div>
                        </div>
                        <input type="text" id="credit_pay_info_keyin_number" name="ticketorder_credit_pay_info_keyin_number" autocomplete="off">
                    </div>
                    <div>
                        <label>卡片效期 (月/年)</label>
                        <div id="credit_pay_info_keyin_expiry">
                            <select id="credit_pay_info_keyin_expiry_month" name="ticketorder_credit_pay_info_keyin_expiry_month">                                                           
                                <option value="0">01</option>
                                <option value="1">02</option>
                                <option value="2">03</option>
                                <option value="3">04</option>
                                <option value="4">05</option>
                                <option value="5">06</option>
                                <option value="6">07</option>
                                <option value="7">08</option>
                                <option value="8">09</option>
                                <option value="9">10</option>
                                <option value="10">11</option>
                                <option value="11">12</option>
                            </select>
                            <select id="credit_pay_info_keyin_expiry_year" name="ticketorder_credit_pay_info_keyin_expiry_year">
                                <%
                                    SimpleDateFormat sdfYearOnly = new SimpleDateFormat("yyyy");
                                    Calendar cal = new GregorianCalendar();
                                    cal.setTime(new Date());
                                %>
                                <%
                                    for (int i = 0; i < 20; i++) {
                                %>
                                <option value="<%=sdfYearOnly.format(cal.getTime())%>" ><%= sdfYearOnly.format(cal.getTime())%></option>
                                <%
                                        cal.add(Calendar.YEAR, 1);
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div>
                        <label>驗證號碼</label>
                        <div style="display: flex;">
                            <input type="text" id="credit_pay_info_keyin_ccvnumber" name="credit_pay_info_keyin_ccvnumber" autocomplete="off">
                            <img style="margin: 4px 6px;height: 30px;" src="/aac/image/booking/credit_card_CVV.png" alt=""/>
                        </div>
                    </div>                            
                </div>
                <div id="credit_pay_info_total_amount">
                    <span style="margin: 0 0 0 70%;">
                        <span>總額</span>
                        <%
                            TicketOrder to = (TicketOrder) session.getAttribute("ticket_order");
                            int[] pricelist = null;
                            if (session.getAttribute("pricelist") != null) {
                                pricelist = (int[]) session.getAttribute("pricelist");
                            }
                            NumberFormat priceFormat = new DecimalFormat("$#,###");
                        %>
                        <span><%= to.getCabinClass() == null ? "" : priceFormat.format(pricelist[0])%></span>
                    </span>
                </div>
            </div>        
        </div>
    </div>
</div>

