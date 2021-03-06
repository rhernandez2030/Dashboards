/**
 * 
 */
var app = angular.module('dashboards',['ngRoute','ui.bootstrap','chart.js', 'loadOnDemand','ngAnimate', 'ngTouch', 
                                       'ui.grid', 'ui.grid.treeView', 'ui.grid.selection','ui.grid.moveColumns', 
                                       'ui.grid.resizeColumns', 'ui.grid.saveState','ui.grid.pinning']);

app.config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
	   $locationProvider.hashPrefix('!');
	   //$locationProvider.html5Mode(true);
	   
	   $routeProvider
	   		.when('/paptn/ejecucionfinanciera',{
            	template: '<div load-on-demand="\'paptn_ejecucionfinancieraController\'" class="all_page"></div>'
            })
            .when('/transparencia/estados_de_calamidad',{
            	//template: '<div load-on-demand="\'estadoscalamidadController\'" class="all_page"></div>'
            	redirectTo: '/transparencia/calamidad/7'
            })
            .when('/transparencia/calamidad/:subprograma',{
            	template: '<div load-on-demand="\'calamidadController\'" class="all_page"></div>'
            })
            .when('/transparencia/calamidad/mapa/:subprograma',{
            	template: '<div load-on-demand="\'calamidadMapaController\'" class="all_page"></div>'
            })
            .when('/transparencia/calamidad/actividades/:subprograma',{
            	template: '<div load-on-demand="\'calamidadActividadesController\'" class="all_page"></div>'
            })
            .when('/transparencia/calamidad/ejecucion/:subprograma',{
            	template: '<div load-on-demand="\'calamidadEjecucionController\'" class="all_page"></div>'
            })
            .when('/transparencia/calamidad/documentos/:subprograma',{
            	template: '<div load-on-demand="\'calamidadDocumentosController\'" class="all_page"></div>'
            })
            .when('/transparencia/calamidad/cfuera/:subprograma',{
            	template: '<div load-on-demand="\'calamidadCFueraController\'" class="all_page"></div>'
            })
            .when('/transparencia/calamidad/compras/:subprograma',{
            	template: '<div load-on-demand="\'calamidadComprasController\'" class="all_page"></div>'
            })
            .when('/transparencia/calamidad/donaciones/:subprograma',{
            	template: '<div load-on-demand="\'calamidadDonacionesController\'" class="all_page"></div>'
            })
            .when('/prestamos',{
            	template: '<div load-on-demand="\'prestamosEjecucionPresupuestariaModule\'" class="all_page"></div>'
            })
            .when('/donaciones',{
            	template: '<div load-on-demand="\'donacionesEjecucionPresupuestariaModule\'" class="all_page"></div>'
            });
    }]);

app.config(['$loadOnDemandProvider', function ($loadOnDemandProvider) {
	   this.time = (new Date()).getTime();
	   var modules = [
	       {
	           name: 'paptn_ejecucionfinancieraController',     
	           script: '/app/components/paptn/ejecucionfinanciera/ejecucionfinanciera.controller.js?'+time,
	           template: '/app/components/paptn/ejecucionfinanciera/ejecucionfinanciera.jsp'
	       },
	       {
	    	   name: 'estadoscalamidadController',     
	           script: '/app/components/transparencia/estadoscalamidad.controller.js?'+time,
	           template: '/app/components/transparencia/estadoscalamidad.jsp'
	       },
	       {
	    	   name: 'calamidadController',     
	           script: '/app/components/transparencia/calamidad/calamidad.controller.js?'+time,
	           template: '/app/components/transparencia/calamidad/calamidad.jsp'
	       },
	       {
	    	   name: 'calamidadMapaController',     
	           script: '/app/components/transparencia/calamidad/calamidadMapa.controller.js?'+time,
	           template: '/app/components/transparencia/calamidad/calamidadMapa.jsp'
	       },
	       {
	    	   name: 'calamidadActividadesController',     
	           script: '/app/components/transparencia/calamidad/calamidadActividades.controller.js?'+time,
	           template: '/app/components/transparencia/calamidad/calamidadActividades.jsp'
	       },
	       {
	    	   name: 'calamidadEjecucionController',     
	           script: '/app/components/transparencia/calamidad/calamidadEjecucion.controller.js?'+time,
	           template: '/app/components/transparencia/calamidad/calamidadEjecucion.jsp'
	       },
	       {
	    	   name: 'calamidadAdminController',     
	           script: '/app/components/transparencia/calamidad/calamidadAdmin.controller.js?'+time,
	           template: '/app/components/transparencia/calamidad/calamidadAdmin.jsp'
	       },
	       {
	    	   name: 'calamidadDocumentosController',     
	           script: '/app/components/transparencia/calamidad/calamidadDocumentos.controller.js?'+time,
	           template: '/app/components/transparencia/calamidad/calamidadDocumentos.jsp'
	       },
	       {
	    	   name: 'calamidadCFueraController',     
	           script: '/app/components/transparencia/calamidad/calamidadCFuera.controller.js?'+time,
	           template: '/app/components/transparencia/calamidad/calamidadCFuera.jsp'
	       },
	       {
	    	   name: 'calamidadComprasController',     
	           script: '/app/components/transparencia/calamidad/calamidadCompras.controller.js?'+time,
	           template: '/app/components/transparencia/calamidad/calamidadCompras.jsp'
	       },
	       {
	    	   name: 'calamidadDonacionesController',     
	           script: '/app/components/transparencia/calamidad/donaciones.controller.js?'+time,
	           template: '/app/components/transparencia/calamidad/donaciones.jsp'
	       },
	       {
	    	   name: 'prestamosEjecucionPresupuestariaModule',     
	           script: '/app/components/creditopublico/prestamos/prestamos.controller.js',
	           template: '/app/components/creditopublico/prestamos/prestamos.jsp' 
	       },
	       {
	    	   name: 'donacionesEjecucionPresupuestariaModule',     
	           script: '/app/components/creditopublico/donaciones/donaciones.controller.js',
	           template: '/app/components/creditopublico/donaciones/donaciones.jsp'
	       }

	       
	   ];
	   $loadOnDemandProvider.config(modules);
}]);

app.controller('publicController',['$scope','$document','$rootScope','$location','$window',
   function($scope,$document,$rootScope,$location,$window){
	$scope.lastscroll = 0;
	$scope.hidebar = false;
	
	numeral.language('es', numeral_language);
	
	$rootScope.$on('$routeChangeSuccess', function (event, current, previous) {
		$window.ga('create', 'UA-74443600-1', 'auto');
    	$window.ga('send', 'pageview', $location.path());
    });
}]);

