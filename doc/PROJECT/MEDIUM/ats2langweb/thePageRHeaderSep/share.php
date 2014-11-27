<?php

function
thePageRHeaderSep_menu()
{
//
  echo "<ul>\n";
//
  thePageRHeaderSep_menuitem('Home');
  thePageRHeaderSep_submenu_for_Home('Home');
//
  thePageRHeaderSep_menuitem('Downloads');
  thePageRHeaderSep_submenu_for_Downloads('Downloads');
//
  thePageRHeaderSep_menuitem('Documents');
  thePageRHeaderSep_submenu_for_Documents('Documents');
//
  thePageRHeaderSep_menuitem('Libraries');
  thePageRHeaderSep_menuitem('Community');
//
  echo "</ul>\n";
//
  return;
//
} /* end of [thePageRHeaderSep_menu] */

function
thePageRHeaderSep_menuitem($name)
{
//
  $onmouseout = "onmouseout=\"submenu_mouseout()\"";
  $onmouseover = "onmouseover=\"submenu_mouseover('$name')\"";
//
  if(atslangweb__get_pgname()===$name)
  {
    echo "<li name=\"$name\" class=\"self\" $onmouseover $onmouseout>$name</li>\n";
  } else {
    echo "<li name=\"$name\" class=\"other\" $onmouseover $onmouseout><a href=\"$name.html\">$name</a></li>\n";
  }
//
  return;
//
} /* end of [thePageRHeaderSep_menuitem] */

/* ****** ****** */

function
thePageRHeaderSep_submenu_for_Home($name)
{
  $page = "";
  if(atslangweb__get_pgname()!=$name) $page = "$name.html";
  $onmouseout = "onmouseout=\"submenu_table_mouseout()\"";
  $onmouseover = "onmouseover=\"submenu_table_mouseover()\"";
  echo "<table class=\"thePageRHeaderSepL_submenu\" $onmouseover $onmouseout>\n";
  echo "<tr><td><a href=\"$page#What_is_ATS\">What is ATS?<a></td></tr>\n";
  echo "<tr><td><a href=\"$page#What_is_ATS_good_for\">What is ATS good for?<a></td></tr>\n";
  echo "<tr><td><a href=\"$page#Acknowledgments\">Acknowledgments</a></td></tr>\n";
  echo "</table>\n";
  return;
} /* end of [thePageRBodyLHeader_Home] */

function
thePageRHeaderSep_submenu_for_Downloads($name)
{
  $page = "";
  if(atslangweb__get_pgname()!=$name) $page = "$name.html";
  $onmouseout = "onmouseout=\"submenu_table_mouseout()\"";
  $onmouseover = "onmouseover=\"submenu_table_mouseover()\"";
  echo "<table class=\"thePageRHeaderSepL_submenu\" $onmouseover $onmouseout>\n";
  echo "<tr><td><a href=\"$page#ATS_packages\">ATS packages for download</a></td></tr>\n";
  echo "<tr><td><a href=\"$page#Requirements_install\">Requirements for installation</a></td></tr>\n";
  echo "<tr><td><a href=\"$page#Precompiledpack_install\">Precompiled packages for installation</a></td></tr>\n";
  echo "<tr><td><a href=\"$page#Install_source_compile\">Installation through source compilation</a></td></tr>\n";
  echo "<tr><td><a href=\"$page#Install_of_ATS2_contrib\">Installation of ATS2-contrib</a></td></tr>\n";
  echo "<tr><td><a href=\"$page#Install_of_ATS2_include\">Installation of ATS2-include</a></td></tr>\n";
  echo "</table>\n";
  return;
} /* end of [thePageRBodyLHeader_Downloads] */

function
thePageRHeaderSep_submenu_for_Documents($name)
{
  $page = "";
  if(atslangweb__get_pgname()!=$name) $page = "$name.html";
  $onmouseout = "onmouseout=\"submenu_table_mouseout()\"";
  $onmouseover = "onmouseover=\"submenu_table_mouseover()\"";
  echo "<table class=\"thePageRHeaderSepL_submenu\" $onmouseover $onmouseout>\n";
  echo "<tr><td><a href=\"$page#INT2PROGINATS\">Introduction to Programming in ATS</a></td></tr>\n";
  echo "<tr><td><a href=\"$page#TUT2PROGINATS\">A Tutorial on Programming Features in ATS</a></td></tr>\n";
  echo "</table>\n";
  return;
} /* end of [thePageRBodyLHeader_Documents] */

?>

<?php /* end of [share.php] */ ?>
