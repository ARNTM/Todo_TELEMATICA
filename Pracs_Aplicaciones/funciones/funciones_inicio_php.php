<?php
function imprimeAlerta($alerta){
	$a = getAlerta($alerta);
	$devolver='									
		<div class="alert alert-'.$a['TYPE'].'">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
			<strong>'.$a['ID'].':</strong> '.$a['TEXT'].'
		</div>';
	return $devolver;
}
?>