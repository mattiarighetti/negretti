<!DOCTYPE html>
<html> 
  <head>
    <meta name="author" content="Mattia Righetti (mattiarighe@me.com)" />
    <title>@page_title;noquote@ &rsaquo; Negretti Arreda, Mantova</title>
    <script language="JavaScript" src="header.js"></script>
  </head>
  <body onload="document.getElementById('ricerca').focus()">
    
    <!-- Breadcrumbs (ossia context) -->
    <br>
    <div id="context">
      <ol id="sezione">
	<li class="home"><a href="/negretti/">Home</a></li>
	<li>@page_title;noquote@</li>
      </ol>
    </div>
    <br>

    <h1>Elenco marche</h1>

    <!-- Tabella laterale dei filtri & della ricerca + tabella tcl -->
    <table class="tabella"> 
      <tr> 	 
	<td class="list-filter-pane" width="100%" valign="top">
	  <form action="@base_url@">	 
	    <table width="100%">
	      <tr class="ricerca">
		<td colspan="2" class="list-filter-header">
		  <img src="images/search-green.gif" width="20" height="20" />Ricerca
		</td>
	      </tr>
	      <tr>
		<td>
		  <input class="input" type="text" value="@q;noquote@" name="q" id="ricerca" />
		</td>
	      </tr>
	      <tr>
		<listfilters name="marca"></listfilters>
		<td class="list-list-pane" valign="top">
		  <listtemplate name="marca"></listtemplate>
		</td>
	      </tr>
	    </table>
	  </form>
	</td>
      </tr>
    </table><br><br><br>
  </body>
</html>
