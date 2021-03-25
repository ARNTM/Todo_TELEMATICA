<?php
include('funciones/funciones_generales_php.php');
include('funciones/funciones_generales_sql.php');
include('funciones/funciones_detalles_php.php');
include('funciones/funciones_detalles_sql.php');
include('funciones/funciones_peliculas_sql.php');

if(isset($_POST['addcomment'])){
	$alerta = insertarComentario($_POST['comentario'],$_POST['idp'],getUserId($_SESSION['username']));
	header("Location: detalle_pelicula.php?id=".base64_encode($_POST['idp'])."&mensaje=".$alerta);
} 

?>