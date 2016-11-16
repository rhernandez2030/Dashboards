<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal-header">
	<h3 class="modal-title">Detalle de Gasto del Municipio </h3>
</div>
<div class="modal-body" id="modal-body">
	<div style="width: 800px; height: 200px;">
	<h4>{{infoCtrl.data.nombre}}</h4>
	Gasto: {{infoCtrl.data.gasto | currency: 'Q'}}
	</div>
</div>
<div class="modal-footer">
	<button class="btn btn-primary" type="button" ng-click="infoCtrl.ok()">OK</button>
</div>