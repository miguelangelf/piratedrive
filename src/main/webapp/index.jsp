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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-2.1.4.js"></script>
        <link rel="stylesheet" type="text/css" href="css/estilos.css" media="screen" />
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <title>Index</title>

    </head>
    <body >
        <div class="container">

            <h1><font color="red"> ¡Bienvenido a AshoDrive!</font></h1>

            <%
                if (request.getAttribute("resultado") == "error") {
            %>

            <div id="msgok" class="alert alert-danger" role="alert">Usuario o Contraseña incorrecta</div>
            <%
                }
            %>
            <form method="POST" action="Login">
                <label for="user"> Usuario: </label> <input type="text" name="correo"/>
                <label for="pass"> Contraseña: </label> <input type="password" name="password"/>               
                <button class="btn btn-danger" type="submit"> Entrar </button>
            </form>
        </div>
    </body>
</html>
