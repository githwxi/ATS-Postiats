<?php

function
thePageLeft_menu()
{
//
  thePageLeft_menuitem('Home');
  thePageLeft_menuitem('Downloads');
  thePageLeft_menuitem('Documents');
  thePageLeft_menuitem('Libraries');
  thePageLeft_menuitem('Community');
  thePageLeft_menuitem('Papers');
  thePageLeft_menuitem('Examples');
  thePageLeft_menuitem('Resources');
  thePageLeft_menuitem('Implements');
  echo "<tr><td><a href=\"https://sourceforge.net/projects/ats-lang/lists/ats-lang-users\">Mailing-list</a></td></tr>\n";
  echo "<tr><td><a href=\"https://groups.google.com/forum/#!forum/ats-lang-users\">ats-lang-users</a></td></tr>\n";
  echo "<tr><td><a href=\"https://groups.google.com/forum/#!forum/ats-lang-devel\">ats-lang-devel</a></td></tr>\n";
  echo "<tr><td><a href=\"#\" onclick=\"Home_tryatsnow_onclick()\">Try ATS on-line</td></tr>\n";
//
  return;
//
} /* end of [thePageLeft_menu] */

function
thePageLeft_menuitem($name)
{
//
  $name2 = $name;
//
  if($name==='Home')
  {
    $name2 =
    $name2 . '(<a href="http://ats-lang.sourceforge.net">old</a>)';
  }
//
  if(atslangweb_get_pgname()===$name)
  {
    echo "<tr><td name=\"$name\" class=\"self\">$name2</td></tr>\n";
  } else {
    echo "<tr><td name=\"$name\" class=\"other\"><a href=\"$name.html\">$name2</a></td></tr>\n";
  }
//
  return;
//
} /* end of [thePageLeft_menuitem] */

?>

<?php /* end of [share.php] */ ?>
