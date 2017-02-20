<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<style>
    #container{
        width: 100%;
        min-width: 1200px;
        height: 400px;
        position: absolute;
        top: 3%;
        box-sizing: border-box;
        /*left: -55px;*/
    }
    #container img{
        display:block;
        position:absolute;
        width: 100%;
        /*height: 400px;*/
    }

</style>
<script type="text/javascript">
    var photpkArr = ["tw", "jp", "sin", "tha"];
    var index = 0;
    var photoNum = 4;
    var setInt = setInterval(changePhotoHandler, 7000); // 將 setInterval() 指派變數的用意在於之後的計時器歸零停止行為
    $(document).ready(init);
    function init() {
        for (var i = 0; i < photoNum; i++) {
            $("#container").append("<img src='/aac/image/index/travel_" + photpkArr[i] + ".png'>");
        }
        $("#container img:gt(0)").animate({"opacity": 0}, 0);
    }
    function changePhotoHandler(e) {
        index++;
        index %= photoNum; // 將 index%photoNum 餘數指派給index 造成循環效果
        console.log(index);
        $("#container img").not(".outer img:eq(" + index + ")").animate({"opacity": 0}, 1000); // 排除目前這張照片 其他變成透明 eq() 是等於的意思
        $("#container img:eq(" + index + ")").animate({"opacity": 1}, 800); // animate({"opacity":1},500) 使用透明變化功能
    }
</script>
<div id="ticker">
    <div id='container'></div>
</div>

