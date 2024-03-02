<?php

$db_server = "localhost";
$db_user = "root";
$db_pass = "";
$db_name = "Project";
$port = null;
$conn = null;

$conn = mysqli_connect($db_server, $db_user, $db_pass, $db_name, $port);

if ($conn) {
    echo "You are connected";
} else {
    echo "Could not connect: " . mysqli_connect_error();
}

?>