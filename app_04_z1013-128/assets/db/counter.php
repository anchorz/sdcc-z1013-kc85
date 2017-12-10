<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);


$mysqli = new mysqli("mysql23.1blu.de", "s10768_2664399", "s7bh5GmPC5ubdSxk", "db10768x2664399");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
    exit;
}

//phpinfo();
$mysqli->set_charset("utf8");
$res = $mysqli->query("INSERT INTO counter (date,ip) VALUES (NOW(),'".$_SERVER['REMOTE_ADDR']."')");    

if ($res === TRUE) {
    $count = $mysqli->insert_id;
    
    $res = $mysqli->query("SELECT * FROM counter");   
    $count = $res->num_rows;
    
    header ("Content-type: image/png");
    $font   = 4;
    $width  = ImageFontWidth($font) * strlen($count);
    $height = ImageFontHeight($font);

    $im = @imagecreate ($width,$height);
    $background_color = imagecolorallocate ($im, 255, 255, 255); //white background
    $text_color = imagecolorallocate ($im, 0, 0,0);//black text
    imagestring ($im, $font, 0, 0,  $count, $text_color);
    imagepng ($im);
}

?>
