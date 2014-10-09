<?php

$fname = $_REQUEST["fname"];
$fname = "http://www.ats-lang.org";
$contents = file_get_contents($fname);
if($contents)
{
  echo $contents;
} else {
  echo "ERROR(atslangweb): file_get_contents($fname) failed!";
} // end of [if]

?>
