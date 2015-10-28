/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var currentid;

function share(id)
{
    $('#myModal').modal('show');

    currentid = id;
    generatehash();
}

function generatehash()
{
    $.post("GetHash", {fileid: currentid}, function (data, status) {
        var obj = JSON.parse(data);
        $("#lallave").html("http://localhost:8080/WebDrive/getfshare?id" + obj.hash);
    });
    
    friendssharing();
    
    
}

function friendssharing()
{
    $.post("FriendsSharing", {fileid:currentid}, function (data, status) {
        var obj = JSON.parse(data);
        var strresponse=obj.friends;
        $("#compartidocon").html(strresponse.replace(/&&/g,"</br>"));
    });
    
    
}

function sharewith()
{
    var sharewh=$("#sharewith").val();
    
    $.post("ShareWith", {correo: sharewh,fileid:currentid}, function (data, status) {
        friendssharing();
    });
    
   
   
}