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

if (isset($_POST['username']) and isset($_POST['password'])) {
    $uid = $_POST['uid'];	
    $username = mysqli_real_escape_string($link ,$_POST['username']);
    $squery = "SELECT salt FROM users WHERE username='$username'";
    $sresults = mysqli_query($link, $squery);
    if(!$sresults) {
	    echo "Error in MySQL query.";
    } elseif(mysqli_num_rows($sresults) > 0) {
	    $row = mysqli_fetch_assoc($sresults);
	    $salt = $row['salt'];
	    
	    $saltedpass = $salt . $_POST['password'];
	    $passwordhash = md5($saltedpass, true);

            $query = "SELECT * FROM users WHERE username='$username' and passwordhash='$passwordhash'";
    	    $results = mysqli_query($link, $query);
	
            if (!$results) {
        	echo "Error in MySQL query.";
    	    } elseif (mysqli_num_rows($results) > 0) {
        	echo "<h1>Login successful! (" . htmlspecialchars($username) . ")</h1>";
		if ($username == "victim") {
			$uuid = $uid . '2';
           		$uid_hash = hash('sha256', $uuid);
           		echo "<p><b>Submit the following line as your solution:</b><br>";
           		echo $uid_hash;
		}
    		} else {
        		echo "Incorrect username or password.";
    		}
	} else {
    		echo "Invalid submission.";
	}
}
ob_end_flush();
?>
