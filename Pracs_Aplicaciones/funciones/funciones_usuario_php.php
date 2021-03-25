<?php

function getUserCard(){
	$devolver = '
	<section class="card">
	<div class="card-body">
		<div class="thumb-info mb-3">
			<img src="'.$_SESSION['foto'].'" class="rounded img-fluid" alt="'.$_SESSION['nombre'].'">
			<div class="thumb-info-title">
				<span class="thumb-info-inner">'.$_SESSION['nombre'].'</span>
				<span class="thumb-info-type">'.$_SESSION['ocupacion'].'</span>
				
			</div>
		</div>

			<hr class="dotted short">

		</div>
	</section>';
	return $devolver;
}
function getTablaUsuario($id){
	$devolver='<div class="col-lg-8 col-xl-9 mb-8 mb-xl-12">

					<div class="tabs">
						<ul class="nav nav-tabs tabs-primary">
							<li class="nav-item active">
								<a class="nav-link" href="#recomendaciones" data-toggle="tab">Recomendaciones</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="#editar" data-toggle="tab">Editar perfil</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="#pic" data-toggle="tab">Cambiar fotografía</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="#pass" data-toggle="tab">Cambiar contraseña</a>
							</li>
						</ul>
						<div class="tab-content">
							<div id="recomendaciones" class="tab-pane active">

								

									<h4 class="mb-3"><strong>Recomendaciones</strong></h4>

									<section class="simple-compose-box mb-3">


									</section>
									<a class="mb-1 mt-1 mr-1 modal-basic btn btn-danger" id="#modalrecomendar" onclick="recomendarPeliculas();" href="#recs">Recomiéndame</a>
										<div id="recs" class="modal-block modal-full-color modal-block-danger mfp-hide">
											<section class="card">
												<header class="card-header">
													<h2 class="card-title">Buscando tu próxima película</h2>
												</header>
												<div class="card-body">
													<div class="modal-wrapper">
														<div class="modal-icon">
														<i class="fas fa-tv"></i>
														</div>
														<div class="modal-text">
														<h4>Ve cogiendo la manta y las palomitas mientras nosotros te recomendamos tu próxima película. Este proceso puede tardar un minuto</h4><br>
															<div class="spinner-border" role="status">
															  <span class="sr-only">Loading...</span>
															</div>
														</div>
													</div>
												</div>
												<footer class="card-footer">
													<button style="display:none;" class="modal-dismiss"></button>
												</footer>
											</section>
										</div>
									<a id="ver_rec" class="simple-ajax-modal btn btn-default"  href="peliculas_recomendadas.php">Ver peliculas recomendadas</a>
								

							</div>

							<div id="pass" class="tab-pane">
								<h4 class="mb-3"><strong>Cambiar contraseña del usuario</strong></h4>

								<section class="simple-compose-box mb-3"></section>
								
								<form action="procesar_perfil.php" method="post">
								<input type="hidden" name="pqwomcht" id="pqwomcht">
								<div class="form-group">
									<div class="col-sm-12 mb-12">
										<label>Contraseña actual</label>
										<input name="password_actual" type="password" id="password_actual" autocomplete="password" class="form-control form-control-lg" minlength="8" required/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12 mb-12">
										<label>Nueva contraseña</label>
										<input name="password" type="password" id="password" autocomplete="new-password" class="form-control form-control-lg" minlength="8" required/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12 mb-12">
										<label>Confirmar contraseña</label>
										<input name="pwd_confirm" id="pwd_confirm" type="password" autocomplete="new-password" id="confirm_password" class="form-control form-control-lg" minlength="8" required/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12 text-left">
										<button type="submit" id="cambiarpass" class="btn btn-primary mt-2" >Cambiar contraseña</button>
									</div>
								</div>
							</form>
						</div>

						<div id="pic" class="tab-pane">
							<h4 class="mb-3"><strong>Actualizar foto de perfil</strong></h4>

							<section class="simple-compose-box mb-3"></section>
							<form action="procesar_perfil.php" method="post" enctype="multipart/form-data">
							<input type="hidden" name="qmguryzx" id="qmguryzx">
							<div class="form-group">
								<div class="col-sm-12 mb-12">
									<label>Foto</label>
									<input name="foto" id="foto" type="file" accept="image/png,image/jpg,image/jpeg" class="form-control-file" required/>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
								</div>
								<div class="col-sm-4 text-left">
									<button type="submit" id="cambiarfoto" class="btn btn-primary mt-2" >Cambiar fotografía</button>
								</div><br>
							</div>
						</form>
							<h4 class="mb-3"><strong>Borrar foto de perfil</strong></h4>

							<section class="simple-compose-box mb-3"></section>
							<form action="procesar_perfil.php" method="post">
								<input type="hidden" name="aqionqdo" id="aqionqdo">
								<div class="col-sm-4 text-left">
									<button type="submit" id="borrarfoto" class="btn btn-primary mt-2" >Borrar foto de perfil</button>
								</div><br>
							</form>
					</div>

					<div id="editar" class="tab-pane">
						<h4 class="mb-3"><strong>Editar usuario</strong></h4>

						<section class="simple-compose-box mb-3"></section>
						<form action="procesar_perfil.php" method="post">
							<input type="hidden" name="amncheor" id="amncheor">
							<div class="form-group">
								<div class="row">
									<div class="col-sm-6 mb-3">
										<label>Nombre</label>
										<input name="nombre" id="nombre" value="'.$_SESSION['nombre'].'"  type="text" class="form-control form-control-lg" required/>
									</div>
									<div class="col-sm-6 mb-3">
										<label>Edad</label>
										<input name="edad" id="edad" value="'.$_SESSION['edad'].'"  type="text" class="form-control form-control-lg" required/>
									</div>									
								</div>
							</div>
							<div class="form-group">
								<div class="row">
									<div class="col-sm-6 mb-3">
										<label>Sexo</label>
										<select class="form-control" id="sexo" name="sexo" required>';
											if($_SESSION['sexo']=='M') $devolver.='<option selected value="M">Hombre</option> <option value="F">Mujer</option>';
											else $devolver.='<option selected value="F">Mujer</option><option value="M">Hombre</option>';
											$devolver.='</select>
									</div>	

							<div class="col-sm-6 mb-3">
								
								<label>Ocupación</label>
									<select class="form-control" id="ocupacion" name="ocupacion" required>
									  <option'; if($_SESSION['ocupacion']=='artist') $devolver.=' selected'; $devolver.=' value="artist">Artist</option>
									  <option'; if($_SESSION['ocupacion']=='doctor') $devolver.=' selected'; $devolver.=' value="doctor">Doctor</option>
									  <option'; if($_SESSION['ocupacion']=='educator') $devolver.=' selected'; $devolver.=' value="educator">Educator</option>
									  <option'; if($_SESSION['ocupacion']=='engineer') $devolver.=' selected'; $devolver.=' value="engineer">Engineer</option>
									  <option'; if($_SESSION['ocupacion']=='entertaiment') $devolver.=' selected'; $devolver.=' value="entertainment">Entertainment</option>
									  <option'; if($_SESSION['ocupacion']=='executive') $devolver.=' selected'; $devolver.=' value="executive">Executive</option>
									  <option'; if($_SESSION['ocupacion']=='healthcare') $devolver.=' selected'; $devolver.=' value="healthcare">Healthcare</option>
									  <option'; if($_SESSION['ocupacion']=='homemaker') $devolver.=' selected'; $devolver.=' value="homemaker">Homemaker</option>
									  <option'; if($_SESSION['ocupacion']=='lawyer') $devolver.=' selected'; $devolver.=' value="lawyer">Lawyer</option>
									  <option'; if($_SESSION['ocupacion']=='librarian') $devolver.=' selected'; $devolver.=' value="librarian">Librarian</option>
									  <option'; if($_SESSION['ocupacion']=='marketing') $devolver.=' selected'; $devolver.=' value="marketing">Marketing</option>
									  <option'; if($_SESSION['ocupacion']=='programmer') $devolver.=' selected'; $devolver.=' value="programmer">Programmer</option>
									  <option'; if($_SESSION['ocupacion']=='retired') $devolver.=' selected'; $devolver.=' value="retired"> Retired</option>
									  <option'; if($_SESSION['ocupacion']=='salesman') $devolver.=' selected'; $devolver.=' value="salesman">Salesman</option>
									  <option'; if($_SESSION['ocupacion']=='scientist') $devolver.=' selected'; $devolver.=' value="scientist">Scientist</option>
									  <option'; if($_SESSION['ocupacion']=='student') $devolver.=' selected'; $devolver.=' value="student">Student</option>
									  <option'; if($_SESSION['ocupacion']=='technician') $devolver.=' selected'; $devolver.=' value="technician">Technician</option>
									  <option'; if($_SESSION['ocupacion']=='writer') $devolver.=' selected'; $devolver.=' value="writer">Writer</option>
									  <option'; if($_SESSION['ocupacion']=='none') $devolver.=' selected'; $devolver.=' value="none">None</option>
									  <option'; if($_SESSION['ocupacion']=='other') $devolver.=' selected'; $devolver.=' value="other">Other</option>
									</select>
								  
							</div>								
						</div>
					</div>


					<div class="form-group mb-3">
						<label>Contraseña actual</label>
						<input name="password_actual" type="password" id="password_actual" autocomplete="new-password" class="form-control form-control-lg" minlength="4" required/>
					</div>

					<div class="form-group mb-3">
						<div class="col-sm-12 text-left">
							<button type="submit" id="editar" class="btn btn-primary mt-2">Editar</button>
						</div>
					</div>
				</form>
				</div>



						</div>
					</div>
				</div>';
	return $devolver;
}
?>