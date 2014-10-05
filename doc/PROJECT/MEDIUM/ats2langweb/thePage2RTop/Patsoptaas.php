<style>
#thePage2RTop
{
  color: #FFFFF0;
  background-color: rgb(143,2,34);
}

#thePage2RTopL
{
  text-align: left;
  padding-left: 2px;
}

#thePage2RTopL ul
{
  margin: 0px;
  padding: 0px;
  list-style-type: none;
}
#thePage2RTopL ul > li
{
  float: left;
/*
  display: inline;
*/
  border-width: 1px;
  border-color: #ffffff;
  border-right-style: double;
  margin-top: 6px;
  margin-bottom: 6px;
  padding-left: 10px;
  padding-right: 10px;
}

.thePage2RTopL_submenu
{
  z-index: 8;
  display: none;
  position: absolute;
  border-radius: 6px;
  background-color: rgba(143,2,34,0.625);
  padding-top: 6px;
  padding-bottom: 6px;
  padding-left: 8px;
  padding-right: 8px;
}

#thePage2RTopR
{
  background-color: #FFFFF0;
}
</style>

<script>
//
var theSubmenuTable = 0;
//
function
Patsoptaas_topmenu_mouseout(name)
{
  return;
}
//
function
Patsoptaas_topmenu_mouseover(name)
{
  var jqi;
  jqi =
  $('#thePage2RTopL>ul>li[name="'+name+'"]');
  theSubmenuTable = jqi.next('table');
  theSubmenuTable.css({display:'table'});
  theSubmenuTable.css (
    {top:jqi.position().top+jqi.outerHeight(true)}
  ) ; // end of [theSubmenuTable.css]
  theSubmenuTable.css({left:jqi.position().left});
  return;
}
//
</script>

<table
 width="100%"
 cellspacing="0" cellpadding="0">
<tr>
<td width="75%">
<div
 id="thePage2RTopL"
>
<ul>
<li
 name="File"
 onmouseout="Patsoptaas_topmenu_mouseout('File')"
 onmouseover="Patsoptaas_topmenu_mouseover('File')"
>File</li>
<table
 class="thePage2RTopL_submenu"
>
<tr><td>New File</td></tr>
<tr><td>Load File</td></tr>
<tr><td>Load Example</td></tr>
<tr><td>Patsopt-source</td></tr>
<tr><td>Patsopt-output</td></tr>
<tr><td>Patsopt2js-output</td></tr>
<tr><td>Save As...</td></tr>
</table>

<li
 name="Compile"
 onmouseout="Patsoptaas_topmenu_mouseout('Compile')"
 onmouseover="Patsoptaas_topmenu_mouseover('Compile')"
>Compile</li>
<table
 class="thePage2RTopL_submenu"
>
<tr><td>
<button
 ID="patsopt_button"
 type="button" onclick="Patsoptaas_Compile_patsopt_onclick()"
>Patsopt</button>
</td></tr>
<tr><td>
<button
 ID="patsopt2js_button"
 type="button" onclick="Patsoptaas_Compile_patsopt2js_onclick()"
>Patsopt2js</button>
</td></tr>
</table>

<li
 name="Evaluate"
 onmouseout="Patsoptaas_topmenu_mouseout('Evaluate')"
 onmouseover="Patsoptaas_topmenu_mouseover('Evaluate')"
>Evaluate</li>
<table
 class="thePage2RTopL_submenu"
>
<tr><td>
<button
 ID="patsopt_button" type="button" onclick="Patsoptaas_Evaluate_JS_onclick()"
>EvalJS</button>
</td></tr>
</table>
</ul>
</div>

<td
 width="25%"
 style="background-color:#FFFFF0">
</td>

</tr>
</table>

<?php /* end of [Patsoptaas.php] */ ?>
