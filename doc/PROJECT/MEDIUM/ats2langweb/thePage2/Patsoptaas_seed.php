<?php
$theScriptKind = 0;
if(sizeof($argv) >= 2) $theScriptKind = $argv[1];
if($theScriptKind >= 1)
{
  echo "\n";
  echo '<?php $mycode = $_REQUEST["mycode"]; ?>';
  echo "\n";
  echo '<?php $mycode_fil = $_REQUEST["mycode_fil"]; ?>';
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
(
  mycode
, mycode_fil
, mycode_url
) // Patsoptaas_thePage2_initize2
{
//
if(mycode !== '')
{
//
File_source_load
  (decodeURIComponent(mycode));
//
return;
} /* end of [if] */
//
if(mycode_fil==='hello')
{
//
File_source_load
  (Patsoptaas_File_examples_hello);
//
return;
} /* end of [if] */
//
if(mycode_fil==='fibats')
{
//
File_source_load
  (Patsoptaas_File_examples_fibats_verify);
//
return;
} /* end of [if] */
//
if(mycode_url !== '')
{
  File_loadurl_input_doWork(mycode_url); return;
} /* end of [if] */
//
return;
//
} // end of [Patsoptaas_thePage2_initize2]
//
</script>

<?php /* end of [Patsoptaas_seed.php] */ ?>
