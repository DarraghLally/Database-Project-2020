<?php
//Send utf-8 header before any output
header('Content-Type: text/html; charset=utf-8'); 
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Dental Practice Patient 0900 Appointments</title>
	</head>	
	<body>
		<h4>Select p.PPSN, p.patient_Name,  p.patient_Phone, a.appointment_Date from patient p inner join appointment a on p.PPSN = a.PPSN where a.appointment_Time = '0900'</h4>
		<table border="1">		
			<tr>
				<td><h2>p.PPSN</h2></td>
				<td><h2>p.patient_Name</h2></td>
				<td><h2>p.patient_Phone</h2></td>
				<td><h2>a.appointment_Date</h2></td>
			</tr>
			<?php			
				$host = "localhost";
				$user = "root";
				$password = "";
				$database = "db_project";				
				
				$query = "Select p.PPSN, p.patient_Name,  p.patient_Phone, a.appointment_Date from patient p inner join appointment a on p.PPSN = a.PPSN where a.appointment_Time = '0900'";
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
					echo "<td><h2>" .$row['p.PPSN'] . "</h2></td>";
					echo "<td><h2>" .$row['p.patient_Name'] . "</h2></td>";
					echo "<td><h2>" .$row['p.patient_Phone'] . "</h2></td>";
					echo "<td><h2>" .$row['a.appointment_Date'] . "</h2></td>";
				}
			?>
		<table>
	</body>
</html>