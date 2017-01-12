<%@page contentType="text/html" pageEncoding="UTF-8" info="首頁"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <link href="CSSstyle/mainCinemaStyle.css" rel="stylesheet" type="text/css"/>
    <link href="CSSstyle/formStyle.css" rel="stylesheet" type="text/css"/>
    <head>
        <title>Member Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            .form{                
                width: 400px;
            }
        </style>

    </head>
    <body>
        <div class="form">
            <div class="loginTitle">
                <p><h3>Member Sign in</h3></p>            
            </div>
            <form name="formContent">
                <table>
                    <p>
                        <span class="rowTitle"><label for="email">Email</label></span><br>
                        <span><input id="email" type="text" name="txt"/></span>
                    </p>
                    <p>
                        <span class="rowTitle"><label for="webPassword">Web Password</label></span><br>
                        <span><input id="webPassword" type="password" name="txt"/></span>
                    </p>
                    <br><br>                  
                    <a href="">Forgot your password?</a>
                    <div>
                        <!--打勾選項 可選可不選--->
                        <input id="remember" type="checkbox" name="remember" value="1"/>Remember my information
                    </div>                  
                    <p>
                        <a href="MemberApplication.html">Join our Azaleas Mileage Club</a>                        
                    </p> 
                    <p>
                        <input  id="submit" type="submit" value="Login"/>
                    </p>
                </table>               
            </form>
        </div>
    </body>
</html>
