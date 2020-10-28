<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS');
header("Access-Control-Allow-Headers: X-Requested-With");
header('Content-Type: text/html; charset=utf-8');
header('P3P: CP="IDC DSP COR CURa ADMa OUR IND PHY ONL COM STA"');

/*class Datos {

private $data = ["prueba"=>["10.100","21.122"]];

public function __construct(){

}

public function addData($id,$lat,$long){
    $coords = array("latitud"=>$lat,"longitud"=>long);
    $this->data[$id]=$coords;
}

public function getData(){
    return $this->data;
}

}*/
$data = ["prueba"=>["10.100","21.122"]];
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $input = (array) json_decode(file_get_contents('php://input'), TRUE);
    

    $coords = array("latitud"=>$input['latitud'],"longitud"=>$input['longitud']);
    
    $GLOBALS['data'][$input['id']] = $coords;
    
    //best way echo ("Recibido" . $input['latitud'] . " " . $input['longitud']);
    echo json_encode($GLOBALS['data']);
    
} else if ($_SERVER['REQUEST_METHOD'] == 'GET') { 
     
    echo json_encode( $GLOBALS['data']);
    
}

?>