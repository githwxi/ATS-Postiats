<style>
#thePage2RTop
{
  color: #FFFFF0;
}

#thePage2RTopL
{
  text-align: left;
  padding-left: 6px;
}

#thePage2RTopL ul
{
  margin: 0px;
  padding: 0px;
  list-style-type: none;
}
#thePage2RTopL > ul > li
{
  float: left;
/*
  display: inline;
  border-width: 1px;
  border-color: #ffffff;
  border-right-style: double;
  padding-left: 2px;
  padding-right: 6px;
*/
}
</style>

<script>
function
Patsoptaas_patsopt_onclick()
{
  alert("Patsoptaas_patsopt_onclick()");
}
function
Patsoptaas_patsopt2js_onclick()
{
  alert("Patsoptaas_patsopt2js_onclick()");
}
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>

<td width="75%">
<div
id="thePage2RTopL"
>

<ul>

<li>
File
<ul>
<li>New File</li>
<li>Load File</li>
<li>Load Example</li>
<li>Patsopt-source</li>
<li>Patsopt-output</li>
<li>Patsopt2js-output</li>
<li>Save As...</li>
</ul>
</li>

<li>
Compile
<ul>
<li>
<button
 ID="patsopt_button"
 type="button" onclick="Patsoptaas_patsopt_onclick()"
>Patsopt</button>
</li>
<li>
<button
 ID="patsopt2js_button"
 type="button" onclick="Patsoptaas_patsopt2js_onclick()"
>Patsopt2js</button>
</li>
</ul>
</li>

<li>Evaluate</li>
</ul>

</div>
</td>

<td width="25%">
<div
id="thePage2RTopR"
style="margin-top:6px;margin-bottom:6px;"
>
</div>
</td>

</tr>
</table>

<?php /* end of [Patsopt.php] */ ?>
