<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<style>
    #seats_map_depart{
        width: 448px;
        height: 600px;
        background-image: url("/aac/image/booking/seat_plane_bg.jpg");
        background-attachment: local;
        overflow-y: scroll;
        z-index: 10;
        position: absolute;
    }
    .eco_seats_area{
        position:relative;
        top: 130px;
        margin: auto;
        padding: 60px 0 0;
        width: 340px;
        height: 400px;
        display: inline-flex;
        background: yellow;
    }
    .aisle{
        width: 20px;
        height: 400px;
        background: #dddddd;
        box-sizing:border-box;
    }
    #aisle_left{

    }
    #aisle_right{

    }
    .colunm{
        width:30px;
        height: 400px;
        /*                background: blue;*/
        border: 1px dotted white;
        box-sizing: border-box;
    }
    .seat_avail{
        width:30px;
        height:30px;
        margin: 10px 0 0;
        background: url("/aac/image/booking/seat_normal.png") 0 0% no-repeat;
        background-size: 90px 30px;
        font-size: 1px;
        color: #666666;
        box-sizing: border-box;
    }
    .seat_avail input{
        font-size: 6px;
    }
    .seat_occupied{
        width:30px;
        height:30px;
        margin: 10px 0 0;
        background: url("/aac/image/booking/seat_normal.png")no-repeat;
        background-position: -30px 0;
        background-size: 90px 30px;

        box-sizing: border-box;
    }
    .seat_selected{
        width:30px;
        height:30px;
        margin: 10px 0 0;
        background: url("/aac/image/booking/seat_normal.png")no-repeat;
        background-position: -60px 0;
        background-size: 90px 30px;
        box-sizing: border-box;

    }

</style>
<script type="text/javascript">


    $(document).ready(readyHandler);

    function readyHandler() {
        var ecoSeatsArea = ["A", "B", "C"];
        var colArr = ["a", "c", "d", "left", "e", "f",
            "g", "h", "right", "i", "j", "l"];

//                alert("ecoSeatsArea.length = " + ecoSeatsArea.length);
        for (var i = 0; i < ecoSeatsArea.length; i++) {
            $("#seats_map").append("<div class=\"seats_area\" id=seats_area_" + ecoSeatsArea[i] + "></div>");
            for (var j = 0; j < colArr.length; j++) {
                if (j == 3) {
                    $("#seats_area_" + ecoSeatsArea[i]).
                            append("<div class=\"aisle\" id=aisle_" + colArr[j] + "_at_" + ecoSeatsArea[i] + ">" + ecoSeatsArea[i] + "</div>");
                } else if (j == 8) {
                    $("#seats_area_" + ecoSeatsArea[i]).
                            append("<div class=\"aisle\" id=aisle_" + colArr[j] + "_at_" + ecoSeatsArea[i] + ">" + ecoSeatsArea[i] + "</div>");
                } else {
                    var sah = $(".seats_area").height();
                    var colSeatNum = sah / 40;
                    $("#seats_area_" + ecoSeatsArea[i]).
                            append("<div class=\"colunm\" id=colunm_" + colArr[j] + "_at_" + ecoSeatsArea[i] + "></div>");
                    for (var k = 0; k < colSeatNum; k++) {
                        $("#colunm_" + colArr[j] + "_at_" + ecoSeatsArea[i]).
                                append("<input type='button' class='seat_avail' id=" + ecoSeatsArea[i] + colArr[j] + (k + 1) +
                                        " name=" + ecoSeatsArea[i] + colArr[j] + (k + 1) +
                                        " value=" + ecoSeatsArea[i] + colArr[j] + (k + 1) + ">");
                    }
                }

            }
        }
        $(".seat_avail").click(seatIdCaller);
    }
    function seatIdCaller() {
        alert("座位id: " + this.id);
    }
</script>

<div id="seats_map_depart">
    <!--                    <div class="seats_area">
                            <div class="colunm" id="colunm_a"></div>
                            <div class="colunm" id="colunm_c"></div>
                            <div class="colunm" id="colunm_d"></div>
                            <div class="aisle" id="aisle_left"></div>
                            <div class="colunm" id="colunm_e"></div>
                            <div class="colunm" id="colunm_f"></div>
                            <div class="colunm" id="colunm_g"></div>
                            <div class="colunm" id="colunm_h"></div>
                            <div class="aisle" id="aisle_right"></div>
                            <div class="colunm" id="colunm_i"></div>
                            <div class="colunm" id="colunm_j"></div>
                            <div class="colunm" id="colunm_l"></div>
                        </div>-->
</div>

