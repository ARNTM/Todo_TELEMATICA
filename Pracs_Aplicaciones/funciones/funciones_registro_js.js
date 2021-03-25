// JavaScript Document

$('#password, #confirm_password').on('keyup', function () {
		if ($('#password').val() == $('#confirm_password').val()) {
			$('#notmatch').hide();
			comprobarBoton();
		} else 
			$('#notmatch').show().html('Las contraseñas no coindicen').css("text-align", "center");
			comprobarBoton();
			});

function comprobarUsuario() {
	'use strict';
	var auth = "7jiUFNfUIS6jPYseT8vv";
	var funcion = "comprobarUsuario";
	
	if($("#username").val().length > 0){
		$("#loaderUser").show();
		
		jQuery.ajax({
		url: "funciones/funciones_registro_ajax.php",
		data:"funcion="+funcion+"&auth="+auth+'&username='+$("#username").val(),
		type: "POST",
		success:function(data){
			console.log(data);
			if(data!='SI'){
				$("#usernotavailable").show().html(data);
				$("#loaderUser").hide();
				comprobarBoton();
			}
			else{
				$("#usernotavailable").hide();
				$("#loaderUser").hide();
				comprobarBoton();
			}
		},
		error:function (){}
		});
	}
}

function comprobarEmail() {
	'use strict';
	var auth = "7jiUFNfUIS6jPYseT8vv";
	var funcion = "comprobarMail";
	
	if($("#mail").val().length > 0){
		$("#loaderMail").show();
		
		jQuery.ajax({
		url: "funciones/funciones_registro_ajax.php",
		data:"funcion="+funcion+"&auth="+auth+'&mail='+$("#mail").val(),
		type: "POST",
		success:function(data){
			if(data!='SI'){
				$("#mailnotavailable").show().html(data);
				$("#loaderMail").hide();
				comprobarBoton();
			}
			else{
				$("#mailnotavailable").hide();
				$("#loaderMail").hide();
				comprobarBoton();
			}
		},
		error:function (){}
		});
	}
}

function comprobarBoton() {
	'use strict';
	if($("#mailnotavailable").is(':hidden') && $("#usernotavailable").is(':hidden') && $("#notmatch").is(':hidden')){
		$("#registrar").attr("disabled", false);
	}
	else {
		$("#registrar").attr("disabled", true);
	}
}