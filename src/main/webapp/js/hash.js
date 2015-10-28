/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var currentid;
var shared = false;

function share(id)
{
    $('#myModal').modal('show');
    $("#msgok").hide();
    $("#msgerror").hide();
    currentid = id;
    generatehash();
    isshareable();
    friendssharing();
}

function generatehash()
{
    $.post("GetHash", {fileid: currentid}, function (data, status) {
        var obj = JSON.parse(data);
        $("#lallave").html("http://localhost:8080/WebDrive/download?code=" + obj.hash);
    });




}

function makeshareablelink()
{

    $.post("ShareableLink", {share: "true", fileid: currentid}, function (data, status) {

        //alert(data);
        share(currentid);

    });



}





function isshareable()
{
    $.post("ShareableLink", {share: "check", fileid: currentid}, function (data, status) {

        //alert(data);
        var obj = JSON.parse(data);
        var strresponse = obj.result;
        // alert(strresponse);
        if (strresponse == true)
        {
            $("#beshared").html("Dejar de compartir");
            $("#candadito").hide();
            shared = true;

        }
        if (strresponse == false)
        {
            shared = true;
            $("#candadito").show();
            $("#beshared").html("Compartir");


        }
        //$("#compartidocon").html(strresponse.replace(/&&/g, "</br>"));
    });



}

function friendssharing()
{
    $.post("FriendsSharing", {fileid: currentid}, function (data, status) {

        var obj = JSON.parse(data);
        var strresponse = obj.friends;
        $("#compartidocon").html(strresponse.replace(/&&/g, "</br>"));
    });


}

function sharewith()
{
    var sharewh = $("#sharewith").val();
    $("#msgok").hide();
    $("#msgerror").hide();
    $.post("ShareWith", {correo: sharewh, fileid: currentid}, function (data, status) {

        var obj = JSON.parse(data);
        var resp = obj.success;
        //alert(resp);
        if (resp == true)
        {
            //  alert("chido");
            $("#msgok").show();
        }
        else
        {
            $("#msgerror").show();
        }
        friendssharing();
    });



}