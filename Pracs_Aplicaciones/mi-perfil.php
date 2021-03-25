<?php

include('funciones/funciones_generales_php.php');
include('funciones/funciones_generales_sql.php');
include('funciones/funciones_usuario_php.php');

$titulo = 'Mi perfil';
$seccion = 'Usuario';

if(isset($_GET['mensaje'])){
	$alerta = $_GET['mensaje'];
}

if(!isset($_SESSION['nombre'])){
	header("Location: index.php");
}

?>

<!doctype html>
<html class="fixed">
	<head>

		<!-- Basic -->
		<meta charset="UTF-8">

		<title><?php echo $titulo." | FilmRank";?></title>
		<meta name="keywords" content="FilmRank" />
		<meta name="description" content="FilmRank">
		<meta name="author" content="Diego Ismael Antolinos García y Andrés Ruz Nieto">
		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />

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
		
		<!-- Theme CSS -->
		<link rel="stylesheet" href="css/theme.css" />

		<!-- Skin CSS -->
		<link rel="stylesheet" href="css/skins/default.css" />

		<!-- Theme Custom CSS -->
		<link rel="stylesheet" href="css/custom.css">

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

							<?php echo getUserCard(); ?>

						</div>
						<?php echo getTablaUsuario($_SESSION['username']);?>
						
					</div>
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
		
		<!-- Specific Page Vendor -->
		<script src="vendor/autosize/autosize.js"></script>
		
		<!-- Theme Base, Components and Settings -->
		<script src="js/theme.js"></script>
		
		<!-- Theme Custom -->
		<script src="js/custom.js"></script>
		
		<!-- Theme Initialization Files -->
		<script src="js/theme.init.js"></script>
		<script src="js/modals.js"></script>
		<script>
		var httpRequest;
			function recomendarPeliculas() {
				if (window.XMLHttpRequest) { // Mozilla, Safari, ...
					httpRequest = new XMLHttpRequest();
					httpRequest.onreadystatechange = mostrarRecomendaciones;
					httpRequest.open('GET', 'http://labit601.upct.es/~ai51/recomendar.php', true);
					httpRequest.send(null);


				}
			}
			function mostrarRecomendaciones() {
				try {
					if (httpRequest.readyState === 4) {
						if (httpRequest.status === 200) {
							$('.modal-dismiss').click(); 
							$('.simple-ajax-modal').click(); 
						} else {
							alert('There was a problem with the request:' + httpRequest.readyState);

						}
					}

				} catch (ex) {
					alert('Caught Exception: ' + ex.description);
				}
			}
		</script>

	</body>
</html>