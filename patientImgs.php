<?php
    $var = mysqli_connect("localhost", "root", "");
    mysqli_select_db($var, "db_project") or die(mysqli_error());
	$image_PPSN = $_GET['PPSN'];
    $sql = "Select patient_Profile from patient where PPSN=$image_PPSN" ;
    $resultset = mysqli_query($var, "$sql") or die("Invalid query: " . mysqli_error());
	$row = mysqli_fetch_array($resultset);
	header('Content-type: image/jpeg');
	echo $row[0];
   	mysqli_close($var);
?>

