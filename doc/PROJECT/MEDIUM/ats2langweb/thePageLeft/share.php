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
  thePageLeft_menuitem('Implementations');
  echo "<tr><td><a href=\"https://lists.sourceforge.net/lists/listinfo/ats-lang-users\">Mailing-list</a></td></tr>\n";
  echo "<tr><td>IRC-channel</td></tr>\n";
  echo "<tr><td>Google-groups</td></tr>\n";
  echo "<tr><td><a href=\"#\" onclick=\"Home_tryatsnow_onclick()\">Try ATS on-line</input></td></tr>\n";
//
  return;
//
} /* end of [thePageLeft_menu] */

function
thePageLeft_menuitem($name)
{
//
  if(atslangweb_get_pgname()===$name)
  {
    echo "<tr><td name=\"$name\" class=\"self\">$name</td></tr>\n";
  } else {
    echo "<tr><td name=\"$name\" class=\"other\"><a href=\"$name.html\">$name</a></td></tr>\n";
  }
//
  return;
//
} /* end of [thePageLeft_menuitem] */

?>

<?php /* end of [share.php] */ ?>
