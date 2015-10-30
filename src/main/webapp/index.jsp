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

                <%
                    if (request.getAttribute("resultado") == "error") {
                %>
                <div id="msgok" class="alert alert-danger" role="alert">Usuario o Contraseña incorrecta</div>
                <%
                    }
                %>

                <header id="header">
                    <h1>Gugle Drive</h1>
                    <p></p>
                    <form class="form-horizontal" method="POST" action="Login">

                        <div class="form-group" style="margin-left: 30%; margin-right: 30%;">
                            <label for="correo" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="correo" id="correo" placeholder="user@place.com">
                            </div>
                        </div>
                        
                        <div class="form-group" style="margin-left: 30%; margin-right: 30%;">
                            <label for="pass" class="col-sm-2 control-label">Password</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" name="password" id="pass">
                            </div>
                        </div>            
                        <button class="btn btn-danger" type="submit"> Entrar </button>
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
        </script>
    </body>
</html>