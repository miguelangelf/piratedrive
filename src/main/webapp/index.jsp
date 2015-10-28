<%-- 
    Document   : index
    Created on : 22/10/2015, 05:30:02 PM
    Author     : miguel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/estilos.css" media="screen" />
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <title>Index</title>
        
    </head>
    <body background="slide-3.jpg">
        <div class="carousel">
            <h1><font color="red"> ¡Bienvenido a AshoDrive!</font></h1>
           <form method="POST">
               <label for="user"> Usuario: </label> <input type="text" name="usuario"/>
               <label for="pass"> Contraseña: </label> <input type="password" name="contraseña"/>
               <button class="btn btn-danger" type="submit"> Entrar </button>
           </form>
        </div>
    </body>
</html>
