<%-- 
    Document   : tester
    Created on : 20/10/2015, 11:46:07 PM
    Author     : miguel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tester</title>
    </head>
    <body>
        <h1>¡Tester!</h1>

        <form action="SaveFileController" method="post" enctype="multipart/form-data">
            Select image to upload:
            <input type="file" name="file" id="fileToUpload">
            <input type="submit" value="Upload Image" name="submit">
        </form>
    </body>
</html>
