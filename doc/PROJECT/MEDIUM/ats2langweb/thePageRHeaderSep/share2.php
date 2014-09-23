<style>
#thePageRHeaderSep
{
  color: #FFFFF0;
}

#thePageRHeaderSepL
{
  text-align: left;
  padding-left: 6px;
}

#thePageRHeaderSepL ul
{
  margin: 0px;
  padding: 0px;
  list-style-type: none;
}
#thePageRHeaderSepL ul li
{
  display: inline;
  border-width: 1px;
  border-color: #ffffff;
  border-right-style: double;
  padding-left: 2px;
  padding-right: 6px;
}

#thePageRHeaderSepL li.self
{
  font-weight: bold;
}
#thePageRHeaderSepL li.other
{
  font-weight: normal;
}

#thePageRHeaderSepL a:link
{
  color: #FFFFFF;
}
#thePageRHeaderSepL a:visited
{
  color: #7F7F7F;
}
#thePageRHeaderSepL a:hover
{
  color: #C8C8C8;
}
#thePageRHeaderSepL a:active
{
  color: #A0A0A0;
}

#thePageRHeaderSepR
{
  float: right;
}
#thePageRHeaderSepR_input
{
  height: 100%;
  font-size: 12pt;
  border-radius: 6px;
  background: #FFFFF0 url(//www.google.com/coop/intl/en/images/google_custom_search_watermark.gif) left no-repeat;
}
</style>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>

<td width="75%">
<div
id="thePageRHeaderSepL"
>
<?php thePageRHeaderSep_menu() ; ?>
</div>
</td>

<td width="25%">
<div
id="thePageRHeaderSepR"
style="margin-top:6px;margin-bottom:6px;"
>
<form
id="search-form"
action="https://www.google.com/cse"
>
<table>
<tr>
<td>
<input
id="thePageRHeaderSepR_input"
type="text" name="q" size="22"
onblur="if (/^\s*$/.test(this.value)) this.style.background='#FFFFF0 url(//www.google.com/coop/intl/en/images/google_custom_search_watermark.gif) left no-repeat'"
onfocus="this.style.background='#FFFFF0'"
/>
</td>
<td>
<input type="hidden" name="ie" value="UTF-8" />
<input type="hidden" name="cx" value="007881927213964201908:gqahxj364ly" />
<!--
<input class="button" type="submit" name="sa" value="Search" />
-->
</td>
</tr>
</table>
</form>
</div>
</td>

</tr>
</table>

<?php /* end of [share2.php] */ ?>
