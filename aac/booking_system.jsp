<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="aac.domain.TicketOrder"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="aac.domain.dataCategory.Aircraft"%>
<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <title>杜鵑航空 Azaleas Air - 享受飛行 , 豐富生活 Enjoy Our Flight , Enrich Our Lives</title>
        <link href="/aac/asset/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <link href="/aac/asset/css/main_design.css" rel="stylesheet" type="text/css"/>
        <link href="/aac/asset/css/booking_system_design.css" rel="stylesheet" type="text/css"/> 
        <script src="/aac/asset/jquery/jquery.js" type="text/javascript"></script>
        <script src="/aac/asset/jquery/jquery-ui.js" type="text/javascript"></script>

        <%
            int bsPage = (int) session.getAttribute("bs_page");            
        %>
    </head>
    <body>      

        <jsp:include page="WEB-INF/subviews/booking_system/header.jsp"></jsp:include>        
            <div style="height: 70px;width: inherit;"></div>
        <% if ((bsPage != 0) && (bsPage != 4)) {%>
        <jsp:include page="WEB-INF/subviews/booking_system/search_condition.jsp"></jsp:include>
        <%}%>
        <%= bsPage == 4 ? "" : "<form method='POST' action='booking_system'>"%>
        <% if ((bsPage != 0) && (bsPage != 4)) {%>
        <div id="display_area">
            <% if (bsPage == 0) {%>
            <jsp:include page="WEB-INF/subviews/booking_system/search.jsp"></jsp:include>                
            <% }%>            
            <div id="display_area_left">                
                <% if (bsPage == 1) {%>
                <jsp:include page="WEB-INF/subviews/booking_system/flight_select.jsp"></jsp:include>                
                <% }%>
                <% if (bsPage == 2) {%>
                <jsp:include page="WEB-INF/subviews/booking_system/passenger_service.jsp"></jsp:include>
                <%}%>
                <% if (bsPage == 21) {%>
                <jsp:include page="WEB-INF/subviews/booking_system/passenger_seats_select.jsp"></jsp:include>
                <%}%>
                <% if (bsPage == 3) {%>
                <jsp:include page="WEB-INF/subviews/booking_system/credit_pay.jsp"></jsp:include>
                <%}%>                
            </div>
            <div id="display_area_right">
                <jsp:include page="WEB-INF/subviews/booking_system/booking_summary.jsp"></jsp:include>
                </div>
            <%}%>
            <% if (bsPage == 4) {%>
            <jsp:include page="WEB-INF/subviews/booking_system/prepare_aboard.jsp"></jsp:include>
            <%}%>
        </div>
        <%= bsPage == 4 ? "" : "</form>"%>
        <%@include file="WEB-INF/subviews/index/footer.jsp"%>            
    </body>
</html>
