<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<style>
    #guide_title{
        margin: auto;
        font-size: 16px;
        color: #3a3eff;
    }
    #guide_title>span{
        border-bottom: #3a3eff solid 2px;
    }
    #guide_title>span>span:first-child{
        font-family: 'Muli', sans-serif;
        font-size: 34px;
        padding: 0 14px 0 0;

    }
    #guide_title>span>span:last-child{
        position: relative;
    }
    #guide_content{
        padding: 20px 0px;
        margin:auto;
        box-sizing: border-box;
        height: 300px;
        width: 1000px;
        display: inline-flex;
    }
    .guide_content_pics{
        width: 250px;
        margin: 0px;
    }
    .guide_content_pics:last-child{
        width: 150px;
    }
    .guide_content_pics>div{
        height: 24px;
        padding: 10px 16px 0;
    }
    .guide_content_pics a{
        color: #6699ff;
    }
    .arrows{
        height: 170px;
        padding: 70px 0;
    }
</style>
<div id="travel_guide">
    <div id="guide_title"><span><span>Travel Guide</span> <span>跟杜鵑一起樂吃購</span></span></div>
    <div id="guide_content">
        <div class="guide_content_pics">
            <img src="/aac/image/index/tg_preparation_tw.png" alt=""/>
            <div><a href="" >行程確認 / 變更</a></div>
            <div><a href="">網路登機</a></div>
            <div><a href="">手提行李</a></div>
        </div>                        
        <div class="arrows">
            <img src="/aac/image/arrows/index_right.png" alt=""/>
        </div>
        <div class="guide_content_pics">
            <img src="/aac/image/index/tg_airport_tw.png" alt=""/>
            <div><a href="" >機場交通</a></div>
            <div><a href="">報到櫃檯</a></div>                            
        </div>
        <div class="arrows">
            <img src="/aac/image/arrows/index_right.png" alt=""/>
        </div>
        <div class="guide_content_pics">
            <img src="/aac/image/index/tg_inflight_tw.png" alt=""/>
            <div><a href="" >機型 / 座位圖</a></div>
            <div><a href="">餐點 / 免稅商品</a></div>                            
        </div>
        <div class="arrows">
            <img src="/aac/image/arrows/index_right.png" alt=""/>
        </div>
        <div class="guide_content_pics">
            <img src="/aac/image/index/tg_destination_tw.png" alt=""/>
            <div><a href="" >旅館</a></div>
            <div><a href="">當地交通</a></div>                            
        </div>
    </div>
</div>
