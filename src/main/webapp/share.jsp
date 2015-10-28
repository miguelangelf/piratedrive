<div id="myModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Compartir</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Llave</label>
                        <div class="col-sm-10">
                            <p id="lallave" class="form-control-static"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Agregar Usuario</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="sharewith" placeholder="Agrega Usuario">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Compartido con</label>
                        <div class="col-sm-10">
                            <div id="compartidocon"></div>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-default">Compartir</button>
                <button type="button" onclick="sharewith();" class="btn btn-primary">Añadir Persona</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->