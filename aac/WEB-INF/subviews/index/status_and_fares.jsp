
<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<%@page import="aac.domain.dataCategory.FlightRoute"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<style>

    #status{
        width: 360px;
        height: 240px;
        position: relative;
    }
    .status_title{
        background:#a19bfe;
        color: white;
        font-size: 20px;
        text-align: center;
    }
    .status_content{
        padding: 0px;                
        text-align: center;
        list-style: none;
        border: 4px solid #a19bfe;
        box-sizing: border-box;
        margin: 0;
    }
    .status_content li{
        font-family: 'cwtexhei', serif;
        font-size: 18px;
        padding: 4px 0 ;
        border-top: 4px dotted #bbbbbb;
        background:#dbd9ff;
    }
    .status_content li:first-child{
        border-top: none;
    }
    #fares{
        width: auto;
        position: relative;
        left: 40px;
    }            
    #fares_title{                
        font-size: 30px;
        color:#a19bfe;
        font-weight: 600;
    }
    #fares_content{
        padding:20px 0; 
        box-sizing: border-box;
        width: 650px;
    }
    .fares_content_rows{
        display: inline-block;
        overflow: auto;
        padding: 0 10px;
        font-size: 18px;
        width: 300px;
        color: #444444;
    }
    .fares_content_rows_price{
        text-align: right;
        font-size:20px;
        color: #888888;
    }

</style>

<div id="status_and_fares">
    <div id="status">
        <div class="status_title">航班訊息</div>
        <ul class="status_content">
            <%! FlightRoute[] fsList = FlightRoute.values();%>
            <%
                for (FlightRoute fs : fsList) {
            %>
            <li>
                <span><%= fs.name()%></span>
                <span><%= fs.getTakeoffAirport().name()%> 飛往 <%= fs.getLandingAirport().name()%></span>
                <span><%= fs.getTakeoffScheduleTime()%></span>
                <span>準時</span>
            </li>                
            <%}%>
        </ul>
    </div>
    <div id="fares">
        <div id="fares_title">航班最佳票價</div>                        
        <div id="fares_content">                
            <% for (int i = 0; i < fsList.length; i++) {%>
            <div class="fares_content_rows">
                <span>
                    <%=fsList[i].getTakeoffAirport().name()%> / <%=fsList[i].getLandingAirport().name()%>
                </span><br>
                <span class="text_chinese">
                    <%=fsList[i].getTakeoffAirport().getName()%> / <%=fsList[i].getLandingAirport().getName()%>
                </span><br>
                <div class="fares_content_rows_price">TWD 3,800 up</div>                    
            </div>
            <%}%>
        </div>
    </div>
</div>
