<?php
//Send utf-8 header before any output
header('Content-Type: text/html; charset=utf-8'); 
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Dental Practice Patient List</title>
	</head>	
	<body>
		<h4>Select PPSN, patient_Name, patient_Address, patient_Phone, patient_EMail, patient_Profile, xray_path from patient</h4>
		<table border="1">		
			<tr>
				<td><h2>PPSN</h2></td>
				<td><h2>patient_Name</h2></td>
				<td><h2>patient_Address</h2></td>
				<td><h2>patient_Phone</h2></td>
				<td><h2>patient_EMail</h2></td>
				<td><h2>last_update</h2></td>
				<td><h2>patient_Profile</h2></td>
				<td><h2>xray_pathfrom</h2></td>				
			</tr>
			<?php			
				$host = "localhost";
				$user = "root";
				$password = "";
				$database = "db_project";				
				
				$query = "Select PPSN, patient_Name, patient_Address, patient_Phone, patient_EMail, patient_Profile, xray_path, last_update from patient";
				//Connect to the database
				$connect = mysqli_connect($host,$user,$password,$database) or die("Problem connecting.");
				//Set connection to UTF-8
				mysqli_query($connect,"SET NAMES utf8");
				//Select data
				$result = mysqli_query($connect,$query) or die("Bad Query.");
				mysqli_close($connect);

				while($row = $result->fetch_array())
				{		
					echo "<tr>";
					echo "<td><h2>" .$row['PPSN'] . "</h2></td>";
					echo "<td><h2>" .$row['patient_Name'] . "</h2></td>";
					echo "<td><h2>" .$row['patient_Address'] . "</h2></td>";
					echo "<td><h2>" .$row['patient_Phone'] . "</h2></td>";
					echo "<td><h2>" .$row['patient_EMail'] . "</h2></td>";
					echo "<td><h2>" .$row['last_update'] . "</h2></td>";
					echo "<td><h2><img src=patientImgs.php?PPSN=".$row['PPSN']." width=80 height=80/></h2></td>";
					echo "<td><h2><img src=HTTP://".$host.$row['xray_path'] . " width=60 height=60/></h2></td>";
				    echo "</tr>";
				}
			?>
		<table>
	</body>
</html>