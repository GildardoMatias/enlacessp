<?php
$usuario = "root";
$contrasena = ""; 
$servidor = "localhost";
$basededatos = "ssp";

$conexion = mysqli_connect( $servidor, $usuario, "" ) or die ("Error al conectar al servidor");

$db = mysqli_select_db( $conexion, $basededatos ) or die ( "Error al conectar a la bse de datos" );

?>