<html>
<head>
<title>Hongwei's Functional Service - Order Results</title>
</head>
<body>

<!--
<h1>PHP Info</h1>
<?php phpinfo() ?>
-->

<?php
//
require './libatscc2php_all.php';
//
include './DATS_PHP/fact_dats.php';
include './DATS_PHP/fibats_dats.php';
include './DATS_PHP/acker_dats.php';
//
?>

<h1>Hongwei's Functional Service</h1>
<h2>Order Results</h2>
<?php

$fact_arg = intval($_REQUEST["fact_arg"]);
$fibats_arg = intval($_REQUEST["fibats_arg"]);
$acker_arg1 = intval($_REQUEST["acker_arg1"]);
$acker_arg2 = intval($_REQUEST["acker_arg2"]);
//
echo "<p>Your order has been fulfilled as follows:";
echo "<br>";
echo "<br>";
//
echo "fact($fact_arg) = ", fact($fact_arg);
echo "<br>";
echo "<br>";
//
echo "fibats($fibats_arg) = ", fibats($fibats_arg);
echo "<br>";
echo "<br>";
//
echo "acker($acker_arg1, $acker_arg2) = ", acker($acker_arg1, $acker_arg2);
echo "<br>";
//
echo "<hr>";
//
echo "<p>Your order is processed at "; echo date ("H:i, F jS, Y");
echo "<br>";
//
?>

</body>
</html>
