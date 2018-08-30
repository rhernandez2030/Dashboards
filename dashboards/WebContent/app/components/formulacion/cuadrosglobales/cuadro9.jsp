<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.table {
		border-style: double; 
		width: 100%; 
		margin: 20px auto;
		border-collapse: collapse;
		border-spacing: 0;
	}
	
	.table>tbody>tr>td{
		padding: 8px;
	    line-height: 1;
	    vertical-align: top;
	    border-top: none;
	}
	
	.table>thead>tr>th{
		border-bottom: double gray;
		vertical-align: middle;
	}
	
	.nota {
	
	}
	
	.div_principal{
		width: 90%;
		font-family: "Times New Roman";
		font-size: 10px;
		margin: 0 auto;
		position: relative;
	}
	
	.div_titulo{
		text-align: center;
		margin-top: 20px;
	}
	
	.tab1{
		margin-left: 10px;
	}
	
	.tab2{
		margin-left: 20px;
	}
	
	.tab3{
		margin-left: 30px;
	}
	
	.tab4{
		margin-left: 40px;
	}
	
	.tab5{
		margin-left: 50px;
	}
	
	.tab6{
		margin-left: 60px;
	}
	
	.negrillas{
		font-weight:bold;
	}
	
	.grid_loading_cuadros{
		position: absolute;
	    top:0;
	    left: 0;
	    right: 0;
	    bottom: 0;
	}
	
	.grid_loading_cuadros .msg {
	  opacity: 1;
	  background-color: rgba(238,238,238,0.85);
	  text-align: center;
	  width: 100%;
	  height: 100%;
	  display: table;
	}
	
	.grid_loading_cuadros .msg span {
	  display: table-cell;
	  vertical-align: middle;
	}
	
	.table>tbody>tr:hover{
		background-color: #ececec;
	}	
</style>
<div ng-controller="cuadro9Controller as ctrl" class="maincontainer" id="title" class="all_page">
<h4>Cuadros Globales</h4>
<div class="row" style="margin-bottom: 10px;">
</div>
<div class="row">
	
	    	<div class="div_principal">
	    		<div class="grid_loading_cuadros" ng-hide="!ctrl.showloading">
				  	<div class="msg">
				      <span><i class="fa fa-spinner fa-spin fa-4x"></i>
						  <br /><br />
						  <b>Cargando, por favor espere...</b>
					  </span>
					</div>
				</div>
	    		<div class="div_titulo">
			    	<div style="font-size: 16px; font-weight: bold;">Cuadro 9</div>
			    	<div style="font-size: 12px; font-weight: bold;">Administración Central</div>
			    	<div style="font-size: 12px; font-weight: bold;">Presupuesto Recomendado {{ ctrl.anio }}</div>
			    	<div style="font-size: 12px; font-weight: bold;">Finalidad y Económico de Gasto</div>
			    	<div style="font-size: 12px; font-weight: bold;">(Montos en Millones de Quetzales)</div>
		    	</div>
		    	<table st-table="ctrl.finalidades_economico" class="table">
					<thead>
					<tr>
						<th style="text-align: center">Institución</th>
						<th style="text-align: center; width: 150px;border-right: 1px solid gray; border-left: 1px solid gray;">Total</th>
						<th style="text-align: center; width: 150px;border-right: 1px solid gray; border-left: 1px solid gray;" 
						ng-repeat="row_e in ctrl.economicos">{{ row_e }}</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td style="font-weight: bold; text-align: center;">Total</td>
						<td style="font-weight: bold; text-align: right; border-right: 1px solid gray; border-left: 1px solid gray;"
						ng-repeat="row in ctrl.total_finalidad_economico track by $index">{{ ctrl.filtroMillones(row, ctrl.viewMillones) }}</td>
					</tr>
					<tr ng-repeat="row in ctrl.finalidades_economico">
						<td style="white-space: nowrap;">{{ row.finalidad_nombre }}</td>
						<td style="text-align: right; border-right: 1px solid gray; border-left: 1px solid gray;">{{ ctrl.filtroMillones(row.recomendado_total, ctrl.viewMillones) }}</td>
						<td style="text-align: right; border-right: 1px solid gray; border-left: 1px solid gray;"
						ng-repeat="n in [].constructor(9) track by $index">{{ ctrl.filtroMillones(row['e'+($index+1)+'_monto'], ctrl.viewMillones) }}</td>
					</tr>
					</tbody>
				</table>
				<div class="nota"><span style="font-weight: bold;">Nota:</span> Pueden existir diferencias por redondeo.</div>
			</div>
	    
</div>
<br/>
<br/>
<br/>
</div>