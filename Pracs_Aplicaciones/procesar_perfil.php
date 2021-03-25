<?php

include('funciones/funciones_generales_php.php');
include('funciones/funciones_generales_sql.php');
include('funciones/funciones_usuario_php.php');

if(isset($_POST['pqwomcht'])){
	$password=sha1(htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['password']))))));
	$pwd_confirm=sha1(htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['pwd_confirm']))))));
	$password_actual=sha1(htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['password_actual']))))));
	if($password == $pwd_confirm){
		if(compruebaPass($_SESSION['username'],$password_actual)!='US003'){
		actualizarPass($password);
		session_destroy();
		header("Location: iniciar_sesion.php?logout=true");		
		}
		else {$alerta = 'US003'; header("Location: mi-perfil.php?mensaje=".$alerta);}
	} else {$alerta = 'US006'; header("Location: mi-perfil.php?mensaje=".$alerta);}
}

if(isset($_POST['amncheor'])){
	
	$password_actual=sha1(htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['password_actual']))))));
	$name=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['nombre'])))));
	$edad=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['edad'])))));
	$sexo=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['sexo'])))));
   	$ocupacion=htmlspecialchars(trim(addslashes(stripslashes(strip_tags($_POST['ocupacion'])))));
	
   	if(compruebaPass($_SESSION['username'],$password_actual)!='US003'){
		actualizarPerfil($name,$edad,$sexo,$ocupacion);
		$_SESSION['nombre'] = $name;
		$_SESSION['edad'] = $edad;
		$_SESSION['sexo'] = $sexo;
		$_SESSION['ocupacion'] = $ocupacion;
		$alerta = 'US004';
		header("Location: mi-perfil.php?mensaje=".$alerta);	
		$_POST = array();
	}
	else {$alerta = 'US003'; header("Location: mi-perfil.php?mensaje=".$alerta);}
	
}

if(isset($_POST['qmguryzx'])){
		$target_dir="img/usuarios/";
		$splitname = explode(".", basename($_FILES["foto"]["name"]));
		$target_file = $target_dir . randomString() . "." . $splitname[1];
		move_uploaded_file($_FILES["foto"]["tmp_name"], $target_file);
		if($_SESSION['foto'] != "img/unknown.jpg"){
			actualizarFoto($target_file);
			shell_exec("rm ". $_SESSION['foto']);
			$_SESSION['foto'] = $target_file;
			$alerta = 'US005';
		}else{
			actualizarFoto($target_file);
			$_SESSION['foto'] = $target_file;
			$alerta = 'US005';
		}
		header("Location: mi-perfil.php?mensaje=".$alerta);	
		$_POST = array();
}

if(isset($_POST['aqionqdo'])){
	actualizarFoto("img/unknown.jpg");
	if($_SESSION['foto']!="img/unknown.jpg")
	shell_exec("rm ". $_SESSION['foto']);
	$_SESSION['foto'] = "img/unknown.jpg";
	$alerta = 'US005';
	header("Location: mi-perfil.php?mensaje=".$alerta);	
	$_POST = array();
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