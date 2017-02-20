<%-- 
    Document   : search_condition
    Created on : 2016/10/6, 下午 02:35:43
    Author     : Administrator
--%>

<%@page import="aac.domain.PassengerList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="aac.domain.TicketOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    TicketOrder to = (TicketOrder) session.getAttribute("ticket_order");
    PassengerList pl = (PassengerList) session.getAttribute("passenger_list");
    SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfWeekdayName = new SimpleDateFormat("E");
%>
<div class="search_condition">
    <div class="flight_airport">
        <div id='departure'><span><%= to.getDepartFlightRoute().getTakeoffAirport().name()%>
            </span><%= to.getDepartFlightRoute().getTakeoffAirport().getCity()%></div>
        <div>            
            <img id="trip_type" src='/aac/image/booking/<%= to.getFlightType().ordinal() == 0 ? "round_trip.png" : "one_way.png"%>' alt=""/>
        </div>
        <div id='destination'><span><%= to.getDepartFlightRoute().getLandingAirport().name()%>
            </span><%= to.getDepartFlightRoute().getLandingAirport().getCity()%></div>
    </div>

    <div class="booking_system_search_flight_date">
        <div id='booking_departure_date'>
            出發日 : <span><%= sdfDateOnly.format(to.getDepartDate())%></span>
            <%= sdfWeekdayName.format(to.getDepartDate())%>
        </div>
        <% if (to.getFlightType().ordinal() == 0) {%>
        <div id='booking_return_date'>
            返回日 : <span><%= sdfDateOnly.format(to.getReturnDate())%></span>
            <%= sdfWeekdayName.format(to.getReturnDate())%>
        </div>
        <%}%>
    </div>
    <div class="passenger_set">
        <div id="passager_set_adult">成人 <span>x <%= pl.getAdultNumber()%></span></div>
        <div id='passager_set_child'>孩童 <span>x <%= pl.getChildNumber()%></span></div>
        <div id='passager_set_infant'>幼童 <span>x <%= pl.getInfantNumber()%></span></div>
    </div>
    <div class="search_resume">                    
        <a href="booking_system"><input type="button" id="search_resume" value="重新搜尋"></a>
    </div>
</div>
