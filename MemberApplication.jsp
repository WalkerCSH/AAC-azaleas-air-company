<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <link href="/aac/asset/css/formStyle.css" rel="stylesheet" type="text/css"/>
        <title>Member Application</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            .form{
                min-width: 700px;
            }
            .rowTitle{
                width: 200px;
            }
            table{
                min-width: 700px;
                width: 90%;
                margin: auto;
            }
            td{
                height: 60px;
                background: #f3b7ff;                
            }            
            .birthday input{
                width: 80px;
            }
            #year{
                width:100px;
            }
        </style>
    </head>
    <body>
        <div class="form">
            <div class="formInfo">                
                <p><h3>Member Application</h3></p>
                <p>Please provide all of the required information below and click the Submit button</p>
                <p>
                    Items with an asterisk (*) next to them are necessary.<br>
                    Please input your name as it appears in your passport.<br>
                    You would use your email to be login account, so please input your most commonly used email.
                </p>
            </div>
            <form name="formContent">
                <table>                    
                    <td class="rowTitle"><label for="honor">*Honor</label></td>
                    <td>
                        <select name="select"> <!--表單式單選--->
                            <option>Mr</option>
                            <option>Ms</option>
                            <option>Dr</option>
                            <option>Prof</option>
                        </select>
                    </td>                    
                </table>         
                <table>                   
                    <td class="rowTitle">*Name</td>
                    <td>
                        <label for="givenName">Given Name</label><br>
                        <input id="givenName" type="text" name="txt"/>
                    </td>
                    <td>
                        <label for="familyName">Family Name</label><br>
                        <input id="familyName" type="text" name="txt"/>
                    </td>                    
                </table>
                <table>
                    <td class="rowTitle"><label for="email">*Email</label><br>(login account)</td>
                    <td><input id="email" type="text" name="txt"/></td>
                </table>
                <table>                   
                    <td class="rowTitle"><label for="webPassword">*Web Password</label></td>
                    <td>
                        <span>Must be between 8 and 16 digits in length</span><br>                        
                        <input id="webPassword" type="password" name="txt"/><br>
                        <span>Please re-enter Web Password.</span><br>
                        <input id="reEnter" type="password" name="txt"/>
                    </td>                    
                </table>
                <table>
                    <td class="rowTitle"><label for="passportNumber">*Passport Number</label></td>
                    <td><span>For your ticket purchasing process in the future</span><br>
                        <input id="passportNumber" type="text" name="txt"/></td>                    
                </table>
                <table>
                    <td class="rowTitle"><label for="country">*Country</label></td>
                    <td>
                        <select name="select"> <!--表單式單選--->
                            <option>USA</option>
                            <option>JPN</option>
                            <option>TWN</option>
                    </td>                                    
                </table>
                <table>
                    <td class="rowTitle"><label>*Genter</label></td><!--多選一 以name為分組依據--->
                    <td>                        
                        <input type="radio" name="genter" value="1"/>Male                        
                        <input type="radio" name="genter" value="2"/>Female 
                    </td>                  
                </table>
                <table class="birthday">
                    <td class="rowTitle">*Birthday<br>(yyyy/mm/dd)</td>
                    <td><label for="year">Year</label><br><input id="year" style="width: 180px;" type="date" name="txt"/></td>
                    <td><label for="month">Month</label><br><input id="month" style="width: 160px;" type="month" name="txt"/></td>
                    <td><label for="day">Day</label><br><input id="day" style="width: 140px;" type="time" name="txt"/></td>
                </table>                
                <table>
                    <td class="rowTitle"><label>Married</label></td><!--多選一 以name為分組依據--->
                    <td>                        
                        <input type="radio" name="married" value="1"/>Yes                        
                        <input type="radio" name="married" value="2"/>No 
                    </td>                  
                </table>                
                <table>
                    <td class="rowTitle"><label for="phone">*Phone</label></td>
                    <td><input id="phone" type="text" name="txt"/></td>
                </table>                
                <p><!--space--></p>
                <p>
                    <input  id="submit" type="submit" value="Submit"/>
                </p>
            </form>
        </div>
    </body>
</html>
