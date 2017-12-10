<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="de" xml:lang="de">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon" />
  <link rel="icon" href="./favicon.ico" type="image/x-icon" />
  <meta name="description" content="Z1013 Software-Datenbank: Liste aller bekannten Dateien" />
  <meta name="keywords" lang="de" content="U880, Z80, Z1013, software, download, datenbank, rom, programme, spiele" />
  <meta name="keywords" lang="en" content="U880, Z80, Z1013, software, download, database, rom, programs, games" />
  <link rel="stylesheet" type="text/css" href="result.css" />

<title>Z1013 Software-Datenbank Statistik</title>
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
$month=11;
$year=2017;
$day=29;

$days=32;
echo "<tr>\n";

$datetime = new DateTime(sprintf("%d-%d-%d",$year,$month,$day));

for ($x=0; $x<$days; $x++) {

    $res = $mysqli->query("SELECT * FROM counter WHERE DATE(date) BETWEEN '".$datetime->format("Y-m-d")."' AND '".$datetime->format("Y-m-d")."'");   
    $num_rows = $res->num_rows;
    
    echo "<td><img src=\"../img/1x1.png\" width=\"24\" height=\"".($num_rows*15)."\" alt=\"Besucher\"/><br/>".$num_rows."</td>\n";
    $datetime->modify('+1 day');
}
echo "</tr>\n";

$datetime = new DateTime(sprintf("%d-%d-%d",$year,$month,$day));
echo "<tr>\n";
for ($x=0; $x<$days; $x++) {
    echo "<td>".$datetime->format("m")."<br/>".$datetime->format("d")."</td>\n";
    $datetime->modify('+1 day');
}
echo "</tr>\n";

?></table></div>
</body>
</html>
