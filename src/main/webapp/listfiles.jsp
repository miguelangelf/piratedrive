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
        <!--<script src="js/jquery-1.11.3.min.js"></script>-->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/sidebar.css" type="text/css" rel="stylesheet" />

        <link href="css/listfiles.css" type="text/css" rel="stylesheet" />
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

            .container{
                border-bottom: 1px solid #c0c5c9;
                border-radius: 1px;
            }

            #sidemenu{
                position: absolute;
                padding: 0;
                background-color: #EFEFEF;
                height: 90.7%;
            }

            .btn.btn-default.side{
                padding-bottom: 13px;
                padding-top: 13px;
                background-color: inherit;
                width: 100%;
                border: transparent;
                outline: none;
            }

            .twins{
                float: right;
                padding: 0;
                overflow-y: auto;
                height: 100%;
            }

        </style>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="drophere" style="width: 100%; height: 100%;">
            <div class="container" style="width:100%;">
                <h1>Pirate Drive</h1>
            </div>

            <div class="row" style="width:100%; height: 90.7%; margin: 0;">
                <div id="sidemenu" class="col-lg-2 col-md-2 col-xs-3">
                    <div style="background-color: transparent; height: 20px;"></div>
                    <button id="click-upload" type="button" class="btn btn-info" style="width: 80%; margin-left: 10%; margin-right: 10%;">Upload</button>
                    <div style="background-color: transparent; height: 20px;"></div>
                    <button type="button" onclick="mios();" class="btn btn-default side">Unidad</button>
                    <button type="button" onclick="tuyos();" class="btn btn-default side">Compartido</button>
                    <div style="background-color: transparent; height: 20px;"></div>
                    <button href="DestroySession" type="button" class="btn btn-danger" style="width: 80%; margin-left: 10%; margin-right: 10%;">Log Off</button>
                </div>
                <div class="twins col-lg-10 col-md-10 col-xs-9">
                    <div id="lista"></div>
                    <div style="position: fixed; bottom: 0; right:0; width: inherit; height: inherit; background-color: transparent"></div>
                </div>
            </div>

        </div>

        <div id="uploads">
            <div class="row title">
                <div class="col-xs-1"><button id="collapse" class="invisible">_</button></div>
                <div class="col-xs-10"><label>Archivos</label></div>
                <div class="col-xs-1"><button id="close" class="invisible">X</button></div>
            </div>
            <div id="previews">
            </div>
        </div>

        <div>
            <div id="template">
                <div class="row" style="width: 100%; margin: 0; border-bottom: 1px solid gainsboro">
                    <div class="custom col-md-4 col-xs-4" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                        <p class="name" data-dz-name></p>
                    </div>
                    <div class="custom col-md-2 col-xs-2"><p class="size" data-dz-size></p></div>
                    <div class="custom col-md-2 col-xs-2">
                        <div class="progress progress-striped active" style="margin: 0;" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                            <div class="progress-bar progress-bar-success" data-dz-uploadprogress></div>
                            <!--<strong class="error text-danger" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"  data-dz-errormessage></strong>-->
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


        <script src="js/bootstrap.min.js"></script>
        <script src="js/dropzone.js"></script>

        <script src="js/jquery.touchSwipe.min.js"></script>
        <script src="js/sidebar.js"></script>
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
                                clickable: "#click-upload",
                                init: function () {
                                    this.on("addedfile", function (file) {
                                        $("#uploads").show();
                                    });

                                    this.on("queuecomplete", function (progress) {
                                        getFiles();
                                    });

                                    this.on("complete", function (file) {
                                        file.previewElement.querySelector('[data-dz-remove]').parentNode.innerHTML = "";
                                        var bar = file.previewElement.querySelector('.progress-striped');
                                        bar.style.opacity = '0'
                                        bar.parentNode.innerHTML = '<div>Complete</div>';
                                        
                                    });
                                    
                                    this.on("error", function (file,errorMessage) {
                                        var bar = file.previewElement.querySelector('.progress-striped');
                                        bar.style.opacity = '0'
                                        bar.parentNode.innerHTML = '<div>Error</div>';
                                        alert(errorMessage);
                                    });
                                    
                                    this.on("canceled", function (progress) {
                                        var bar = file.previewElement.querySelector('.progress-striped');
                                        bar.style.opacity = '0'
                                        bar.parentNode.innerHTML = '<div>Canceled</div>';
                                    });
                                    
                                }

                            });
                        }

                        $('#collapse').on('click', function () {
                            if ($('#previews').is(":visible")) {
                                $('#previews').hide();
                            } else
                                $('#previews').show();
                        });

                        $('#close').on('click', function () {
                            $('#uploads').hide();
                            $('#previews').html('');
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