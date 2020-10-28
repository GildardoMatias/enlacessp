<?php
/*
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS');
header("Access-Control-Allow-Headers: X-Requested-With");
header('Content-Type: text/html; charset=utf-8');
header("Content-Type: application/json; charset=UTF-8");
header('P3P: CP="IDC DSP COR CURa ADMa OUR IND PHY ONL COM STA"');

$usuario = "root";
$contrasena = ""; 
$servidor = "localhost";
$basededatos = "siegest";

$conexion = mysqli_connect( $servidor, $usuario, "" ) or die ("No se ha podido conectar al servidor de Base de datos");

$db = mysqli_select_db( $conexion, $basededatos ) or die ( "Upps! Pues va a ser que no se ha podido conectar a la base de datos" );

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        get($_REQUEST);
        break;
    case 'POST':
        Starts POST
        $raw_data = file_get_contents("php://input"); 
        //post($raw_data);
        if ($raw_data) {

            $json_data = json_decode($raw_data); 
            $curp = $json_data->curp; 
            $app = $json_data->app;
            $apm = $json_data->apm;
            $nom = $json_data->nom;
            
            $sql = 'insert into vatos values (1,"'.$nom.'","'.$app.'","'.$apm.'","'.$curp.'")';
    
            $resultado = $conexion->query($sql);
            
            if (!$resultado) {
                echo json_encode(Array("Error "=>"BD, no query executed"));
            } else 
            //echo json_encode(array("curp_r" => $curp, "nombre_rec"=>$nom, "app_rec"=>$app));
            echo json_encode (Array("Datos"=>"php input"));
        } else if($_REQUEST) {
            $curp = $_REQUEST["curp"];
            $app = $_REQUEST["app"];
            $apm = $_REQUEST["apm"];
            $nom = $_REQUEST["nom"];
            
            $sql = 'insert into vatos values ("1","'.$nom.'","'.$app.'","'.$apm.'","'.$curp.'")';

            $resultado = $conexion->query($sql);
            
            if (!$resultado) {
                echo json_encode(Array("Error "=>"BD, no query executed"));
            } else { echo json_encode (Array("Datos"=>"_REQUEST")); } 
            
        } else {
            
            echo json_encode(array("response" => "No data"));
        }
        
        break;
        //Ends POST
}

function get($params)
{
    if ($params) {
        $dispositivo = $params["dispositivo"];
        
    } else {
    }
}

function post($params)
{
    //include_once 'config.php';
    
}*/

/*

two channels
    one -> tries to reach server, if so, sends data as post
                                    else sends data to file, calls service
                                            servicé
                                            while there's no internet, persists, 
                                            send datas

*/

/*Loop directories
username post 
make a main function write ilogic words, until its the hour to static go to hell fom header_register_callback
i wanna go to road to run, feel the wind, feel the fast
<thead>
<big>
what to do
- compile a final version of the <applet></applet>
- send a json file to the server, and images
- if response ok, delete files, if not, continue

- In server 
- Rad json and print resut -> ok -> Not list files in directory for now
- create a database similar to the cpanel one 
- after read and print data, insert it into database
- if query ok, delete json file, if not, continue
</big>
generate try to function var let val String int boolean bool transliterator_create_from_rules
print french ghia paige, thy 
</thead>

Extras
-DONE->Register firebase app  */

$directorio = 'uploads';
$ficheros1  = scandir($directorio,"json");



$strJsonFileContents = file_get_contents("uploads/json.json");
// Convert to array 
$array = json_decode($strJsonFileContents, true);
var_dump($array); 
foreach ($array as $benef){
    echo "<br>".$benef["curp"];
    

    $curp = file_get_contents("http://www.webservice.com?curp=".$benef["curp"]);
    $datosCurp = json_decode($curp);
    foreach($datosCurp as $dato){
        echo "<br>".$dato["nombre"];
        echo "<br>".$dato["apelido_paterno"];
        echo "<br>".$dato["apellido_materno"];
    }

    echo "<br>".$benef["fecha_nacimiento"];
    echo "<br>".$benef["codigo_postal"];
}

?>