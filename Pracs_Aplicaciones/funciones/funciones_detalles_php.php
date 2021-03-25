<?php

function getFilmCard($pelicula,$id,$estadisticasfilm){
	$generos=getGeneros($id);
	$devolver = '
	<section class="card">
	<div class="card-body">
		<div class="thumb-info mb-3">
			<img src="img/portadas/'.$pelicula['url_pic'].'" class="rounded img-fluid" alt="'.$pelicula['title'].'">
			<!--<div class="thumb-info-title mb-3" >
				<span class="thumb-info-inner">'.$pelicula['title'].'</span>				
			</div>-->
		</div>

		<div class="widget-toggle-expand">
			<hr class="dotted short">
			<div class="widget-header">
				<h5 class="mb-0 "><strong>Puntuación</strong></h5>
			</div>
			<div class="widget-content-expanded" id="stats">
				<ul class="simple-todo-list mt-1" id="estadisticas">
					<li class="completed" id="BAY">Puntuacion ponderada: '.$estadisticasfilm['BAY'].'</li>
					<li class="completed" id="PMEDIA">Puntuacion media: '.$estadisticasfilm['PUNTUACION_MEDIA_PELICULA'].'</li>
					<li class="completed" id="NVOTOS">Puntuada por '.$estadisticasfilm['NUM_PUNTUACIONES_PELICULA'].' usuarios</li> 
				</ul>
			</div>
			<hr class="dotted short">
			<div class="widget-header">
				<h5 class="mb-0 "><strong>Tu puntuación</strong></h5>
			</div>		
			<div class="my-rating"></div><br>
			<div class="alert alert-danger" id="alerta_puntuacion_mal" style="display:none"></div>
			<div class="alert alert-success" id="alerta_puntuacion_bien" style="display:none"></div>
			<div class="alert alert-danger" id="no_registrado" style="display:none"></div>
			<hr class="dotted short">
			<div class="widget-header">

				<h5 class="mb-0 "><strong>Géneros</strong></h5>
			</div>
			<div class="widget-content-expanded">
				<ul class="simple-todo-list mt-1">';
				foreach($generos as $genero){
					$devolver.='<li class="completed">'.$genero['genero'].'</li>';
				}				
				$devolver.='</ul>
			</div>
		</div>

			<hr class="dotted short">

			<h5 class="mb-2 mt-3">Sipnosis</h5>
			<p class="text-2">'.$pelicula['descripcion'].'</p>
			<div class="clearfix">
				<a class="text-uppercase text-muted float-right" href="#">(Ver todo)</a>
			</div>

			<hr class="dotted short">

		</div>
	</section>';
	return $devolver;
}

function getTablaFilm($pelicula){
	$reparto=getCast($pelicula['tmdbId']);
	$devolver=	'
					<div class="tabs">
						<ul class="nav nav-tabs tabs-primary">	
						</ul>
						<div class="tab-content">
							<div id="recomendaciones" class="tab-pane active">
								<div class="p-3">

									<h4 class="mb-3"><strong>'.$pelicula['title'].'</strong></h4>
									<section class="simple-compose-box mb-3">
									</section>
									<h4 class="mb-3 pt-4">'.getMovieById($pelicula['tmdbId'])['resumen'].'</h4><br>
									
									<h4 class="mb-3"><strong>Reparto</strong></h4>
									<section class="simple-compose-box mb-3">
									</section>
										
										<ul class="simple-todo-list mt-1">';
										foreach($reparto as $r){
											$devolver.='<li class="completed">'.$r['name'].' - '.$r['job'].'</li>';
										}				
										$devolver.='</ul><br>
										<a class="btn btn-primary" href="https://www.themoviedb.org/movie/'.$pelicula['tmdbId'].'/cast" role="button" target="_blank">Reparto completo</a>
								</div>
							</div>
						</div>
					</div>';
	return $devolver;
}

function getComentarios($id){
	$comentarios=getAllComentarios($id);
	$devolver=	'<div class="tabs">
						<ul class="nav nav-tabs tabs-primary">	
						</ul>
						<div class="tab-content">
							<div id="recomendaciones" class="tab-pane active">
								<div class="p-3">

									<h4 class="mb-3"><strong>Comentarios</strong></h4>
									<section class="simple-compose-box mb-3">
									</section>
					<table class="table table-bordered table-striped mb-0 text-center" id="datatable">
						<thead>
							<tr>
								<th class="align-middle" style="width: 20% !important;">Nombre</th>
								<th class="align-middle" style="width: 80% !important;">Comentario</th>
							</tr>
						</thead>
						<tbody>';
						if($comentarios!=null){
							foreach($comentarios as $c){
								$devolver.='							
									<tr>									
										<td class="align-middle"><b>'.$c['name'].'</b></td>
										<td class="align-middle">'.$c['comment'].'</td>
									</tr>';
							}
						}
						$devolver.='</tbody>
					
					</table>
									
									<h4 class="mb-3"><strong>Añadir comentario</strong></h4>
									<section class="simple-compose-box mb-3">
									</section>';
						if(isset($_SESSION['username'])){
							$devolver.='
							<form action="procesar_comentario.php" method="post">
								<input type="hidden" name="addcomment" id="addcomment">
								<input type="hidden" name="idp" id="idp" value='.$id.'>
								<div class="form-group">
									<div class="col-sm-12 mb-12">
										<textarea name="comentario" id="comentario" style="width:100%" rows="5" required ></textarea>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12 text-left">
										<button type="submit" id="addcomentario" class="btn btn-primary mt-2" >Añadir comentario</button>
									</div>
								</div>
							</form>';
						}else{
							$devolver.='<div class="alert alert-danger">
											<strong>Función no disponible.</strong> Para poder comentar <a href="registro.php" class="alert-link">registrate aquí</a>.
										</div>';
						}							
						$devolver.='										
								</div>
							</div>
						</div>
					</div>';
	return $devolver;
}
?>