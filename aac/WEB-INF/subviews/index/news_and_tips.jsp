<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<style>
    .news{
        width: 550px;
        height: 350px;
        position: relative;
        /*left: 12%;*/
    }
    .news_title {
        font-size:12px;
        color: white;
        width: inherit;
        text-align: left;
    }
    .news_title a{
        color: white;
    }
    .news_title span{
        font-size:30px;
        font-weight: 300; 
        border-bottom: white solid 2px;
        position: relative;
        margin: 0 330px 0 0;
    }
    .news_content{                
        padding: 10px 0;
        width: inherit;
    }
    .news_content ul{
        list-style: none;
        width: 470px;
        padding: 6px 10px;
        margin: 0;
    }
    .news_content_li{
        margin:0;
        width: inherit;
        padding: 6px 12px;
        color: #333333;
        background: white;
    }
    .news_content_ul_li_even{
        color: #ffffff;
        background: #9999ff;
    }
    .tips{
        position: relative;
        top: 60px;
        left: 6%;
        display: inline-flex;
    }
    .tip_flight_class,.tips_luggage,.tips_transport{
        width: 160px;
        height: 300px;
        background: white;
    }
    .flight_class_title,.luggage_title,.transport_title{
        font-size:18px;
        color: #333333;
        padding: 8px 16px;
        box-sizing: border-box;
    }
    .transport_title{
        margin: auto;
    }
    .flight_class_content,.luggage_content,.transport_content{
        font-size:12px;
        color: #999999;
        padding: 4px 16px;
        box-sizing: border-box;
    }
    .transport_content{
        width: inherit;
    }
    .tips_img{
        width:inherit;
        text-align: center;
    }
</style> 
<script type="text/javascript">
    $(document).ready(init);
    function init() {
        $(".news_content_li:even").addClass("news_content_ul_li_even");
    }
</script>
<div id="news_and_tips">
    <div class="news">
        <div class="news_title">
            <span>最新訊息</span>
            <a href="">更多訊息</a> 
            <img src="/aac/image/arrows/step_white.png" style="width:8px;" alt=""/>
        </div>
        <div class="news_content">
            <ul>
                <li class="news_content_li">慶祝杜鵑航空三條首發航線開航，優惠航班票價最低5折!!!</li>
                <li class="news_content_li">[重要訊息]杜鵑航空日本東京航線開航</li>
                <li class="news_content_li">[重要訊息]杜鵑航空新加坡航線開航</li>
                <li class="news_content_li">[重要訊息]杜鵑航空泰國曼谷航線開航</li>
                <li class="news_content_li">部份航班出發 / 抵達時間變更通知</li>
                <li class="news_content_li">杜鵑航空致力於促進大東亞旅遊活絡和諧</li>
                <li class="news_content_li">杜鵑航空與熊斯旅遊、渴熱旅遊自由行合作方案</li>
                <li class="news_content_li">[重要通知]有關旅客機場稅退稅徵收手續費事宜</li>
            </ul>
        </div>
    </div>
    <div class="tips">
        <div class="tip_flight_class">
            <div class="flight_class_title">三種座艙類行</div>
            <div class="flight_class_content">針對不同需求，設計最適合的票價與服務。</div>
            <div class="tips_img"><img src="/aac/image/index/tips_flight_class.png" alt=""/></div>
        </div>
        <div class="tips_luggage">
            <div class="luggage_title">行李大小事</div>
            <div class="luggage_content">手提行李、託運行李尺寸及重量相關規定。</div>
            <div class="tips_img"><img src="/aac/image/index/tips_luggage.png" style="text-align: center;" alt=""/></div>
        </div>
        <div class="tips_transport">
            <div class="transport_title">出遊快易通</div>
            <div class="transport_content">利用高鐵、桃機快捷等便利的交通工具，出遊說走就走！</div>
            <div class="tips_img"><img src="/aac/image/index/tips_transport.png" alt=""/></div>
        </div>
    </div>
</div>
