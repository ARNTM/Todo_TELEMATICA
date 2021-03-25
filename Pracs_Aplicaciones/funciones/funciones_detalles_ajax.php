<?php
include("funciones_detalles_sql.php");
include("funciones_generales_sql.php");
include("funciones_generales_php.php");

if(isset($_POST['auth'])){
	$auth=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['auth'])))));
	$authd = "R3g1LQginQVPBv2sO4jDMzgzv";
	
	if($auth == $authd){
		$funcion = htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['funcion'])))));
		
		switch ($funcion){
			case "puntuar":
				$puntuacion=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['puntuacion'])))));
				$idpelicula=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['idpelicula'])))));
				$res = insertarPuntuacion(getUserId($_SESSION['username']),$idpelicula,$puntuacion);
				if($res == "PU002") {
					echo "Error al puntuar";
				}
				else {
					echo "Puntuada correctamente";
				 }
			break;
		}
	}
}
?>