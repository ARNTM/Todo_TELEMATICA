<?php
function getPelicula($id){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	$sentencia="SELECT * FROM movie WHERE id='$id'";
	$ejecucion=$conexion->query($sentencia);
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	if($ejecucion->rowCount()>0){
		while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

			$devolver=$datos;
		}	
	}else{
		$devolver=null;
	}
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

function getGeneros($id){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	$sentencia="SELECT genre.name as genero FROM moviegenre,genre WHERE moviegenre.movie_id=$id and moviegenre.genre=genre.id";
	$ejecucion=$conexion->query($sentencia);
	$devolver=array();
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	if($ejecucion->rowCount()>0){
		while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

			$devolver[]=$datos;
		}	
	}else{
		$devolver=null;
	}
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

function getAllComentarios($id){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	$sentencia="SELECT users.name, moviecomments.comment FROM moviecomments,movie,users WHERE movie_id=$id and moviecomments.movie_id=movie.id and moviecomments.user_id=users.id";
	$ejecucion=$conexion->query($sentencia);
	$devolver=array();
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	if($ejecucion->rowCount()>0){
		while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

			$devolver[]=$datos;
		}	
	}else{
		$devolver=null;
	}
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

function insertarComentario($comentario,$idpelicula,$idusuario){
	$conexion=conectaBBDD();
	$sentencia="INSERT INTO moviecomments(movie_id,user_id,comment) VALUES ($idpelicula,$idusuario,'$comentario')";

	$ejecucion=$conexion->query($sentencia);
	if($ejecucion){$devolver = "CO001";}
	else $devolver="CO002";
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
}

function getUserId($nombre){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT id FROM users WHERE username='$nombre'";
	$ejecucion=$conexion->query($sentencia);
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	if($ejecucion->rowCount()>0){
		while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){
			$devolver=$datos['id'];
		}			
	}
	else{
		$devolver=null;
	}
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

function insertarPuntuacion($idusuario,$idpelicula,$score){
	$conexion=conectaBBDD();
	$sentencia="INSERT INTO user_score (id_user,id_movie,score) VALUES ('$idusuario','$idpelicula','$score') ON DUPLICATE KEY UPDATE score='$score'";
	
	$ejecucion=$conexion->query($sentencia);
	if($ejecucion){$devolver = "PU001";}
	else $devolver="PU002";
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
}

function buscarPuntuacion($idusuario,$idpelicula){
	$conexion=conectaBBDD();
	$sentencia="SELECT score FROM user_score WHERE id_user='$idusuario' and id_movie='$idpelicula'";
	
	$ejecucion=$conexion->query($sentencia);
	if($ejecucion->rowCount()>0){
		while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){
			$devolver=$datos['score'];
		}			
	}
	else{
		$devolver=0;
	}
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
}


?>