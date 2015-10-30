<%-- 
    Document   : index
    Created on : 22/10/2015, 05:30:02 PM
    Author     : miguel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>

<%
    if (session.getAttribute("userid") != null) {
        response.sendRedirect(response.encodeRedirectURL("listfiles.jsp"));
    }
%>
<html>
    <head>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <script src="js/jquery-2.1.4.js"></script>
        <title>Gugle Drive</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="css/main.css" />
    </head>
    <body class="loading">
        <div id="wrapper">
            <div id="bg"></div>
            <div id="overlay"></div>
            <div id="main">

                <header id="header">
                    <h1>Asho Drives</h1>
                    <p id="s1">Pagina de Inicio de Sesion</p>
                    <p id="s2">Registro de Usuarios</p>
                    <br><br>
                    <% if (request.getAttribute("resultado") == "error") { %>
                    <p id="msgok" class="alert alert-danger" role="alert">Usuario o Contraseña incorrecta</p>
                    <% }%>

                    <form id="log" class="form-horizontal" method="POST" action="Login">
                        <div class="form-group" style="margin-left: 25%; margin-right: 25%;">
                            <label for="correo" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="correo" id="correo" placeholder="user@place.com">
                            </div>
                        </div>
                        <div class="form-group" style="margin-left: 25%; margin-right: 25%;">
                            <label for="pass" class="col-sm-2 control-label">Password</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" name="password" id="pass">
                            </div>
                        </div>       
                        
                        <div class="form-inline" style="margin-left: 25%; margin-right: 25%;">
                            <button class="btn btn-danger form-control" style="margin-right: 20px;" type="submit"> Login </button>
                            <button id="switch1" class="btn btn-danger form-control" type="button">Usuario Nuevo</button>
                        </div>  
                    </form>

                    <form id="register" class="form-horizontal" method="POST" action="Register">
                        <div class="form-group" style="margin-left: 25%; margin-right: 25%;">
                            <label for="correo" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="correo" id="correo" placeholder="user@place.com">
                            </div>
                        </div>
                        <div class="form-group" style="margin-left: 25%; margin-right: 25%;">
                            <label for="pass" class="col-sm-2 control-label">Password</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" name="password" id="pass">
                            </div>
                        </div>
                        
                        <div class="form-inline" style="margin-left: 25%; margin-right: 25%;">
                            <button class="btn btn-danger form-control" style="margin-right: 20px;" type="submit"> Registrarse </button>
                            <button id="switch2" class="btn btn-danger form-control" type="button">Volver Login</button>
                        </div>  
                    </form>

                </header>

                <footer id="footer">
                    <span class="copyright">&copy; Untitled. Design: <a href="http://html5up.net">HTML5 UP</a>.</span>
                </footer>

            </div>
        </div>
        <script>
            window.onload = function () {
                document.body.className = '';
            }
            window.ontouchmove = function () {
                return false;
            }
            window.onorientationchange = function () {
                document.body.scrollTop = 0;
            }

            $('#register').hide();
            $('#s2').hide();
            
            $('#switch1').on('click',function(){
                $('#log').hide();
                $('#register').show();
                $('#s2').show();
                $('#s1').hide();
            });
            
            $('#switch2').on('click',function(){
                $('#log').show();
                $('#register').hide();
                $('#s1').show();
                $('#s2').hide();
            });
            
        </script>
    </body>
</html>