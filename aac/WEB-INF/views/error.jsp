<%-- 
    Document   : error
    Created on : 2016/10/10, 上午 10:01:48
    Author     : Walker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">        
    <title>杜鵑航空 Azaleas Air - 享受飛行 , 豐富生活 Enjoy Our Flight , Enrich Our Lives</title>
    <link href="/aac/asset/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
    <link href="/aac/asset/css/main_design.css" rel="stylesheet" type="text/css"/>
    <link href="/aac/asset/css/booking_system_design.css" rel="stylesheet" type="text/css"/>
    <script src="/aac/asset/jquery/jquery.js" type="text/javascript"></script>
    <script src="/aac/asset/jquery/jquery-ui.js" type="text/javascript"></script>
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
    <jsp:include page="/WEB-INF/subviews/index/header.jsp"></jsp:include>   
        <div style="width:60%;height: 600px; margin: auto;position: relative;top: 80px;">
            <img style="width:100%; margin: auto;" src="/aac/image/index/404.jpg" alt=""/>
        </div>
        <div style="float: right;position: relative;top: -40px;right:200px">
            <span><a href="/aac" onclick="gotoUrl('/aac')" style="font-size: 20px;">回到首頁</a></span>
        </div>
    <jsp:include page="/WEB-INF/subviews/index/footer.jsp"></jsp:include>
</html>
