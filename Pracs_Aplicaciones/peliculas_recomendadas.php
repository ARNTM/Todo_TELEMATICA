<?php
	include("funciones/funciones_generales_php.php");
	include("funciones/funciones_peliculas_php.php");
	include("funciones/funciones_generales_sql.php");
	include("funciones/funciones_peliculas_sql.php");
	include("funciones/funciones_detalles_sql.php");
?>
<link rel="stylesheet" href="vendor/bootstrap-datepicker/css/bootstrap-datepicker3.css" />
<link rel="stylesheet" href="vendor/datatables/media/css/dataTables.bootstrap4.css" />

<div id="custom-content" class="modal-block modal-block-xlg">
	<section class="card">
		<header class="card-header">
			<h2 class="card-title">Películas recomendadas</h2>
		</header>
		<div class="card-body">
			<div class="row">
			<?php echo getTablaPeliculasRecomendadas(); ?>
			</div>
		</div>
		<footer class="card-footer">
			<div class="row">
				<div class="col-md-12 text-right">
					<button class="btn btn-default modal-dismiss">Cerrar</button>
				</div>
			</div>
		</footer>
	</section>
</div>

<script src="vendor/datatables/media/js/jquery.dataTables.min.js"></script>
<script src="vendor/datatables/media/js/dataTables.bootstrap4.min.js"></script>
<script>
(function($) {

	'use strict';

	var datatableInit = function() {
		$('#datatablerec').css('width', '100%');
		$('#datatablerec').dataTable({
			dom: '<"row"<"col-lg-6"l><"col-lg-5"f><"col-lg-1">><"table-responsive"t>p',
			order:  [[ 2, "desc" ]]
		});

	};

	$(function() {
		datatableInit();
	});

}).apply(this, [jQuery]);
</script>