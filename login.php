<?php

session_start();

$komunikat = "Niepoprawny login lub hasło";

if(!empty($_SESSION['id'])) {
	header('Location: index.php');
	exit();
}

if(!empty($_POST['login']) && !empty($_POST['haslo'])) {
	require_once 'db.php';

	$login = $polaczenie->escape_string($_POST['login']);
	$haslo = $_POST['haslo'];

	$zapytanie = "SELECT id, hasz_hasla FROM uzyszkodnik WHERE login='".$login."'";
	$wynik = $polaczenie->query($zapytanie);
	if($wynik->num_rows > 0) {
		$wiersz = $wynik->fetch_assoc();
		if(password_verify($haslo.$pieprz, $wiersz['hasz_hasla'])) {
			$_SESSION['id'] = $wiersz['id'];
			header('Location: index.php');
			$polaczenie->close();
			die();
		}
	}

	$polaczenie->close();
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Niezalogowany</title>
</head>
<body>
	<h1>Logowanie</h1>
<?php

if(!empty($komunikat)) {
	echo "<div class=\"komunikat\">".$komunikat."</div>";
}

?>
	<form action="login.php" method="POST">
		<label for="login">Login:</label>
		<input type="text" name="login" id="login">
		<label for="haslo">Hasło:</label>
		<input type="password" name="haslo" id="haslo">
		<input type="submit" value="Zaloguj">
	</form>
</body>
</html>