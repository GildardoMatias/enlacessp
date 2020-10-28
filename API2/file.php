<?php

header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS');
header("Access-Control-Allow-Headers: X-Requested-With");
header('Content-Type: text/html; charset=utf-8');
header('P3P: CP="IDC DSP COR CURa ADMa OUR IND PHY ONL COM STA"');
  
    $file_path = "uploads/";
    if(!is_dir($file_path)){
        //Directory does not exist, so lets create it.
        mkdir($file_path, 0755, true);
    }
    
    $file_path = $file_path . basename( $_FILES['uploaded_file']['name']);
    if(move_uploaded_file($_FILES['uploaded_file']['tmp_name'], $file_path)) {
        if($_FILES['uploaded_file']['type'] == "json"){
            //Inicia inserción en base de datos
            include_once "config.php";
            $strJsonFileContents = file_get_contents("uploads/myJSONFile.json");
            // Convert to array 
            $array = json_decode($strJsonFileContents, true);
            //var_dump($array); 
                foreach ($array as $infr) {
                    $sql = "INSERT INTO infracciones (
                    folio, 
                    ciudad_evento,
                    direccion,
                    descripcion,
                    nombre_conductor,
                    primer_apellido,
                    segundo_apellido,
                    domicilio_conductor,
                    licencia,
                    numero_licencia,
                    servicio_vehiculo,
                    numero_placa,
                    marca,
                    linea,
                    modelo,
                    clase_vehiculo,
                    garantia,
                    observaciones,
                    latitud,
                    longitud)
                    VALUES (
                    '".$infr["folio"]."', 
                    '".$infr["ciudad_evento"]."', 
                    '".$infr["direccion"]."',
                    '".$infr["descripcion"]."',
                    '".$infr["nombre_conductor"]."',
                    '".$infr["primer_apellido"]."',
                    '".$infr["segundo_apellido"]."',
                    '".$infr["domicilio_conductor"]."',
                    '".$infr["licencia"]."',
                    '".$infr["numero_licencia"]."',
                    '".$infr["servicio_vehiculo"]."',
                    '".$infr["numero_placa"]."',
                    '".$infr["marca"]."',
                    '".$infr["linea"]."',
                    '".$infr["modelo"]."',
                    '".$infr["clase_vehiculo"]."',
                    '".$infr["garantia"]."',
                    '".$infr["observaciones"]."',
                    '".$infr["latitud"]."',
                    '".$infr["longitud"]."');";

                    if ($conexion->query($sql) === TRUE) {
                    echo "New record created successfully";
                    } else {
                    echo "Error: " . $sql . "<br>" . $conexion->error;
                    }

                    $conexion ->close();
                }
            //Termina inserción en base de datos
        }
        echo "success";
    } else{
        echo "fail";
    }
 ?>