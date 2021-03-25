<?php 

include('funciones/funciones_generales_php.php');
include('funciones/funciones_generales_sql.php');
include('funciones/funciones_detalles_php.php');
include('funciones/funciones_detalles_sql.php');
include('funciones/funciones_peliculas_sql.php');
include('funciones/api-tmdb.php');

$titulo = 'Detalles de la película';
$seccion = 'Peliculas';

if(isset($_GET['mensaje'])){
	$alerta = $_GET['mensaje'];
}

if(isset($_GET['id'])){
	$id=base64_decode($_GET['id']);
	$pelicula=getPelicula($id);
	if(isset($_SESSION['username'])){
		$idusuario=getUserId($_SESSION['username']);
		$puntuacion_usuario_pelicula = buscarPuntuacion($idusuario,$id);
	}else {$puntuacion_usuario_pelicula = "no";}
	
	if($pelicula==null){
		header("Location: listado_peliculas.php");
	}else{	
		$estadisticas=getEstadisticas();
		$key = array_search($id, array_column($estadisticas, 'ID_MOVIE'));
		$estadisticasfilm=$estadisticas[$key];	
	}
}else{
	header("Location: listado_peliculas.php");
}



?>

<!doctype html>
<html class="fixed"><head>

		<!-- Basic -->
		<meta charset="UTF-8">

		<title><?php echo $titulo." | FilmRank";?></title>
		<meta name="keywords" content="FilmRank" />
		<meta name="description" content="FilmRank">
		<meta name="author" content="Diego Ismael Antolinos García y Andrés Ruz Nieto">

		<!-- Mobile Metas -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	
		<link rel="icon" type="image/vnd.microsoft.icon" href="img/favicon.ico">

		<!-- Web Fonts  -->
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800|Shadows+Into+Light" rel="stylesheet" type="text/css">

		<!-- Vendor CSS -->
		<link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.css" />
		<link rel="stylesheet" href="vendor/animate/animate.css">

		<link rel="stylesheet" href="vendor/font-awesome/css/all.min.css" />
		<link rel="stylesheet" href="vendor/magnific-popup/magnific-popup.css" />
		<link rel="stylesheet" href="vendor/bootstrap-datepicker/css/bootstrap-datepicker3.css" />
		<link rel="stylesheet" href="vendor/datatables/media/css/dataTables.bootstrap4.css" />
		<!-- Theme CSS -->
		<link rel="stylesheet" href="css/theme.css" />

		<!-- Skin CSS -->
		<link rel="stylesheet" href="css/skins/default.css" />

		<!-- Theme Custom CSS -->
		<link rel="stylesheet" type="text/css" href="css/star-rating-svg.css">
		

		<!-- Head Libs -->
		<script src="vendor/modernizr/modernizr.js"></script>
		
		
	
	</head>
	<body>
		<section class="body">

			<!-- start: header -->
			<?php echo getHeader();?>
			<!-- end: header -->

			<div class="inner-wrapper">
				<!-- start: sidebar -->
				<aside id="sidebar-left" class="sidebar-left">
				
				    <div class="sidebar-header">
				        <div class="sidebar-title">
				            Menú
				        </div>
				        <div class="sidebar-toggle d-none d-md-block" data-toggle-class="sidebar-left-collapsed" data-target="html" data-fire-event="sidebar-left-toggle">
				            <i class="fas fa-bars" aria-label="Toggle sidebar"></i>
				        </div>
				    </div>
				
				    <div class="nano">
				        <div class="nano-content">
				            <?php echo getMenu();?>
				        </div>
				        <script>
				            // Maintain Scroll Position
				            if (typeof localStorage !== 'undefined') {
				                if (localStorage.getItem('sidebar-left-position') !== null) {
				                    var initialPosition = localStorage.getItem('sidebar-left-position'),
				                        sidebarLeft = document.querySelector('#sidebar-left .nano-content');
				                    
				                    sidebarLeft.scrollTop = initialPosition;
				                }
				            }
				        </script>
				    </div>
				</aside>
				<!-- end: sidebar -->

				<section role="main" class="content-body">
					<header class="page-header">
						<h2><?php echo $titulo ?></h2>
					
						<div class="right-wrapper text-right" style="margin-right: 20px;">
							<ol class="breadcrumbs">
								<li>
									<a href="index.php">
										<i class="fas fa-home"></i>
									</a>
								</li>
								<li><span><?php echo $seccion ?></span></li>
								<li><span><?php echo $titulo ?></span></li>
							</ol>
					
							
						</div>
					</header>

					<!-- start: page -->
					<?php if(isset($alerta)){echo imprimeAlerta($alerta); unset($alerta);}?>
					<div class="row">
						
						<div class="col-lg-4 col-xl-3 mb-4 mb-xl-0">

							<?php echo getFilmCard($pelicula,$id,$estadisticasfilm);?>

						</div>
						<div class="col-lg-8 col-xl-9 mb-8 mb-xl-12">
						<?php echo getTablaFilm($pelicula);	
						echo getComentarios($id);?>
						</div>
					</div>
					<div id="id_pelicula" pelicula="<?php echo $id ?>" style="display: none;" ></div>
					<div id="puntuacion_actual" puntuacion_pelicula="<?php echo $puntuacion_usuario_pelicula ?>" style="display: none;" ></div>
					
					<!-- end: page -->
				</section>
			</div>
		</section>

		<!-- Vendor -->
		<script src="vendor/jquery/jquery.js"></script>
		<script src="vendor/jquery-browser-mobile/jquery.browser.mobile.js"></script>
		<script src="vendor/popper/umd/popper.min.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.js"></script>
		<script src="vendor/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
		<script src="vendor/common/common.js"></script>
		<script src="vendor/nanoscroller/nanoscroller.js"></script>
		<script src="vendor/magnific-popup/jquery.magnific-popup.js"></script>
		<script src="vendor/jquery-placeholder/jquery.placeholder.js"></script>
		<script src="vendor/datatables/media/js/jquery.dataTables.min.js"></script>
		<script src="vendor/datatables/media/js/dataTables.bootstrap4.min.js"></script>
		<!-- Theme Base, Components and Settings -->
		<script src="js/theme.js"></script>
		
		<!-- Theme Custom -->
		<script src="js/custom.js"></script>
		<script src="js/datatables.default.js"></script>
		<script src="js/jquery.star-rating-svg.js"></script>
		<script src="funciones/funciones_detalles_js.js"></script>
		
		
		<!-- Theme Initialization Files -->
		<script src="js/theme.init.js"></script>

	</body>
</html>