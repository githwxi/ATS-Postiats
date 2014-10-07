<style>
#thePage2Left
{
  color: #FFFFF0;
}
</style>

<script>
//
function
Patsoptaas_Patsopt_tcats_flag()
{
  return document.getElementById("Patsopt-tcats-flag").checked;
}
//
/*
function
Patsoptaas_Patsopt_gline_flag()
{
  return document.getElementById("Patsopt-gline-flag").checked;
}
*/
//
function
Patsoptaas_Patsopt2js_eval_flag()
{
  return document.getElementById("Patsopt2js-eval-flag").checked;
}
//
function
Patsoptaas_Compile_stderr_flag()
{
  return document.getElementById("Compile-stderr-flag").checked;
}
//
</script>

<!-- ****** ****** -->

<script>
//
function
Patsoptaas_Compile_stderr_flag_onclick()
{
//
if(Patsoptaas_Compile_stderr_flag())
{
  $('#thePage2RBody1_tr').css({height:'80%'});
  $('#thePage2RBody2_prop').css({display:'block'});
  ace.edit('thePage2RBody1_prop').resize(true);
} else {
  $('#thePage2RBody1_tr').css({height:'100%'});
  $('#thePage2RBody2_prop').css( {display:'none'} );
  ace.edit('thePage2RBody1_prop').resize(true);
} // end of [if]
//
} // end of [Patsoptaas_Compile_stderr_flag_onclick()]
//
</script>

<!-- ****** ****** -->

<script>
//
function
Patsoptaas_File_examples_load
  (code)
{
  var
  select =
  document.getElementById('File_special_select');
  select.selectedIndex = 0;
  Patsoptaas_thePatsopt_source_set("");
  Patsoptaas_thePatsopt_output_set("");
  Patsoptaas_thePatsopt2js_output_set("");
  Patsoptaas_thePatsopt_editor_set(code);
}
//
function
File_examples_onchange(x0)
{
//
  var i;
//
  i = x0.selectedIndex; x0.selectedIndex = 0;
//
  switch(i)
  {
    case 1: break;
    case 2:
    Patsoptaas_File_examples_load(Patsoptaas_File_examples_hello); break;
    case 3:
    Patsoptaas_File_examples_load(Patsoptaas_File_examples_factrec); break;
    case 4:
    Patsoptaas_File_examples_load(Patsoptaas_File_examples_factiter); break;
    default: break;
  }
//
} // end of [File_examples_onchange]
//
</script>

<!-- ****** ****** -->

<script>
//
var
File_special_select_index = 0;
function
File_special_select_onchange(x0)
{
//
  var i = File_special_select_index;
  File_special_select_index = x0.selectedIndex;
//
  if(i===0)
  {
    Patsoptaas_thePatsopt_source_set(Patsoptaas_thePatsopt_editor_get());
  } // end of [if]
//
  switch(File_special_select_index)
  {
    case 0:
    Patsoptaas_thePatsopt_editor_set(Patsoptaas_thePatsopt_source_get()); break;
    case 1:
    Patsoptaas_thePatsopt_editor_set(Patsoptaas_thePatsopt_output_get()); break;
    case 2:
    Patsoptaas_thePatsopt_editor_set(Patsoptaas_thePatsopt2js_output_get()); break;
    default: break;
  } // end of [switch]
//
}
//
</script>

<!-- ****** ****** -->

<table
 width=100%
>
<tr>
<td
 height="156px"
 align="center"
>
<img src="./MYDATA/theLogo.png" alt="ATSlogo" style="height:72%"></img>
</td>
</tr>
<tr>
<td
 align="center">
<table>

<tr><td>Editor</td></tr>

<tr>
<td
 colspan="2">
<select
 id="File_examples_select"
 onchange="File_examples_onchange(this)"
><!--select-->
<option>Examples</option>
<option>Randomly</option>
<option>Hello, world</option>
<option>Factorial(rec)</option>
<option>Factorial(iter)</option>
</select> 
</td>
</tr>

<tr>
<td>
<label>Patsopt-tcats</label>
</td>
<td>
<input
 type="checkbox"
 id="Patsopt-tcats-flag"
 checked
></input>
</td>
</tr>

<!--
<tr>
<td>
<label>Patsopt-gline</label>
</td>
<td>
<input
 type="checkbox"
 id="Patsopt-gline-flag"
></input>
</td>
</tr>
-->

<tr>
<td>
<label>Patsopt2js-eval</label>
</td>
<td>
<input
 type="checkbox"
 id="Patsopt2js-eval-flag"
 checked
></input>
</td>
</tr>

<tr>
<td>
<label>Compile-stderr</label>
</td>
<td>
<input
 type="checkbox"
 id="Compile-stderr-flag"
 onclick="Patsoptaas_Compile_stderr_flag_onclick()"
 checked
></input>
</td>
</tr>

<tr>
<td
 colspan="2">
<select
 id="File_special_select"
 onchange="File_special_select_onchange(this)"
><!--select-->
<option value="Patsopt-source">Patsopt-source</option>
<option value="Patsopt-output">Patsopt-output</option>
<option value="Patsopt2js-output">Patsopt2js-output</option>
</select> 
</td>
</tr>

</table>
</td>
</tr>
</table>

<?php /* end of [Patsoptaas.php] */ ?>
