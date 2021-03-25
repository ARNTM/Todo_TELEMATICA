<?php 
function conectaBBDD(){

	if($_SERVER['HTTP_HOST']=='labit601.upct.es'){
		$usuario = 'ai51';
		$pwd = 'ai2020';
		$bd="ai51";
		$host="localhost";
	}
	else {
		$usuario = 'filmrank';
		$pwd = 'Bccu8nf2bR7mz19h';
		$bd="filmrank";
		$host="localhost";
	}
	$dsn="mysql:$host=localhost;dbname=$bd;charset=utf8";
	
	try {
		$conexion = new PDO($dsn,$usuario,$pwd);
	} catch (PDOException $e) {
 		echo 'Error en la conexión: ' . $e->getMessage();
	};

    return $conexion;

}

function buscaUsuario($nombre){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT id FROM users WHERE username='$nombre' or mail='$nombre'";
	$ejecucion=$conexion->query($sentencia);
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	
	if($ejecucion->rowCount()>0){
			$devolver=true;
	}
	else{
		$devolver=false;
	}
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

function existeUsuario($nombre){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT id FROM users WHERE username='$nombre'";
	$ejecucion=$conexion->query($sentencia);
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	
	if($ejecucion->rowCount()>0){
			$devolver=true;
	}
	else{
		$devolver=false;
	}
	$ejecucion = null;
	$conexion = null;
	return $devolver; 
	
}

function existeMail($nombre){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	$sentencia="SELECT id FROM users WHERE mail='$nombre'";
	$ejecucion=$conexion->query($sentencia);
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	
	if($ejecucion->rowCount()>0){
			$devolver=true;
	}
	else{
		$devolver=false;
	}
	
	$ejecucion = null;
	$conexion = null;
	return $devolver; 
	
}

function compruebaPass($nombre,$pass){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT * FROM users WHERE (username='$nombre' or mail='$nombre') and passwd='$pass'";
	$ejecucion=$conexion->query($sentencia);
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	if($ejecucion->rowCount()>0){
		while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){
			$devolver=$datos;
		}	
	}
	else{
		$devolver='US003';
	}
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

function insertarUsuario($username,$mail,$nombre,$edad,$sexo,$ocupacion,$pic,$password){
	$conexion=conectaBBDD();
	$sentencia="INSERT INTO users(username, mail, name, edad, sex, ocupacion, pic, passwd) VALUES ('$username','$mail','$nombre','$edad','$sexo','$ocupacion','$pic','$password')";
	
	$ejecucion=$conexion->query($sentencia);
	if($ejecucion){$devolver = true;}
	else $devolver=false;
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
}

function actualizarPass($pass){	
	$conexion=conectaBBDD();
	$usuario=$_SESSION['username'];
	$sentencia="UPDATE users SET passwd='$pass' WHERE username='$usuario'";
	
	$ejecucion=$conexion->query($sentencia);
	if($ejecucion){$devolver = true;}
	else $devolver=false;
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
}

function actualizarPerfil($nombre,$edad,$sexo,$ocupacion){	
	$conexion=conectaBBDD();
	$usuario=$_SESSION['username'];
	$sentencia="UPDATE users SET name='$nombre', edad='$edad',sex='$sexo',ocupacion='$ocupacion' WHERE username='$usuario'";
	
	$ejecucion=$conexion->query($sentencia);
	if($ejecucion){$devolver = true;}
	else $devolver=false;
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
}

function actualizarFoto($pic){	
	$conexion=conectaBBDD();
	$usuario=$_SESSION['username'];
	$sentencia="UPDATE users SET pic='$pic' WHERE username='$usuario'";
	$ejecucion=$conexion->query($sentencia);
	if($ejecucion){$devolver = true;}
	else $devolver=false;
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
}

function getAlerta($alerta){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT * FROM alertas WHERE ID='$alerta'";
	$ejecucion=$conexion->query($sentencia);
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	if($ejecucion->rowCount()>0){
		while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

			$devolver=$datos;
		}
	}	
	else{
		$devolver=null;
	}
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

function getNumUsuarios(){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT COUNT(*) as u FROM users";
	$ejecucion=$conexion->query($sentencia);
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

		$devolver=$datos['u'];
	}	
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

function getNumVotaciones(){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT COUNT(*) as u FROM user_score";
	$ejecucion=$conexion->query($sentencia);
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

		$devolver=$datos['u'];
	}	
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

?>