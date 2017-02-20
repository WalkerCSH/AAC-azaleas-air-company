<%@page import="aac.domain.SeatsSelectedSet"%>
<%@page import="aac.domain.Passenger"%>
<%@page import="aac.domain.dataCategory.Gender"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="aac.domain.dataCategory.Country"%>
<%@page import="aac.domain.PassengerList"%>
<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<style>
    #passenger_info_table{
        margin: 10px;
    }
    .passenger_individual{
        margin: 20px 0 0 0;
        padding: 10px 40px;
        border-top: 2px #dddddd solid;
        box-sizing: border-box;
        display: flex;
        color: #666666;
    }
    .passenger_type{
        width: 70px;
        padding: 0 10px;
    }
    .passenger_type img{
        width: 50px;
        height: 50px;
        border-radius: 20px;
    }
    #passenger_representative{
        color: #ada8ff;
    }
    .info_details{
        box-sizing: border-box;
    }
    .passenger_input_items{
        display: inline-flex;
        flex-direction: column;
        padding: 0 12px;
    }
    .passenger_individual input{
        width: 180px;
        height: 30px;
        padding: 4px 12px;
        font-size: 16px;
        box-sizing: border-box;
        border-radius: 4px;
    }
    .passenger_name{
        padding: 8px 12px;
        width: 500px;
    }
    .passager_gender{
        display: inline-flex;
        flex-direction:column;
        padding: 10px;
    }
    .passager_gender input{
        width: 14px;
        height: 14px;
    }
    .residence{
        width: 180px;
        height: 30px;
        padding: 4px 12px;
        font-size: 16px;
        box-sizing: border-box;
        border-radius: 4px;
        font-family: 'cwtexhei', serif;
    }

    #passenger_seats{
        display: flex;
        flex-direction: row;
        padding: 20px 20px;
        box-sizing: border-box;
        border: 2px #dddddd solid;         
    }
    #passenger_seats img:first-child{
        width: 40px;
        height: fit-content;
    }
    #passenger_seats_title{
        font-size: 20px;
        padding: 10px 14px;
        box-sizing: border-box;
        width:120px;
    }
    #passenger_seats_link{
        width: 90px;
        height: 34px;
        margin: 12px 70px 12px 20px;
        font-size: 16px;
        color: #ffffff;
        background: #ada8ff;
        font-family: 'cwtexhei', serif;
        border-radius: 6px;
        box-sizing: border-box;
    }
    #passenger_infos_confirm{
        width: 120px;
        height: 60px;
        margin: 20px;
        font-size: 16px;
        color: #ffffff;
        background: #ada8ff;
        position: relative;
        left: 200px;
        font-family: 'cwtexhei', serif;
        border-radius: 6px;
        box-sizing: border-box;
    }

</style>
<%
    SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy-MM-dd");
    String[] passengerName = {"passenger_r", "passenger_1", "passenger_2", "passenger_3"};
    PassengerList pl = (PassengerList) session.getAttribute("passenger_list");
    int complete = 0;
    if (session.getAttribute("complete") != null) {
        complete = (Integer) session.getAttribute("complete");
    }
    if (complete == 1) {
        session.removeAttribute("errorlist");
    }
    int totalPassengers = pl.getAdultNumber() + pl.getChildNumber();
    Passenger[] pgArr = pl.getPassengerInfo();
    SeatsSelectedSet sss = (SeatsSelectedSet) session.getAttribute("seatsSelectedSet");
%>
<script type="text/javascript">
    function birthdayChangeHandler() {
//         alert("departureChangeHandler");
    $("#dn").attr("style", "display:none;");
    }
    $(function () {
    <% for (int i = 0; i < totalPassengers; i++) {%>
    <% if (complete == 1) {%>
    $("#birthday_<%= passengerName[i]%>").val('<%= sdfDateOnly.format(pgArr[i].getBirthday())%>');
    <%} else {%>
    $("#birthday_<%= passengerName[i]%>").datepicker({
    changeMonth: true,
            changeYear: true,
//            yearRange:"-15:+15",
            numberOfMonths: 1,
            showButtonPanel: true,
            minDate: "-102Y", maxDate: "<%= i == 0 ? "-12Y" : "-2Y"%>"
    });
    $("#birthday_<%= passengerName[i]%>").datepicker("option", "dateFormat", "yy-mm-dd");
    <%}%>
    <%}%>
    });
    function doneHandler() {
    location.replace(location);
    // 參考資料-畫面更新 : http://blog.yam.com/htshboy/article/12692684
    }
    function passengerInfosStoreHandler() {
    <%
        String[] passengerArr = {"passenger_r", "passenger_1", "passenger_2", "passenger_3"};
        for (int i = 0; i < totalPassengers; i++) {
    %>
    <%= "var firstname_" + passengerArr[i] + " = $('#firstname_" + passengerArr[i] + "').val();"%>
    <%= "var lastname_" + passengerArr[i] + " = $('#lastname_" + passengerArr[i] + "').val();"%>
    <%= "var gender_" + passengerArr[i] + " = $('#gender_" + passengerArr[i] + "').val();"%>
    <%= "var birthday_" + passengerArr[i] + " = $('#birthday_" + passengerArr[i] + "').val();"%>
    <%= "var residence_" + passengerArr[i] + " = $('#residence_" + passengerArr[i] + "').val();"%>
    <%}%>
    $.ajax({
    url: "passenger_seats_select.jsp",
            method: "POST",
            data: {
    <% for (int i = 0; i < totalPassengers; i++) {%>
    <%= "firstname_" + passengerArr[i] + ":firstname_" + passengerArr[i] + ","%>
    <%= "lastname_" + passengerArr[i] + ":lastname_" + passengerArr[i] + ","%>
    <%= "gender_" + passengerArr[i] + ":gender_" + passengerArr[i] + ","%>
    <%= "birthday_" + passengerArr[i] + ":birthday_" + passengerArr[i] + ","%>
    <%= "residence_" + passengerArr[i] + ":residence_" + passengerArr[i] + ","%>
    <%}%>
            }
    }).done(doneHandler);
    }
