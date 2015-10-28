<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="table  table-striped table-bordered">


    <tr>
        <th width="35%" >Nombre</th>
        <th width="35%" >MIME</th>
        <th width="10%" >Tamaño</th>
        <th width="10%" >Descargar</th>
        <th width="10%" >Compartir</th>
    </tr>


    <c:forEach items="${files}" var="current">
        <tr height="2em" >
            <td width="35%" >${current.nombre}</td>  
            <td width="35%" >${current.mime}</td>  
            <td width="10%" >${current.tamano} bytes</td>  
            <td width="10%" ><a href="DownloadFile?fileid=${current.id}">Download</a></td>
            <td width="10%" ><button type="button" onclick="share(${current.id});" class="btn btn-link">Share</button></td>
        </tr>

    </c:forEach>


</table>

<script src="js/hash.js"></script>
