<%-- 
    Document   : listfiles
    Created on : 27/10/2015, 01:37:40 PM
    Author     : miguel
--%>


<%

    if (session.getAttribute("userid") == null) {

        //response.sendRedirect(response.encodeRedirectURL("index.jsp"));
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="share.jsp" />

<!DOCTYPE html>
<html>
    <head>
        <script src="js/jquery-2.1.4.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <link href="css/bootstrap.min.css" rel="stylesheet">

        <script src="js/bootstrap.min.js"></script>



        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <div class="container">
            <h1>Pirate Drive</h1>
            <a href="DestroySession"><h4>Logout</h4></a>

            <button type="button" onclick="mios();" class="btn btn-link">Mis archivos</button>
            <button type="button" onclick="tuyos();" class="btn btn-link">Compartido Conmigo</button>
            <form action="SaveFileController" method="post" enctype="multipart/form-data">
                
                <input type="file" name="file" id="fileToUpload">
                <input type="submit" value="Upload Image" name="submit">
            </form>
            <hr/>
            <div id="lista"></div>
        </div>
    </body>
</html>

<script>

    $(document).ready(function () {
        getFiles();
    });


    function getFiles()
    {
        $.post("GetFilesController", {userid: 1}, function (data, status) {
            $("#lista").html(data);
        });

    }

    function mios()
    {
        $.post("GetFilesController", {userid: 1}, function (data, status) {
            $("#lista").html(data);
        });

    }

    function tuyos()
    {
        $.post("GetSharedWithMe", {userid: 1}, function (data, status) {
            $("#lista").html(data);
        });

    }





</script>