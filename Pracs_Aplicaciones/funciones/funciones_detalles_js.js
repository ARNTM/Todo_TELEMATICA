// JavaScript Document

$(".my-rating").starRating({
	starSize: 25,
	initialRating: document.getElementById('puntuacion_actual').getAttribute('puntuacion_pelicula'),
	totalStars: 5,
	ratedColors: ['#ff0000', '#c93600', '#7f8000', '#32cc00', '#00ff00'],
	callback: function(currentRating){
		if(document.getElementById('puntuacion_actual').getAttribute('puntuacion_pelicula') == 'no'){
			$("#no_registrado").show().html('<strong>Función no disponible.</strong> Para poder puntuar <a href="registro.php" class="alert-link">registrate aquí</a>');
		} else {
			puntuar(currentRating);
		}

	}
});

function puntuar(puntuacion) {
	'use strict';
	if(puntuacion > 0){
		var auth = "R3g1LQginQVPBv2sO4jDMzgzv";
		var funcion = "puntuar";
		var idpelicula = document.getElementById('id_pelicula').getAttribute('pelicula');
		jQuery.ajax({
			url : "funciones/funciones_detalles_ajax.php",
			data:"funcion="+funcion+"&auth="+auth+"&puntuacion="+puntuacion+"&idpelicula="+idpelicula,
			type: "POST",
			success:function(data){
				if(data!='Puntuada correctamente'){
					$("#alerta_puntuacion_mal").show().html(data);
					$("#alerta_puntuacion_bien").hide();
				}
				else{
					$("#alerta_puntuacion_bien").show().html(data);
					$("#alerta_puntuacion_mal").hide();
				}
			},
			error:function (){}
		});
	}
}