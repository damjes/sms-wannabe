<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Password Hash</title>
</head>
<body>
<?php

$pieprz = "3QrNmfyfdx9Cnqqs";

if(!empty($_POST['haslo'])) {
	$haslo = $_POST['haslo'];
	$haslo_hash = password_hash($haslo.$pieprz, PASSWORD_DEFAULT);
	echo "<div class=\"komunikat\">".$haslo_hash."</div>";
}

?>

	<form action="password-hash.php" method="POST">
		<label for="haslo">Hasło:</label>
		<input type="input" name="haslo" id="haslo">
		<input type="submit" value="Hashuj">

</body>
</html>