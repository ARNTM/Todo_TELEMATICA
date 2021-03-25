<?php 
ini_set("default_charset", "UTF-8");

session_start();

if(isset($_GET['logout']) && $_GET['logout']==true){
	session_destroy();
	header( "Location:".$_SERVER['PHP_SELF'] );
}

function getHeader(){
	$devolver='
				<header class="header">
				<div class="logo-container">
					<a href="index.php" class="logo">
						<img src="img/logo.png" width="125" height="45" alt="Porto Admin" />
					</a>
					<div class="d-md-none toggle-sidebar-left" data-toggle-class="sidebar-left-opened" data-target="html" data-fire-event="sidebar-left-opened">
						<i class="fas fa-bars" aria-label="Toggle sidebar"></i>
					</div>
				</div>
			
				<!-- start: search & user box -->
				<div class="header-right">
			
					<span class="separator"></span>';
	
						if(isset($_SESSION['nombre'])){
							$devolver.='<div id="userbox" class="userbox">
						<a href="#" data-toggle="dropdown">
							<figure class="profile-picture">
								<img src="'.$_SESSION['foto'].'" alt="Joseph Doe" class="rounded-circle" data-lock-picture="'.$_SESSION['foto'].'" />
							</figure>
							<div class="profile-info" data-lock-name="'.$_SESSION['nombre'].'" data-lock-email="'.$_SESSION['mail'].'">
								<span class="name">'.$_SESSION['nombre'].'</span>
								<span class="role">'.$_SESSION['ocupacion'].'</span>
							</div>
			
							<i class="fa custom-caret"></i>
						</a>
						<div class="dropdown-menu">
								<ul class="list-unstyled mb-2">
									<li class="divider"></li>
									<li>
										<a role="menuitem" tabindex="-1" href="mi-perfil.php"><i class="fas fa-user"></i> Mi perfil</a>
									</li>							
									<li>
										<a role="menuitem" tabindex="-1" href="?logout=true"><i class="fas fa-power-off"></i> Logout</a>
									</li>
								</ul>
							</div>';
						}						
						else{						
							$devolver.='<div id="userbox" class="userbox">
						<a href="#" data-toggle="dropdown">
							<figure class="profile-picture">
								<img src="img/unknown.jpg" alt="Joseph Doe" class="rounded-circle" data-lock-picture="img/unknown.jpg" />
							</figure>
							<div class="profile-info">
								<span class="name">Iniciar sesión</span>
							</div>
			
							<i class="fa custom-caret"></i>
						</a>
						<div class="dropdown-menu">
							<ul class="list-unstyled mb-2">
								<li class="divider"></li>
								<li>
									<a role="menuitem" tabindex="-1" href="iniciar_sesion.php"><i class="fas fa-sign-in-alt"></i> Iniciar sesión</a>
								</li>							<li>
									<a role="menuitem" tabindex="-1" href="registro.php"><i class="fas fa-user-plus"></i> Registrarse</a>
								</li>

							</ul>
						</div>';}
						
					$devolver.='</div>
				</div>
				<!-- end: search & user box -->
			</header>
	';
	return $devolver;
}

function getMenu(){
	$devolver='
	<nav id="menu" class="nav-main" role="navigation">			            
	<ul class="nav nav-main">
		<li>
			<a class="nav-link" href="index.php">
				<i class="fas fa-home" aria-hidden="true"></i>
				<span>Inicio</span>
			</a>                        
		</li>		
		<li>
			<a class="nav-link" href="listado_peliculas.php">
				<i class="fas fa-film" aria-hidden="true"></i>
				<span>Listado de películas</span>
			</a>                        
		</li>
	</ul>
</nav>';
	return $devolver;
	
}

function imprimeAlerta($alerta){
	$a = getAlerta($alerta);
	if($a != null){
		$devolver='									
			<div class="alert alert-'.$a['TYPE'].'">
				<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
				<strong>'.$a['ID'].':</strong> '.$a['TEXT'].'
			</div>';
		return $devolver;
	}
}

?>