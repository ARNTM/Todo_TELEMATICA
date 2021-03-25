<?php 
	include('funciones/funciones_generales_sql.php');
	include('funciones/funciones_inicio_php.php');
	$titulo = 'Registrar';
	session_start();
	if(isset($_SESSION['username'])){
		header('Location: index.php');
	}

	if(isset($_POST['password'])) {
		$username=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['username'])))));
		$mail=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['mail'])))));
		$nombre=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['nombre'])))));
		$edad=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['edad'])))));
		$sexo=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['sexo'])))));
		$ocupacion=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['ocupacion'])))));
		$password=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['password'])))));
		
		$target_dir="img/usuarios/";
		$splitname = explode(".", basename($_FILES["foto"]["name"]));
		$target_file = $target_dir . randomString() . "." . $splitname[1];
		move_uploaded_file($_FILES["foto"]["tmp_name"], $target_file);

		$insertarUsuario = insertarUsuario($username,$mail,$nombre,$edad,$sexo,$ocupacion,$target_file,sha1($password));
		if($insertarUsuario){
				$_SESSION['username'] = $username;
				$_SESSION['mail'] = $mail;
				$_SESSION['nombre'] = $nombre;
				$_SESSION['edad'] = $edad;
				$_SESSION['sexo'] = $sexo;
				$_SESSION['ocupacion'] = $ocupacion;
				$_SESSION['foto'] = $target_file;
				header('Location: index.php');
		} else {$alerta = 'US002';}
		
	}

	function randomString($length = 10) {
		$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$charactersLength = strlen($characters);
		$randomString = '';
		for ($i = 0; $i < $length; $i++) {
			$randomString .= $characters[rand(0, $charactersLength - 1)];
		}
		return $randomString;
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
						<h2 class="title text-uppercase font-weight-bold m-0"><i class="fas fa-user mr-1"></i> Registro</h2>
					</div>
					<div class="card-body">
						<?php 
						
						if(isset($alerta))echo imprimeAlerta($alerta);
						
						?>
						<form action="registro.php" method="post" enctype="multipart/form-data">
							<div class="form-group mb-3">
								<label>Nombre de usuario</label>
								<input name="username" id="username" type="text" autocomplete="username" class="form-control form-control-lg" onBlur="comprobarUsuario()" required/>
							</div>
							<div class="alert alert-danger" id='usernotavailable' style="display:none"></div>
							<p><img src="img/loader.gif" id="loaderUser" style="display:none; height: 30px; text-align: center;" /></p>
							<div class="form-group mb-3">
								<label>Correo electronico</label>
								<input name="mail" id="mail" type="email" class="form-control form-control-lg" onBlur="comprobarEmail()" required/>
							</div>
							<div class="alert alert-danger" id='mailnotavailable' style="display:none"></div>
							<p><img src="img/loader.gif" id="loaderMail" style="display:none; height: 30px;" /></p>
							<div class="form-group mb-0">
								<div class="row">
									<div class="col-sm-6 mb-3">
										<label>Nombre</label>
										<input name="nombre" id="nombre" type="text" class="form-control form-control-lg" required/>
									</div>
									<div class="col-sm-6 mb-3">
										<label>Edad</label>
										<input name="edad" id="edad" type="text" class="form-control form-control-lg" required/>
									</div>									
								</div>
							</div>
							<div class="form-group mb-0">
								<div class="row">
									<div class="col-sm-6 mb-3">
										<label>Sexo</label>
										<select class="form-control" id="sexo" name="sexo" required>
											  <option value="M">Hombre</option>
											  <option value="F">Mujer</option>
										</select>
									</div>	
									
									<div class="col-sm-6 mb-3">
										  <div class="form-group">
											<label>Ocupación</label>
											<select class="form-control" id="ocupacion" name="ocupacion" required>
											  <option value="artist">Artist</option>
											  <option value="doctor">Doctor</option>
											  <option value="educator">Educator</option>
											  <option value="engineer">Engineer</option>
											  <option value="entertainment">Entertainment</option>
											  <option value="executive">Executive</option>
											  <option value="healthcare">Healthcare</option>
											  <option value="homemaker">Homemaker</option>
											  <option value="lawyer">Lawyer</option>
											  <option value="librarian">Librarian</option>
											  <option value="marketing">Marketing</option>
											  <option value="programmer">Programmer</option>
											  <option value="retired"> Retired</option>
											  <option value="salesman">Salesman</option>
											  <option value="scientist">Scientist</option>
											  <option value="student">Student</option>
											  <option value="technician">Technician</option>
											  <option value="writer">Writer</option>
											  <option value="none">None</option>
											  <option value="other">Other</option>
											</select>
										  </div>
									</div>								
								</div>
							</div>
							
							<div class="form-group mb-3">
								<label>Foto</label>
								<input name="foto" id="foto" type="file" accept="image/png,image/jpg,image/jpeg" class="form-control-file" required/>
							</div>
							
							<div class="form-group mb-0">
								<div class="row">
									<div class="col-sm-6 mb-3">
										<label>Contraseña</label>
										<input name="password" type="password" id="password" autocomplete="new-password" class="form-control form-control-lg" minlength="8" required/>
									</div>
									<div class="col-sm-6 mb-3">
										<label>Confirmar contraseña</label>
										<input name="pwd_confirm" type="password" autocomplete="new-password" id="confirm_password" class="form-control form-control-lg" minlength="8" required/>
									</div>
								</div>
							</div>
							<div class="alert alert-danger" id='notmatch' style="display:none">

							</div>
							<div class="row">
								<div class="col-sm-8">

								</div>
								<div class="col-sm-4 text-right">
									<button type="submit" id="registrar" class="btn btn-primary mt-2" disabled>Registrar</button>
								</div>
							</div>

							<br>

							<p class="text-center">¿Ya tienes cuenta? <a href="iniciar_sesion.php">Iniciar sesión</a></p>

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
		<script src="funciones/funciones_registro_js.js"></script>

		
		<!-- Theme Initialization Files -->
		<script src="js/theme.init.js"></script>

	</body>
</html>