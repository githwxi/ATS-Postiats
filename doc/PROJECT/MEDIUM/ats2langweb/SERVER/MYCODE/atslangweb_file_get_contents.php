<?php

$fname = $_REQUEST["fname"];
$fname2 = parse_url($fname);
//
if(!$fname2['scheme'])
{
  $fname = "http://www.ats-lang.org/$fname";
}
//
$contents = file_get_contents($fname);
//
if($contents)
{
  echo $contents;
} else {
  echo "ERROR(atslangweb): file_get_contents($fname) failed!";
} // end of [if]

?>
