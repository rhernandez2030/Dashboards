<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div ng-controller="ejecucionpresupuestariaController as ejecucion" class="maincontainer" id="title" class="all_page">
<h4>Ejecución Presupuestaria</h4>
<div class="row">
	<div class="col-sm-12">
		<button type="button" class="btn btn-default no-border" style="font-size: 18px;" ng-click="ejecucion.panel_fuentes = !ejecucion.panel_fuentes" ng-disabled="ejecucion.showloading">{{ ejecucion.fuentes}} [ {{ ejecucion.fuentes_descripcion }} ]</button>
		<div uib-collapse="!ejecucion.panel_fuentes" style="margin: 10px 0px 0px 12px;" class="panel panel-default">
			<div style="text-align: right; margin: 5px;">
			<button type="button" class="btn btn-default" ng-click="ejecucion.checkAll(true)"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>Todas</button> 
			<button type="button" class="btn btn-default" ng-click="ejecucion.checkAll(false)"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>Ninguna</button>
			<button type="button" class="btn btn-default" ng-click="ejecucion.checkTributarias()"><span class="glyphicon glyphicon-tag" aria-hidden="true"></span>Tributarias</button>
			<button type="button" class="btn btn-default" ng-click="ejecucion.goLevel(ejecucion.level, true)"><span class="glyphicon glyphicon-play" aria-hidden="true"></span>Generar</button>
			</div>
			<div class="checkbox" style="margin-left: 12px;" ng-repeat="f in ejecucion.fuentes_array">
		     <label>
		          <input type="checkbox" ng-model="f.checked" ng-change="ejecucion.changeFuentes()">
		          {{ f.fuente }} {{ f.nombre }}
		        </label>
	        </div>
	    </div>
	 </div>
	 <div class="col-sm-12">
	    <button type="button" class="btn btn-default no-border" style="font-size: 18px;" ng-click="ejecucion.panel_grupos = !ejecucion.panel_grupos" ng-disabled="ejecucion.showloading">{{ ejecucion.grupos}} [ {{ ejecucion.grupos_descripcion }} ]</button>
	    <div uib-collapse="!ejecucion.panel_grupos" style="margin: 10px 0px 0px 12px;" class="panel panel-default">
			<div style="text-align: right; margin: 5px;">
			<button type="button" class="btn btn-default" ng-click="ejecucion.checkGruposAll(true)"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>Todos</button> 
			<button type="button" class="btn btn-default" ng-click="ejecucion.checkGruposAll(false)"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>Ninguno</button>
			<button type="button" class="btn btn-default" ng-click="ejecucion.goLevel(ejecucion.level, true)"><span class="glyphicon glyphicon-play" aria-hidden="true"></span>Generar</button>
			</div>
			<div class="checkbox" style="margin-left: 12px;" ng-repeat="g in ejecucion.grupos_array">
		     <label>
		          <input type="checkbox" ng-model="g.checked" ng-change="ejecucion.changeGrupos()">
		          {{ g.grupo }} {{ g.nombre }}
		        </label>
	        </div>
	    </div>
	</div>
</div>
<br/>
<div class="row" style="margin-bottom: 10px;">
	<div class="col-sm-12">
		<div class="btn-group" uib-dropdown>
	      <button id="single-button" type="button" class="btn btn-default no-border" uib-dropdown-toggle ng-disabled="ejecucion.showloading" style="width: 150px; text-align: left; font-size: 24px;">
	        {{ ejecucion.nmonth }} <span class="caret"></span>
	      </button>
	      <ul uib-dropdown-menu role="menu" aria-labelledby="single-button">
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(1)">Enero</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(2)">Febrero</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(3)">Marzo</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(4)">Abril</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(5)">Mayo</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(6)">Junio</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(7)">Julio</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(8)">Agosto</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(9)">Septiembre</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(10)">Octubre</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(11)">Noviembre</a></li>
	        <li role="menuitem"><a href ng-click="ejecucion.mesClick(12)">Diciembre</a></li>
	      </ul>
	    </div>
	    <div class="btn-group" uib-dropdown>
	      <button id="single-button" type="button" class="btn btn-default no-border" uib-dropdown-toggle ng-disabled="ejecucion.showloading" style="width: 100px; text-align: left; font-size: 24px;">
	        {{ ejecucion.ano }} <span class="caret"></span>
	      </button>
	      <ul uib-dropdown-menu role="menu" aria-labelledby="single-button">
	        <li role="menuitem" ng-repeat="ano in ejecucion.anos_historia">
	        	<a href ng-click="ejecucion.anoClick(ano)">{{ ano }}</a></li>
	      </ul>
	    </div>
	    <span ng-show="ejecucion.showloading">&nbsp;<i class="fa fa-spinner fa-spin fa-lg"></i></span> 
    </div>
