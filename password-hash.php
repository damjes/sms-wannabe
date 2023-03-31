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

if(!empty($_POST['haslo'])) {
	require_once 'db.php';
	$haslo = $_POST['haslo'];
	$haslo_hash = password_hash($haslo.$pieprz, PASSWORD_DEFAULT);

	if(empty($_POST['uzyszkodnik'])) {
		echo "<div class=\"komunikat\">".$haslo_hash."</div>";
	} else {
		$uzyszkodnik = $_POST['uzyszkodnik'];
		$uzyszkodnik = $polaczenie->escape_string($uzyszkodnik);
		$zapytanie = "UPDATE uzyszkodnik SET hasz_hasla='".$haslo_hash."' WHERE id=".$uzyszkodnik;
		$polaczenie->query($zapytanie);
		$polaczenie->close();
		echo "<div class=\"komunikat\">Hasło zostało zmienione</div>";
	}
}

?>

	<form action="password-hash.php" method="POST">
		<p>
			<label for="uzyszkodnik">ID użyszkodnika:</label>
			<input type="text" name="uzyszkodnik" id="uzyszkodnik">
		</p>
		<p>
			<label for="haslo">Hasło:</label>
			<input type="input" name="haslo" id="haslo">
		</p>
		<p>
			<input type="submit" value="Hashuj">
		</p>

</body>
</html>