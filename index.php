<?php

session_start();

if(empty($_SESSION['id'])) {
	header('Location: login.php');
	exit();
}

$id = $_SESSION['id'];

require_once 'db.php';

?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>SMS Wannabe</title>
	<link rel="stylesheet" href="styl.css">
</head>
<body>
	<div class="kontener">
		<h1>SMS Wannabe</h1>
		<h2>Napisz wiadomość</h2>
		<form action="" method="POST"></form>
		<h2>Wiadomości:</h2>
<?php

$zapytanie = "SELECT * FROM w_obie_z_loginem WHERE od=".$id." ORDER BY timestamp DESC";
$wynik = $polaczenie->query($zapytanie);
if($wynik->num_rows > 0) {
	while($wiersz = $wynik->fetch_assoc()) {
		echo "<div class=\"wiadomosc\">";
		echo "<div class=\"naglowek\">";
		echo "<div class=\"lewe\">";
		echo $wiersz['kierunek'] . $wiersz['do_login'];
		echo "</div>";
		echo "<div class=\"prawe\">";
		echo $wiersz['timestamp'];
		echo "</div>";
		echo "<div class=\"tresc\">";
		echo $wiersz['tresc'];
		echo "</div>";
		echo "</div>";
	}
} else {
	echo "<div class=\"komunikat\">Brak wiadomości</div>";
}

mysqli_close($polaczenie);

?>
		<a href="logout.php">Wyloguj</a>
	</div>
</body>
</html>