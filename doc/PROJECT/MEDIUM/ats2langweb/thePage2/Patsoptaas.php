<?php
$theScriptKind = 0;
if(sizeof($argv) >= 2) $theScriptKind = $argv[1];
if($theScriptKind >= 1)
{
  echo "\n";
  echo '<?php $mycode = $_REQUEST["mycode"]; ?>';
  echo "\n";
  echo '<?php $mycode_url = $_REQUEST["mycode_url"]; ?>';
  echo "\n";
}
?><!--php-->

<!-- ****** ****** -->

<script>
//
function
Patsoptaas_thePage2_initize()
{
//
var
editor=
ace.edit('thePage2RBody1_prop');
//
editor.setFontSize('16px');
editor.setTheme('ace/theme/monokai');
editor.getSession().setMode('ace/mode/ats2');
editor.getSession().setValue(Patsoptaas_getWelcomeMessage());
//
Patsoptaas_thePatsopt_stderr_set("");
//
Editor_KB_select_onchange(document.getElementById('Editor_KB_select'));
//
document.getElementById('Editor-read-only').checked = false;
document.getElementById('Editor-show-gutter').checked = true;
//
document.getElementById('Patsopt-tcats-flag').checked = true;
document.getElementById('Patsopt2js-eval-flag').checked = true;
document.getElementById('Compile-stderr-flag').checked = true;
document.getElementById('Evaluate-canvas-flag').checked = false;
//
document.getElementById('File_special_select').selectedIndex = 0;
//
} // end of [Patsoptaas_thePage2_initize]
//
</script>

<!-- ****** ****** -->

<script>
//
function
Patsoptaas_thePage2_initize2
  (fname, fname_url)
{
//
if(fname==='hello')
{
//
File_examples_load
  (Patsoptaas_File_examples_hello);
//
return;
}
//
if(fname==='fibats')
{
//
File_examples_load
  (Patsoptaas_File_examples_fibats_verify);
//
return;
}
//
File_loadurl_input_doWork(fname_url);
//
} // end of [Patsoptaas_thePage2_initize2]
//
</script>

<?php /* end of [Patsoptaas.php] */ ?>
