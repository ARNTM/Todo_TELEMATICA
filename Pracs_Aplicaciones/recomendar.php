<?php 

include('funciones/funciones_generales_php.php');
include('funciones/funciones_generales_sql.php');
include('funciones/funciones_detalles_php.php');
include('funciones/funciones_detalles_sql.php');

if(isset($_SESSION['username'])){
	try{
		$address = 'localhost';
		$port = 1111;

		$ruta="/home/alumnos/ai51/public_html/algoritmo_recomendacion\r\n";
		$fun="recomendar(".getUserId($_SESSION['username']).")\r\n";
		$info = $ruta.$fun.chr(0);

		$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
		socket_connect($socket, gethostbyname($address), $port);
		socket_write($socket, $info, strlen($info));
		socket_read($socket, 1024);
	}
	catch (Exception $e) {
    	echo 'Excepción capturada: ',  $e->getMessage(), "\n";
	}
}

else {
	header( "Location: index.php" );
}


?>