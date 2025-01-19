<?php
ob_start();

$db_host="localhost"; // Host name 
$db_username="project2-ro"; // Mysql username
$db_password="1047283503fa3d4a618a3ed23f79c0a235b6695456871c5d"; // Mysql password 
$db_name="project2"; // Database name 

//mysql_connect($db_host, $db_username, $db_password) or die("Cannot connect to MySQL.");
//mysql_select_db($db_name) or die("Cannot select database.");
$link  = mysqli_connect($db_host, $db_username, $db_password, $db_name);
if (!$link){
        die("Cannot connect to MySQL");
}

$username = 'victim';
$password = '719a67994e0d14244f00cb06a9f33371';
$salted = 'a0' . $password;
$hash = md5($salted, true);
$salt = 'a0';
$query = "INSERT INTO users (username,password,passwordhash) VALUES('$username', '$password', '$hash', '$salt')";
$results = mysqli_query($query);
	
if (!$results) {
    echo "Error in MySQL query.";
} else {
    echo "Done.";
}

ob_end_flush();
?>
