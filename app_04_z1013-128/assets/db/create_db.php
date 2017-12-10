<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="de" xml:lang="de">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon" />
  <link rel="icon" href="./favicon.ico" type="image/x-icon" />
  <meta name="description" content="Z1013 Software-Datenbank Administration" />
  <meta name="keywords" lang="de" content="U880, Z80, Z1013, software, download, datenbank, rom, programme, spiele" />
  <meta name="keywords" lang="en" content="U880, Z80, Z1013, software, download, database, rom, programs, games" />
  <link rel="stylesheet" type="text/css" href="result.css" />

<title>Z1013 Software-Datenbank Administration</title>
<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
</head>
<body>
<div><table><?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$mysqli = new mysqli("mysql23.1blu.de", "s10768_2664399", "s7bh5GmPC5ubdSxk", "db10768x2664399");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
    exit;
}
$mysqli->set_charset("utf8");

$sql="DROP TABLE IF EXISTS z1013_sw_liste";
echo "$sql<br/>";
if (!$mysqli->query($sql)) {
    printf("Error: %s\n", $mysqli->error);
    die();
} 
$sql="CREATE TABLE z1013_sw_liste (";
$sql.="md5 CHAR(32) NOT NULL UNIQUE PRIMARY KEY";
$sql.=",name CHAR(16)";
$sql.=",t CHAR(1)";
$sql.=",aadr CHAR(4)";
$sql.=",eadr CHAR(4)";
$sql.=",sadr CHAR(4)";
$sql.=",c CHAR(1)";
$sql.=",mon CHAR(3)";
$sql.=",hw CHAR(8)";
$sql.=",short TINYTEXT";
$sql.=",descr TEXT";
$sql.=",link TINYTEXT";
$sql.=")CHARACTER SET utf8 COLLATE utf8_general_ci";
echo "$sql<br/>";
if (!$mysqli->query($sql)) {
    printf("Error: %s\n", $mysqli->error);
    die();
}
$sql="INSERT INTO z1013_sw_liste VALUES(";
$sql.="'f999c7d7efa3ca730fb35bd68e35e597'";
$sql.=",'name'";
$sql.=",'t'";
$sql.=",'aaaa'";
$sql.=",'eeee'";
$sql.=",'ssss'";
$sql.=",'O'";
$sql.=",'2AB'";
$sql.=",''";
$sql.=",'short'";
$sql.=",'long'";
$sql.=",'lnk'";
$sql.=")";
echo "$sql<br/>";
if (!$mysqli->query($sql)) {
    printf("Error: %s\n", $mysqli->error);
    die();
}

echo "ok";  
?></table></div>
</body>
</html>
