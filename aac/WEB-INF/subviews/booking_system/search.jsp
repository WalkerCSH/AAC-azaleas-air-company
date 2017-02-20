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
        <title>booking_system_search</title>
        <link href="/azaleas/asset/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <link href="/azaleas/asset/css/main_design.css" rel="stylesheet" type="text/css"/>
        <link href="/azaleas/asset/css/booking_system_design.css" rel="stylesheet" type="text/css"/>
        <style>
            
            .booking_system_title_name{
                width: 100%;
                text-align: center;
            }
            .booking_system_search_trip_type>div{
                display: inline-flex;
                background: #666666;
                color: white;
                width: 140px;
                height: 40px;
                font-size: 14px;
                border: #eeeeee 2px solid;
                border-radius: 4px;
                margin: 20px 20px 10px;
                padding: 9px 48px;
                box-sizing: border-box;                
            }
            .flight_airport>select{
                display: inline-flex;
                background: #999999;
                color: white;
                width: 240px;                
                height: 40px;                
                font-size: 18px;
                border: #eeeeee 2px solid;
                border-radius: 20px;
                margin: 10px 5px;
                padding: 7px 20px;
                box-sizing: border-box;
                font-family: 'cwtexhei', serif;
            }
            .booking_system_search_airport_and_date{
                display: inline-flex;
            }
            .booking_system_search_flight_date{
                margin: 0 0px 0 40px;
                display: inline-flex;                
            }            
            #search_departure_date, #search_return_date{                
                border-radius: 4px;
                font-size:14px;
                padding: 6px 14px;
                width: 140px;
                height: 40px;                
                font-size: 14px;
                border: #eeeeee 2px solid;
                border-radius: 20px;
                margin: 10px 5px;
                padding: 12px 20px;
                box-sizing: border-box;
                font-family: 'cwtexhei', serif;
                background: #dddddd;
            }
            .icon_calendar{
                /*position: relative;*/
                width: 22px;
                height: 20px;
                position: relative;
                top: 20px;
                right: 40px;
                cursor: pointer;
            }
            .booking_system_search_set_and_coupon{
                display:inline-flex;
                margin: 10px 0;
            }
            .passenger_set{
                display:inline-flex;                
                width: auto;
                list-style: none;
                padding: 0px;
                margin: 0;
            }
            .passager_set_col{
                width: 90px;
                background:#777777;
                margin: 0px 4px;
                font-size: 14px;
                padding: 6px 4px;
                text-align: center;
                border-radius: 4px;
                color: white;               
            }
            .passager_set_col input{
                text-align: center;
                color: #6699ff;
                padding: 4px 6px;
                margin: 4px 0;
                font-size: 16px;
                font-weight: 600;
            }
            .coupon{
                padding: 26px 60px 26px 80px;
            }
            #coupon{
                font-size: 14px;
                font-weight: 600;
                padding: 8px 16px;
                border-radius: 4px;                
            }
            .booking_system_search_search_button{
                padding: 20px;
                display: inline-flex;
            }
            #search_search_button{
                width:300px;
                font-family: 'Muli', sans-serif;
                font-size: 24px;
                padding: 8px 0 8px 34px;
                border-radius: 6px;
                color: white;
                background: #9999ff 35% 50%;
                background-image: url("/azaleas/image/booking/search_w.png");
                background-repeat: no-repeat;
                background-size:32px;
            }
        </style>

        <script src="/azaleas/asset/jquery/jquery.js" type="text/javascript"></script>
        <script src="/azaleas/asset/jquery/jquery-ui.js" type="text/javascript"></script>
        <script type="text/javascript">
            var now = 0;
            $(document).ready(init);
            function init() {
                $("#search_departure_date").datepicker();
                $("#search_return_date").datepicker();
//                $("#search_search_button").click(bookingHtmlArr[now + 1]);
            }
        </script>
    </head>
    <body>
        <div style="margin: 30px 180px;box-sizing: border-box;display: inline-flex;">
            <div class="booking_system_content">
                <div class="booking_system_title">
                    <div class="booking_system_title_name">搜尋航班</div>
                </div>
                <form method="GET" action="">
                    <div class="booking_system_search_trip_type">
                        <div id="round_trip"><span>來回</span></div>
                        <div id="one_way"><span>單程</span></div>
                    </div>
                    <div class="booking_system_search_airport_and_date">               
                        <div class='flight_airport'>
                            <select id='departure' name="select">
                                <option class='blank_option' ></option>
                                <option>台北桃園，台灣</option>
                                <option>東京成田，日本</option>
                                <option>新加坡，新加坡</option>
                                <option>曼谷，泰國</option>
                            </select>
                            <select id='destination' name="select">
                                <option class='blank_option' ></option>
                                <option>台北桃園，台灣</option>
                                <option>東京成田，日本</option>
                                <option>新加坡，新加坡</option>
                                <option>曼谷，泰國</option>
                            </select>
                        </div>
                        <div class="booking_system_search_flight_date">
                            <input type="text" id="search_departure_date" placeholder="出發日">
                            <div class="icon_calendar" id="departure_calendar"> 
                                <img src="/azaleas/image/icon/calender.gif" alt=""/>
                            </div>                        
                            <input type="text" id="search_return_date" placeholder="返回日">
                            <div class="icon_calendar" id="return_calendar"> 
                                <img src="/azaleas/image/icon/calender.gif" alt=""/>
                            </div>
                        </div>
                    </div> 
                    <div class="booking_system_search_set_and_coupon">
                        <div class="passenger_set">
                            <div class="passager_set_col">
                                <div>成人</div>
                                <input id="passager_set_adult" type="number" max="4" min="1" placeholder="1">
                                <div>12+</div>
                            </div>
                            <div class="passager_set_col">
                                <div>孩童</div>
                                <input id="passager_set_child" type="number" max="4" min="0" placeholder="0">
                                <div>2~11</div>
                            </div>
                            <div class="passager_set_col">
                                <div>幼童</div>
                                <input id="passager_set_infant" type="number" max="4" min="0" placeholder="0">
                                <div>0~1</div>
                            </div>
                        </div>
                        <div class="coupon">
                            <input type="text" id="coupon" placeholder="優惠代碼">
                        </div>                        
                    </div>
                    <div class="booking_system_search_search_button">                                            
                        <input type="submit" id="search_search_button" value="Let's Go!" name="search_search_button">
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
