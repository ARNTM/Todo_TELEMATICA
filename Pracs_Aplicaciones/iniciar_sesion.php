<?php 
ini_set("default_charset", "UTF-8");
include('funciones/funciones_generales_sql.php');
include('funciones/funciones_inicio_php.php');
$titulo = 'Iniciar sesión';
	session_start();
	if(isset($_SESSION['username'])){
		header('Location: index.php');
	}
	if(isset($_POST['pwd']) && isset($_POST['username'])) {
		$pass=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['pwd'])))));
		$user=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['username'])))));
		$passcif=sha1($pass);
		if(buscaUsuario($user)){
			$datos = (compruebaPass($user,$passcif));
			if(isset($datos['id'])) {
				$_SESSION['username'] = $datos['username'];
				$_SESSION['mail'] = $datos['mail'];
				$_SESSION['nombre'] = $datos['name'];
				$_SESSION['edad'] = $datos['edad'];
				$_SESSION['sexo'] = $datos['sex'];
				$_SESSION['ocupacion'] = $datos['ocupacion'];
				$_SESSION['foto'] = $datos['pic'];
				header('Location: index.php');
			}
			else {$alerta = 'US001';}
		}
		else {$alerta = 'US001';}
		
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
		<!-- start: page -->
		<section class="body-sign">
			<div class="center-sign">
				<a href="/" class="logo float-left">
					<img src="img/logo.png" height="54" alt="Porto Admin" />
				</a>

				<div class="panel card-sign">
					<div class="card-title-sign mt-3 text-right">
						<h2 class="title text-uppercase font-weight-bold m-0"><i class="fas fa-user mr-1"></i> Iniciar sesión</h2>
					</div>
					<div class="card-body">
						<?php 
						
						if(isset($alerta))echo imprimeAlerta($alerta);
						
						?>
						<form action="iniciar_sesion.php" method="post">
							<div class="form-group mb-3">
								<label>Usuario</label>
								<div class="input-group">
									<input name="username" type="text" class="form-control form-control-lg" required/>
									<span class="input-group-append">
										<span class="input-group-text">
											<i class="fas fa-user"></i>
										</span>
									</span>
								</div>
							</div>

							<div class="form-group mb-3">
								<div class="clearfix">
									<label class="float-left">Contraseña</label>
								</div>
								<div class="input-group">
									<input name="pwd" type="password" class="form-control form-control-lg" required/>
									<span class="input-group-append">
										<span class="input-group-text">
											<i class="fas fa-lock"></i>
										</span>
									</span>
								</div>
							</div>

							<div class="row">
								<div class="col-sm-8">
								</div>
								<div class="col-sm-4 text-right">
									<button type="submit" class="btn btn-primary mt-2">Iniciar sesión</button>
								</div>
							</div>
							<br>
							<p class="text-center">¿No tienes cuenta? <a href="registro.php">¡Registrate!</a></p>

						</form>
					</div>
				</div>

				<p class="text-center text-muted mt-3 mb-3">&copy; Copyright 2020. All Rights Reserved. DIAGARN</p>
			</div>
		</section>
		<!-- end: page -->

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