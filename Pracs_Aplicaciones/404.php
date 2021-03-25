<?php 

include('funciones/funciones_generales_php.php');
include('funciones/funciones_generales_sql.php');


$titulo = 'Error 404';
$seccion = 'Error';

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
											<section class="body-error error-inside">
							<div class="center-error">

								<div class="row">
									<div class="col-lg-8">
										<div class="main-error mb-3">
											<h2 class="error-code text-dark text-center font-weight-semibold m-0">404 <i class="fas fa-file"></i></h2>
											<p class="error-explanation text-center">Página no encontrada</p>
										</div>
									</div>
									<div class="col-lg-4">
										<h4 class="text">Enlaces de interés</h4>
										<ul class="nav nav-list flex-column primary">
											<li class="nav-item">
												<a class="nav-link" href="index.php"><i class="fas fa-caret-right text-dark"></i> Inicio</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="mi-perfil.php"><i class="fas fa-caret-right text-dark"></i> Mi perfil</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="listado_peliculas.php"><i class="fas fa-caret-right text-dark"></i> Listado de películas</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</section>
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
		
		<!-- Theme Base, Components and Settings -->
		<script src="js/theme.js"></script>
		
		<!-- Theme Custom -->
		<script src="js/custom.js"></script>
		
		<!-- Theme Initialization Files -->
		<script src="js/theme.init.js"></script>

	</body>
</html>