</script> 
<%
    int adult = pl.getAdultNumber();
    int child = pl.getChildNumber();
%>
<div style="padding: 10px 0 10px 15%;">
    <div class="booking_system_content">       
        <div class="booking_system_title">
            <div class="booking_system_title_name">輸入旅客資訊</div>                                
        </div>
        <div id="passenger_info_table">
            <% for (int i = 0; i < totalPassengers; i++) {%>
            <div class="passenger_individual">
                <div class="passenger_type">
                    <% if (adult > 0) { %>
                    <div class="type_name">成人</div>
                    <% --adult;
                    } else if (child > 0) {%>
                    <div class="type_name">兒童</div>
                    <% --child;
                        }%>
                    <img src="/aac/image/booking/logo_small.png" alt=""/>
                    <% if (i == 0) {%>
                    <div id="passenger_representative">旅客代表</div>
                    <%}%>
                </div>
                <div class="info_details">
                    <div class="passenger_name">
                        <div class="passenger_input_items">
                            <label>名 <span class="text_english">First Name</span></label>
                            <input class="passenger_firstname" id="firstname_<%= passengerName[i]%>" 
                                   name="firstname_<%= passengerName[i]%>" type="text" autocomplete="off" placeholder="(例)SHINSHIN" 
                                   required style="text-transform:uppercase" value="<%= pl.getPassengerInfo() != null ? pgArr[i].getFirstName() : ""%>" 
                                   <%= complete == 1 ? "readonly" : ""%>>
                        </div>
                        <div class="passenger_input_items">
                            <label>姓 <span class="text_english">Last Name</span></label>
                            <input class="passenger_lastname" id="lastname_<%= passengerName[i]%>" 
                                   name="lastname_<%= passengerName[i]%>" type="text" autocomplete="off" placeholder="(例)LEE" 
                                   required style="text-transform:uppercase" value="<%= pgArr != null ? pgArr[i].getLastName() : ""%>" 
                                   <%= complete == 1 ? "readonly" : ""%>>
                        </div>
                        <div class="passager_gender">
                            <select class="text_chinese" style="position:relative;top:20px;" id="gender_<%= passengerName[i]%>" 
                                    name="gender_<%= passengerName[i]%>" <%= complete == 1 ? "disabled" : ""%> required>
                                <%
                                    Gender[] genders = Gender.values();
                                    for (Gender g : genders) {%>
                                <option class="text_chinese" <%= (pgArr != null && pgArr[i].getGender().ordinal() == g.ordinal()) ? "selected=''" : ""%>
                                        value="<%= g.ordinal()%>"><%= g.getNameTCN()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="birthday_and_residence">
                        <div class="passenger_input_items">
                            <label>出生年月日</label>
                            <input id="birthday_<%= passengerName[i]%>" id="birthday_<%= passengerName[i]%>" 
                                   name="birthday_<%= passengerName[i]%>" type="text" <%= complete == 1 ? "readonly" : ""%> autocomplete="off" required >
                        </div>
                        <div class="passenger_input_items">
                            <label>居住地</label>
                            <% Country[] countrys = Country.values();%>
                            <select class='residence' id="residence_<%= passengerName[i]%>" name="residence_<%= passengerName[i]%>" <%= complete == 1 ? "disabled" : ""%> required>
                                <% for (Country c : countrys) {%>
                                <option class="text_chinese" <%= (pgArr != null && pgArr[i].getResidence().ordinal() == c.ordinal()) ? "selected=''" : ""%>
                                        value="<%= c.ordinal()%>"><%= c.getNameTCN()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <%}%>
            <script>
                $(".passenger_individual:even").attr("style", "background:#dddddd;");
                $(".passenger_individual:odd").attr("style", "background:#ccccff;");
            </script>
        </div>
        <input type="button" id="passenger_infos_confirm" value="<%= complete == 1 ? "資料完成傳送" : "傳送旅客資料"%>" 
               <%= complete != 1 ? "onclick='passengerInfosStoreHandler()'" : ""%>>
        <div id="passenger_seats" <%= complete != 1 ? "style='display:none'" : ""%>>
            <img src="/aac/image/booking/seats_select_title.png" alt="選擇座位"/>
            <div id="passenger_seats_title">選擇座位</div>
            <%= sss != null ? "" : "<a href='booking_system'>"%>
            <input type="button" id="passenger_seats_link" name="passenger_seats_link" value="<%= sss != null ? "選擇完成" : "選擇"%>" >
            <%= sss != null ? "" : "</a>"%>
            <img src="/aac/image/booking/seats_select_pic.png" alt="選擇座位"/>
        </div>
    </div>
</div>