</div>
<div class="row" style="margin-bottom: 10px;">
	<div class="col-sm-12" style="text-align: center; font-size: 20px; font-weight: bold;">{{ ejecucion.titulo }}</div>
</div>
<div class="row">
	<div ui-i18n="es" class="col-sm-12">
		<div class="row" style="margin-bottom: 10px;">
			<div class="col-sm-10" style="float: left;">
				<a href class="btn btn-default no-border" ng-click="ejecucion.goLevel(1, false)" ng-disabled="ejecucion.showloading">ADMINISTRACIÓN CENTRAL</a>
				<span ng-hide="ejecucion.entidad==null"> / <a href class="btn btn-default no-border" ng-click="ejecucion.goLevel(2, false)" ng-disabled="ejecucion.showloading">[ {{ejecucion.entidad}} ] {{ ejecucion.entidad_nombre }}</a></span>
				<span ng-hide="ejecucion.unidad_ejecutora==null"> / <a href class="btn btn-default no-border" ng-click="ejecucion.goLevel(3, false)" ng-disabled="ejecucion.showloading">[ {{ejecucion.unidad_ejecutora}} ] {{ ejecucion.unidad_ejecutora_nombre }}</a></span>
				<span ng-hide="ejecucion.programa==null"> / <a href class="btn btn-default no-border" ng-click="ejecucion.goLevel(4, false)" ng-disabled="ejecucion.showloading">[ {{ejecucion.programa}} ] {{ ejecucion.programa_nombre }}</a></span>
				<span ng-hide="ejecucion.subprograma==null"> / <a href class="btn btn-default no-border" ng-click="ejecucion.goLevel(5, false)" ng-disabled="ejecucion.showloading">[ {{ejecucion.subprograma}} ] {{ ejecucion.subprograma_nombre }}</a></span>
				<span ng-hide="ejecucion.proyecto==null"> / <a href class="btn btn-default no-border" ng-click="ejecucion.goLevel(6, false)" ng-disabled="ejecucion.showloading">[ {{ejecucion.proyecto}} ] {{ ejecucion.proyecto_nombre }}</a></span>
				<span ng-hide="ejecucion.actividad==null && ejecucion.obra==null"> / <a href class="btn btn-default no-border" ng-click="ejecucion.goLevel(7, false)" ng-disabled="ejecucion.showloading">[ {{ ejecucion.actividad }} , {{ ejecucion.obra }} ] {{ ejecucion.actividad_obra_nombre }}</a></span>
			</div>
			<div class="col-sm-2 text-right"><div class="btn-group" role="group" aria-label="">
													<a class="btn btn-default" href ng-click="ejecucion.resetView()" role="button" uib-tooltip="Reiniciar la vista de la tabla" tooltip-placement="left"><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span></a>
													<a class="btn btn-default" href ng-click="ejecucion.exportXLS()" role="button" uib-tooltip="Exportar a formato Excel" tooltip-placement="left"><span class="glyphicon glyphicon-save" aria-hidden="true"></span></a>
												</div>
			</div>
		</div>
		<div class="row">
			<div ui-grid="ejecucion.entidades_gridOptions" ui-grid-save-state ui-grid-move-columns ui-grid-resize-columns ui-grid-selection ui-grid-pinning ui-grid-tree-view class="grid" style="height: 710px;">
				  <div class="grid_loading" ng-hide="!ejecucion.showloading">
				  	<div class="msg">
				      <span><i class="fa fa-spinner fa-spin fa-4x"></i>
						  <br /><br />
						  <b>Cargando, por favor espere...</b>
					  </span>
					</div>
				  </div>
			</div>
			<br/>
			<div style="text-align: center;"><p>Ejecución:  <span uib-tooltip="Menor al 50% del valor esperado" class="glyphicon glyphicon-certificate dot_4 "></span> Baja  |  <span uib-tooltip="Entre el 50% y el 75% del valor esperado" class="glyphicon glyphicon-certificate dot_2 "></span> Media  |  <span uib-tooltip="Entre el 75% y el 100% del valor esperado" class="glyphicon glyphicon-certificate dot_3"></span> Optima  |  <span uib-tooltip="Más del 100% del valor esperado" class="glyphicon glyphicon-certificate dot_1"></span> Sobre Ejecución</p></div>
			<div class="text-center">Ejecución Esperada: {{ (100/12)*ejecucion.month | currency:"":2 }} %</div>
			<br/>
			<br/>
			<div class="row">
				<div class="col-sm-12">
					<div style="text-align: right;" ng-hide="ejecucion.level!=7">* Renglones con vigente o gasto mayor a 0</div>
					<div style="text-align: right;" ng-hide="ejecucion.level<3">** Cuota Aprobada solo existe a nivel de Unidades Ejecutoras</div>	
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12" style="text-align: center">Última actualización: {{ ejecucion.lastupdate }}</div>
			</div>
	</div>
