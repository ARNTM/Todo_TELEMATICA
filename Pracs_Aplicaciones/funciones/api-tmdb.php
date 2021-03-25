<?php
	$clave = 'c431d9457f68990e606c26fd1ff67b76';
	$idioma = 'es-ES';
	$imagesize = 'original'; //w500
	
	function getImage($url, $imagesize = 'original') {
		global $imagesize;
		return "https://image.tmdb.org/t/p/".$imagesize."/".$url;
	}
	
	function searchMovie($movie) {
		global $clave,$idioma;
		$json = file_get_contents("https://api.themoviedb.org/3/search/movie?api_key=".$clave."&language=".$idioma."&query=".urlencode($movie) , true);
		$movie = json_decode($json, true);
		return $movie['results'];
		
	}
	
	function getMovieByID($id) {
		global $clave,$idioma;
		$json = file_get_contents("https://api.themoviedb.org/3/movie/".$id."?api_key=".$clave."&language=".$idioma , true);
		$movie = json_decode($json, true);
		$pelicula['resumen'] = $movie['overview'];
		return $pelicula;
	}

	function getBackdrop($id) {
		global $clave,$idioma;
		$json = file_get_contents("https://api.themoviedb.org/3/movie/".$id."?api_key=".$clave."&language=".$idioma."&append_to_response=images" , true);
		$movie = json_decode($json, true);
		return $movie;
	}

	function getPosterById($id, $imagesize = 'original') {
		global $clave;
		$json = file_get_contents("https://api.themoviedb.org/3/movie/".$id."/images?api_key=".$clave);
		$movie = json_decode($json, true);
		return "https://image.tmdb.org/t/p/".$imagesize."/".$movie['posters'][1]['file_path'];
	}
								  
	function getBackdropById($id, $imagesize = 'original') {
		global $clave;
		$json = file_get_contents("https://api.themoviedb.org/3/movie/".$id."/images?api_key=".$clave);
		$movie = json_decode($json, true);
		return "https://image.tmdb.org/t/p/".$imagesize."/".$movie['backdrops'][2]['file_path'];
	}	

	function getCast($id) {
		global $clave;
		$json = file_get_contents("https://api.themoviedb.org/3/movie/".$id."/credits?api_key=".$clave);
		$movie = json_decode($json, true);
		//print_r($movie['crew'][1]['job']);
		$director = array_search('Director', array_column($movie['crew'], 'job'));
		$historia = array_search('Story', array_column($movie['crew'], 'job'));
		$actores = $movie['cast'];
		$cast['director']['job'] = "Director";
		$cast['historia']['job'] = "Historia";
		$cast['director']['name'] = $movie['crew'][$director]['name'];
		$cast['historia']['name'] = $movie['crew'][$historia]['name'];
		for ($i = 0 ; $i<5 ; $i++){
			$cast['actor'.$i]['job'] = $actores[$i]['character'];
			$cast['actor'.$i]['name'] = $actores[$i]['original_name'];
		}
		return $cast;
	}

?>