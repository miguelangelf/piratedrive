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
        <!--<script src="js/jquery-2.1.4.js"></script>-->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <style type="text/css">
            p{
                margin: 0;
            }

            .title{
                text-align: center; 
                width: 100%; 
                background-color: gray; 
                border-bottom: 1px solid black; 
                margin: 0;
            }

            .custom{
                padding: 0px;
                margin: 0px;
                vertical-align: middle;
                text-align: center;
                //border: 1px solid black;
            }

            #uploads{
                width: 500px;
                position: fixed;
                bottom: 0;
                right: 10px;
                margin: 0;
                border: 1px solid black;
            }

            #previews{
                width: auto;
                background-color: white;
            }

            .invisible{
                background: transparent;
                border: none !important;
                visibility: visible;
            }

        </style>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="drophere" style="width: 100%; height: 100%;">
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

            <div>
                <div id="template">
                    <div class="row" style="width: 100%; margin: 0; border-bottom: 1px solid gainsboro">
                        <div class="custom col-md-4 col-xs-4" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                            <p class="name" data-dz-name></p>
                            <!--<strong class="error text-danger" data-dz-errormessage></strong>-->
                        </div>
                        <div class="custom col-md-2 col-xs-2"><p class="size" data-dz-size></p></div>
                        <div class="custom col-md-2 col-xs-2">
                            <div class="progress progress-striped active" style="margin: 0;" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                <div class="progress-bar progress-bar-success" style="width:0%;" data-dz-uploadprogress></div>
                            </div>
                        </div>
                        <div class="col-md-2 col-xs-2"></div>
                        <div class="custom col-md-2 col-xs-2">
                            <button data-dz-remove class="btn btn-warning btn-xs cancel">
                                <i class="glyphicon glyphicon-ban-circle"></i>
                                <span>Cancel</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="uploads">
            <div class="row title">
                <div class="col-xs-1"><button class="invisible">_</button></div>
                <div class="col-xs-10"><label>Archivos</label></div>
            </div>
            <div id="previews">
            </div>
        </div>

        <!--<script src="js/jquery-2.1.4.js"></script>-->
        <script src="js/jquery-1.11.3.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/dropzone.js"></script>
    </body>
</html>

<script>
                    $(document).ready(function () {
                        getFiles();
                        DropzoneInit();
                    });

                    function DropzoneInit() {
                        var mydropzone = $("div#drophere");
                        mydropzone.clickable = false;
                        $('#uploads').hide();


                        var previewNode = document.getElementById("template");
                        previewNode.id = "";
                        var previewTemplate = previewNode.parentNode.innerHTML;
                        previewNode.parentNode.removeChild(previewNode);

                        mydropzone.dropzone({
                            url: "SaveFileController",
                            previewTemplate: previewTemplate,
                            previewsContainer: "#previews",
                            clickable: false,
                            init: function () {
                                this.on("addedfile", function (file) {
                                    $("#uploads").show();
                                });
                                this.on("queuecomplete", function (progress) {
                                    //alert("Complete");
                                    getFiles();
                                });
                            }

                        });
                    }

                    $('.invisible').on('click', function () {
                        if ($('#previews').is(":visible")) {
                            $('#previews').hide();
                        } else
                            $('#previews').show();
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