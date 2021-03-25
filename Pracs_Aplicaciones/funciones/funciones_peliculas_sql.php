<?php
function getPeliculas(){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT * FROM movie";
	$ejecucion=$conexion->query($sentencia);
	$devolver=array();
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

		$devolver[]=$datos;
	}	
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

function getEstadisticas() {
		// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="
	SELECT id_movie AS ID_MOVIE, PUNTUACION_MEDIA_PELICULA, NUM_PUNTUACIONES_PELICULA,
    
	ROUND(((SELECT COUNT(DISTINCT(id_movie)) as T_P FROM user_score)*(SELECT ROUND(AVG(score),4) AS M_T FROM user_score)+PUNTUACION_MEDIA_PELICULA*NUM_PUNTUACIONES_PELICULA)/((SELECT COUNT(DISTINCT(id_movie)) as T_P FROM user_score)+NUM_PUNTUACIONES_PELICULA),4) AS BAY
	
	FROM(
		SELECT id_movie, ROUND(AVG(SCORE),4) AS PUNTUACION_MEDIA_PELICULA,
    	COUNT(score) AS NUM_PUNTUACIONES_PELICULA
		FROM user_score US_SCORE
		GROUP BY id_movie) AS CALCULOS";
	
	$ejecucion=$conexion->query($sentencia);
	$devolver=array();
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

		$devolver[]=$datos;
	}	
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
}

function getUltimas10Peliculas() {
		// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT id,tmdbId FROM movie ORDER BY movie.fecha DESC LIMIT 10";
	
	$ejecucion=$conexion->query($sentencia);
	$devolver=array();
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

		$devolver[]=$datos;
	}	
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
}

function getNumPeliculas(){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT COUNT(*) as num FROM movie";
	$ejecucion=$conexion->query($sentencia);
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

		$devolver=$datos['num'];
	}	
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}

function getPeliculasRecomendadas($id){
	
	// Nos conectamos con la base de datos
	$conexion=conectaBBDD();
	
	$sentencia="SELECT movie.id as id, movie.title as title, movie.url_pic as url_pic, recs.rec_score as score FROM movie,recs WHERE recs.user_id=$id AND movie.id=recs.movie_id";
	$ejecucion=$conexion->query($sentencia);
	$devolver=array();
	
	// Metemos en un array los datos obtenido, como un array asociativo (indice como string)
	while($datos=$ejecucion->fetch(PDO::FETCH_ASSOC)){

		$devolver[]=$datos;
	}	
	
	// Cerramos la conexión
	$ejecucion = null;
	$conexion = null;
	
	return $devolver; 
	
}
?>