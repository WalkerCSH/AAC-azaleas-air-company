<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<style>
    #statement{
        width: inherit;
        height: inherit;
        box-sizing: border-box;
        margin: 0;
        padding: 15px 14%;
        display: block;
    }
    #statement ul{       
        margin: 0;
        padding: 0;
        display: inline;
    }
    #statement ul li{
        color:#444444;
        display: inline;
        border-right:2px #444444 solid;
        list-style: none;
        box-sizing: border-box;
        padding: 0 4px;
        font-size: 12px;
    }
    #statement li a{
        color:#444444;
    }
    #statement li:last-child{
        border-right: none;
    }
    #statement>div{
        color: #777777;
        text-align: right;
        font-family: 'Muli', sans-serif;
        margin: 0 0 0 25%;
        display: inline;
    }
</style>
<footer>
    <div id="statement">
        <ul>
            <li><a href="">網站服務條款</a></li>
            <li><a href="">運輸條款</a></li>
            <li><a href="">隱私權聲明</a></li>
            <li><a href="">關於杜鵑航空</a></li>
        </ul>
        <div>Copyright © 2016   Azaleas Air</div>
    </div>
</footer>
