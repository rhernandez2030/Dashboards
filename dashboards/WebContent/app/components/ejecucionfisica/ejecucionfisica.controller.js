/**
 * 
 */

angular.module('ejecucionfisicaController',['dashboards']).controller('ejecucionfisicaController',['$scope','$routeParams','$http','$interval', 
       'uiGridTreeViewConstants','uiGridConstants','i18nService','$timeout','uiGridGroupingConstants',
	   function($scope,$routeParams,$http, $interval, uiGridTreeViewConstants, uiGridConstants, i18nService, $timeout, uiGridGroupingConstants){
			i18nService.setCurrentLang('es');
			var current_year = moment().year();
			
			this.showloading = false;
			
			this.chartType = "bar";
			this.chartTitle = "Administración Central"
			
			this.selectedRow = null;
			this.row_selected = [];
			this.loadAttempted = false;
			
			this.month= moment().month()+1;
			this.entidad = 0; 
			
			this.entidad_nombre = "";
			
			this.lastupdate = "";
			
			var ano_actual = moment().year();
			this.chartLabels = [];
			this.chartSeries = ['Ejecución Presupuestaria', 'Ejecución Física'];
			this.chartData = [];
			this.chartData_start = [];
			
			this.total_ejecucion_fisica = 0;
			this.total_ejecucion_financiera = 0;
			this.indicador_total_ejecucion = 0;
			
			this.ejecucion_financiera=0.0, this.ejecucion_fisica=0.0;
			
			this.chart_colours = ['#5B9BD5', '#A9D18E', '#F7464A', '#46BFBD', '#FDB45C', '#949FB1', '#4D5360'];
			
			
	    	$http.post('/SLastupdate', { dashboard: 'ejecucionpresupuestaria', t: (new Date()).getTime() }).then(function(response){
				    if(response.data.success){
				    	this.lastupdate = response.data.lastupdate;
					}
				}.bind(this)
	    	);
			
			
			this.goLevel=function(level, mantain_select){
			
				this.showloading=true;
				this.loadAttempted=false;
				var data = { action: 'entidadesData', t: (new Date()).getTime() };
				this.chartData=[];
	    		this.chartTitle = '';
	    		$http.post('/SEjecucionFisica', data).then(function(response){
					    if(response.data.success){
					    	if(!mantain_select)
					    		this.row_selected=[];
					    	var ejecucion_financiera=0.0, ejecucion_fisica=0.0;
					    	var serie_presupuestaria=[];
					    	var serie_fisica=[];
					    	for(var i=0; i<response.data.entidades.length; i++){
					    		this.ejecucion_financiera += response.data.entidades[i].porcentaje_ejecucion_financiera;
					    		this.ejecucion_fisica += response.data.entidades[i].porcentaje_ejecucion_fisica;
					    	}
					    	response.data.entidades.sort(this.compareEntidades);
					    	
					    	for(var i=0; i<response.data.entidades.length; i++){
					    		this.chartLabels.push(response.data.entidades[i].nombre)
					    		serie_presupuestaria.push(Math.round(response.data.entidades[i].porcentaje_ejecucion_financiera*100)/100);
					    		serie_fisica.push(Math.round(response.data.entidades[i].porcentaje_ejecucion_fisica*100)/100);
					    	}
					    	
					    	this.chartData.push(serie_presupuestaria);
					    	this.chartData.push(serie_fisica);
					    	this.entidades_gridOptions.data = response.data.entidades;
					    	
					    	this.total_ejecucion_financiera = (this.ejecucion_financiera / response.data.entidades.length);
					    	this.total_ejecucion_fisica = (this.ejecucion_fisica / response.data.entidades.length);
					    	this.indicador_total_ejecucion = ((this.total_ejecucion_fisica)/(8.33*this.month))*100;
					    	
					    	if(this.indicador_total_ejecucion<50)
					    		this.indicador_total_ejecucion = 4;
							else if(this.indicador_total_ejecucion<75)
								this.indicador_total_ejecucion = 2;
							else if(this.indicador_total_ejecucion<100)
								this.indicador_total_ejecucion = 3;
							else
								this.indicador_total_ejecucion = 1;
					    	if(mantain_select){
						    	$scope.gridApi.grid.modifyRows(this.entidades_gridOptions.data);
						    	$scope.gridApi.selection.selectRow(this.entidades_gridOptions.data[this.selectedRow]);
						    }
					    	
					    }
					    this.showloading=false;
					    this.loadAttempted=true;
				 	}.bind(this), function errorCallback(response){
				 		
				 	}
				);
			}
			
			this.entidades_gridOptions = {
				    enableSorting: true,
				    enableFiltering: true,
				    enableRowSelection: true,
				    selectionRowHeaderWidth: 35,
				    noUnselect: false,
				    showColumnFooter: true,
				    enableRowHeaderSelection: false,
				    showGridFooter:true,
				    columnDefs: [
				      { name: 'entidad', displayName: 'Código', cellClass: 'grid-align-right', type: 'number' },
				      { name: 'nombre', minWidth: 500, width: 500, displayName: 'Nombre' },
				      { name: 'porcentaje_ejecucion_financiera', maxWidth: 200, width: 200, cellFilter: 'number: 2', displayName: 'Ejecución Presupuestaria', enableFiltering: false,
						  cellClass: 'grid-align-right',  footerCellTemplate: '<div class="ui-grid-cell-contents">{{ grid.appScope.ejecucion.total_ejecucion_financiera | number:2 }}&nbsp%</div>',
						  footerCellClass: 'grid-align-right', aggregationHideLabel: true, type: 'number'},
				      { name: 'porcentaje_ejecucion_fisica', maxWidth: 200, width: 200, cellFilter: 'number: 2', displayName: 'Ejecución Física', enableFiltering: false,
						  cellClass: 'grid-align-right',  footerCellTemplate: '<div class="ui-grid-cell-contents">{{ grid.appScope.ejecucion.total_ejecucion_fisica | number:2 }}&nbsp%</div>',
						  footerCellClass: 'grid-align-right', aggregationHideLabel: true, type: 'number'},
						  { name: 'icono_ejecucion_anual', minWidth: 250, width: 250, displayName: 'Sémaforo de Ejecución Física', enableFiltering: false, enableSorting: false,
							    cellClass: 'grid-align-center', type: 'number', cellTemplate: '<div class="glyphicon glyphicon-certificate dot_{{ row.entity.icono_ejecucion_anual }}"></div>',
							    footerCellClass: 'grid-align-center',
							    footerCellTemplate: '<div class="ui-grid-cell-contents"><span class="glyphicon glyphicon-certificate dot_{{ grid.appScope.ejecucion.indicador_total_ejecucion }}"></span></div>'
							  }
						  
					  
				    ],
				    onRegisterApi: function( gridApi ) {
				      $scope.gridApi = gridApi;
				      if($routeParams.reset_grid=='gt1'){
				    	  this.saveState();
				      }
				      else{
				    	  var grid_data = { action: 'getstate', grid:'ejecucionfisica_1', t: (new Date()).getTime()};
				    	  $http.post('/SSaveGridState', grid_data).then(function(response){
					    	  if(response.data.success && response.data.state!='')
					    		  $scope.gridApi.saveState.restore( $scope, response.data.state);
					    	    
					    	  //$scope.gridApi.colResizable.on.columnSizeChanged($scope, this.saveState);
						      $scope.gridApi.core.on.columnVisibilityChanged($scope, this.saveState);
						      //$scope.gridApi.core.on.filterChanged($scope, this.saveState);
						      $scope.gridApi.core.on.sortChanged($scope, this.saveState);
						  }.bind(this));
				      }
				    }.bind(this)
				  };
			
			this.saveState=function() {
				var state = $scope.gridApi.saveState.save();
				var grid_data = { action: 'savestate', grid:'ejecucionfisica_1', state: JSON.stringify(state), t: (new Date()).getTime() }; 
				$http.post('/SSaveGridState', grid_data).then(function(response){
					
				});
			}
			
			this.chartOptions= {
					bezierCurve : false,
					datasetStrokeWidth : 6,
					pointDotRadius : 6,
					scaleLabel: function(label){ return  label.value+' %'; },
					//tooltipTemplate: "<%if (label){%><%=label %>: <%}%><%= numeral(value).format('$ 0,0.00') %>",
					//multiTooltipTemplate: "<%= numeral(value).format('$ 0,0.00') %>",
					legendTemplate: "<div class=\"chart-legend\"><ul class=\"line-legend\"><% for (var i=0; i<datasets.length; i++){%><li><div class=\"img-rounded\" style=\"float: left; margin-right: 5px; width: 15px; height: 15px; background-color:<%=datasets[i].strokeColor%>\"></div><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>",
					tooltips:{
						enabled:false
					},
					scales: {
		                yAxes: [{
		                    ticks: {
		                        min: 0,
		                        max: 100,
		                        beginAtZero: true,
		                        callback: function(label, index, labels) {
		                            return label+' %';
		                         }
		                    }
		                }],
		                xAxes: [{
		                    ticks: {
		                        autoSkip: false,
		                        maxRotation: 90,
		                        minRotation: 90
		                    }
		                }]
		            },
		            animation: {
		                onComplete: function() {
		                	if(this.config.type=='bar' || this.config.type=='line'){
			                	var ctx = this.chart.ctx;
			                	  ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
			                	  ctx.fillStyle = this.chart.config.options.defaultFontColor;
			                	  ctx.textAlign = 'center';
			                	  ctx.textBaseline = 'bottom';
			                	  this.data.datasets.forEach(function (dataset) {
			                	    for (var i = 0; i < dataset.data.length; i++) {
			                	      if(dataset.hidden === true && dataset._meta[Object.keys(dataset._meta)[0]].hidden !== false){ continue; }
			                	      var model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
			                	      if(dataset.data[i] !== null){
			                	    	  //var nctx = document.createElement('canvas').getContext('2d');
			                	    	  //ctx.translate(ctx.width/2,ctx.height/2)
			                	    	  //ctx.rotate(10*Math.PI/180);
			                	    	  ctx.fillText(dataset.data[i]+' %', model.x - 1, model.y + 20);
			                	    	  //ctx.restore();
			                	      }
			                	    }
			                	  });
		                	}
		               }
		            },
		            hover: { animationDuration: 0 }
			}
			
			this.goLevel(1, false);
			
			this.compareEntidades=function(a,b){
				if(a.porcentaje_ejecucion_financiera < b.porcentaje_ejecucion_financiera)
					return 1;
				if(a.porcentaje_ejecucion_financiera > b.porcentaje_ejecucion_financiera)
					return -1;
				return 0;
			}
		}
	]);