</div>
<div class="row" style="width: 90%; margin: auto">
		<div class="col-sm-6" style="margin-top: 20px; padding-right: 20px;">
			<h4 align="center">{{ ejecucion.chartTitle }}</h4>
			<h5 align="center">Gasto en millones de quetzales</h5>
			<div class="row">
				<div class="col-sm-12" style="text-align: right;">
					<div class="btn-group" role="group" aria-label="">
						<a class="btn btn-default btn-sm" href ng-click="ejecucion.chartType='line'" ng-disabled="ejecucion.showloading" role="button" uib-tooltip="Lineas"><i class="fa fa-line-chart"></i></a>
						<a class="btn btn-default btn-sm" href ng-click="ejecucion.chartType='bar'" ng-disabled="ejecucion.showloading" role="button" uib-tooltip="Barras"><i class="fa fa-bar-chart"></i></a>
						<a class="btn btn-default btn-sm" href ng-click="ejecucion.chartType='radar'" ng-disabled="ejecucion.showloading" role="button" uib-tooltip="Radio"><i class="fa fa-bullseye"></i></a>
					</div>
				</div>
			</div>
			<br/>
				<canvas height="120px" class="chart-base" chart-type="ejecucion.chartType" chart-data="ejecucion.chartData"
					chart-labels="ejecucion.chartLabels" chart-series="ejecucion.chartSeries" chart-options="ejecucion.chartOptions">
				</canvas>
	    </div>
	    <div class="col-sm-6" style="margin-top: 20px; padding-left: 20px;">
	    	<h4 align="center">Histórico de la ejecución</h4>
	    	<h5 align="center">Gasto en millones de quetzales</h5>
	    	<div class="row">
				<div class="col-sm-12" style="text-align: right;">
					<div class="btn-group" role="group" aria-label="">
						<a class="btn btn-default btn-sm" href ng-click="ejecucion.chartHistoricoHastaMesActual(true)" ng-disabled="ejecucion.showloading" role="button" uib-tooltip="Todos los meses"><i class="glyphicon glyphicon-resize-full"></i></a>
						<a class="btn btn-default btn-sm" href ng-click="ejecucion.chartHistoricoHastaMesActual(false)" ng-disabled="ejecucion.showloading" role="button" uib-tooltip="Hasta mes actual"><i class="glyphicon glyphicon-resize-small"></i></a>
					</div>
				</div>
			</div>
			<br/>
	    	<canvas height="120px" class="chart chart-line"  chart-data="ejecucion.chartData_historico"
					chart-labels="ejecucion.chartLabels_historico" chart-series="ejecucion.chartSeries_historico" chart-options="ejecucion.chartOptions_historico">
				</canvas>
	    </div>
</div>
</div>
<br/>
<br/>
<br/>
</div>