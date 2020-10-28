<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS');
header("Access-Control-Allow-Headers: X-Requested-With");
header('Content-Type: text/html; charset=utf-8');
header('P3P: CP="IDC DSP COR CURa ADMa OUR IND PHY ONL COM STA"');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $input = (array) json_decode(file_get_contents('php://input'), TRUE);
    

    $coords = array("id"=>$input['id'],"latitud"=>$input['latitud'],"longitud"=>$input['longitud']);

    $fp = fopen('uploads/coordenadas'.$input['id'].'.json', 'w');
    fwrite($fp, json_encode($coords));
    fclose($fp);
    echo ("Recibido" . $input['latitud'] . " " . $input['longitud']);
    
}
