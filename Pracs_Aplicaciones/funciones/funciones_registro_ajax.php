<?php
include("funciones_generales_sql.php");

if(isset($_POST['auth'])){
	$auth=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['auth'])))));
	$authd = "7jiUFNfUIS6jPYseT8vv";
	
	if($auth == $authd){
		$funcion = htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['funcion'])))));
		
		switch ($funcion){
			case "comprobarUsuario":
				$user=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['username'])))));
				$existe = existeUsuario($user);
				if($existe) {
					echo "Este nombre de usuario está en uso.";
				}
				else {echo "SI";}
			break;
				
			case "comprobarMail":
				$user=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['mail'])))));
				$existe = existeMail($user);
				if($existe) {
					echo "Este correo está en uso.";
				}
				else {echo "SI";}
			break;	
		}
	}
}
?>