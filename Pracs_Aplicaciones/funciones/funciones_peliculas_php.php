<?php 
include('api-tmdb.php');
function getTablaPeliculas(){
	$peliculas = getPeliculas();
	$estadisticas = getEstadisticas();
	$devolver='							
	<div class="row">
		<div class="col">
			<section class="card">
				<header class="card-header">

					<h2 class="card-title">Películas</h2>
				</header>
				<div class="card-body">
					<table class="table table-bordered table-striped mb-0 text-center" id="datatable">
						<thead>
							<tr>
								<th class="align-middle" style="width: 10% !important;">Portada</th>
								<th class="align-middle" style="width: 32% !important;">Nombre</th>
								<th class="align-middle" style="width: 14% !important;">Fecha de estreno</th>
								<th class="align-middle" style="width: 14% !important;">Puntuación</th>
								<th class="align-middle" style="width: 14% !important;">Puntuación ponderada</th>
								<th class="align-middle" style="width: 14% !important;">Detalles</th>
							</tr>
						</thead>
						<tbody>';
					foreach($peliculas as $peli){
						$key = array_search($peli['id'], array_column($estadisticas, 'ID_MOVIE'));
						$devolver.='							
							<tr>
								<td class="align-middle"><img src="img/portadas/'.$peli['url_pic'].'" width="100" height="150"></td>
								<td class="align-middle"><b>'.$peli['title'].'</b><br>'.$peli['descripcion'].'</td>
								<td class="align-middle">'.$peli['fecha'].'</td>
								<td class="align-middle">'.$estadisticas[$key]['PUNTUACION_MEDIA_PELICULA'].' de '.$estadisticas[$key]['NUM_PUNTUACIONES_PELICULA'].' usuarios</td>
								<td class="align-middle">'.$estadisticas[$key]['BAY'].'</td>
								<td class="align-middle"><a class="btn btn-primary" href="detalle_pelicula.php?id='.base64_encode($peli['id']).'" role="button">Detalles</a></td>
							</tr>';
					}
						$devolver.='</tbody>
					</table>
				</div>
			</section>
		</div>
	</div>';
	return $devolver;
}

function getCarruselPeliculas(){
		$peliculas= getUltimas10Peliculas();
		$devolver='';
		foreach ($peliculas as $p){
			$devolver.='
			<div class="item"><a title="Los Tejos" href="detalle_pelicula.php?id='.base64_encode($p['id']).'"><img class="img-thumbnail" src="'.getPosterById($p['tmdbId'],'original').'" alt=""></a></div>
			';
		}
		return $devolver;
	}

function getTablaPeliculasRecomendadas(){
	$peliculas = getPeliculasRecomendadas(getUserId($_SESSION['username']));
	$devolver='							
			<section class="card">
				<div class="card-body">
					<table class="table table-bordered table-striped mb-0 text-center" id="datatablerec">
						<thead>
							<tr>
								<th class="align-middle" style="width: 10% !important;">Portada</th>
								<th class="align-middle" style="width: 30% !important;">Nombre</th>
								<th class="align-middle" style="width: 30% !important;">Puntuación</th>
								<th class="align-middle" style="width: 30% !important;">Detalles</th>
							</tr>
						</thead>
						<tbody>';
					foreach($peliculas as $peli){
						$devolver.='							
							<tr>
								<td class="align-middle" style="width: 10% !important;"><img src="img/portadas/'.$peli['url_pic'].'" width="100" height="150"></td>
								<td class="align-middle" style="width: 30% !important;"><b>'.$peli['title'].'</td>
								<td class="align-middle" style="width: 30% !important;">'.$peli['score'].'</td>
								<td class="align-middle" style="width: 30% !important;"><a class="btn btn-primary" href="detalle_pelicula.php?id='.base64_encode($peli['id']).'" role="button">Detalles</a></td>
							</tr>';
					}
						$devolver.='</tbody>
					</table>
				</div>
			</section>';
	return $devolver;
}
?>