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
        <title>杜鵑航空 Azaleas Air - 享受飛行 , 豐富生命 Enjoy Our Flight , Enrich Our Lives</title>
        <link href="asset/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <link href="asset/css/main_design.css" rel="stylesheet" type="text/css"/>
        <script src="asset/jquery/jquery.js" type="text/javascript"></script>
        <script src="asset/jquery/jquery-ui.js" type="text/javascript"></script>
    </head>
    <body>
        <jsp:include page="WEB-INF/subviews/index/header.jsp"></jsp:include>
        <jsp:include page="WEB-INF/subviews/index/search.jsp"></jsp:include>
        <jsp:include page="WEB-INF/subviews/index/ticker.jsp"></jsp:include>        
        <%@include file="WEB-INF/subviews/index/status_and_fares.jsp" %>
        <%@include file="WEB-INF/subviews/index/news_and_tips.jsp" %>
        <%@include file="WEB-INF/subviews/index/travel_guide.jsp" %>
        <%@include file="WEB-INF/subviews/index/footer.jsp" %>
    </body>
</html>
