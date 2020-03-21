<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta name="author" content="Mattia Righetti (mattiarighe@me.com)">
    <title>Inventario - Negretti Arreda, Mantova</title>
    <style type="text/css">
      body { background-image:url('images/mino.jpg'); background-position:cover; background-position: center center; repeat:repeat;}
    </style>    
    <script language="JavaScript" src="header.js"></script>
    <script type="text/javascript">
      <!--
	 var stile = "top=10, left=10, width=1000, height=850, status=no, menubar=no, toolbar=no scrollbars=no";
	 function Popup(apri) 
	 {
	 window.open(apri, "", stile);
	 }
	 //-->
    </script>
  </head>
  <body><br>    
    
    <!-- Breadcrumbs (ossia context) -->
    <div id="context">
      <ol id="sezione">
	<li class="home">Home</li>
      </ol>
    </div>
    <br>
    
    <!-- Barra di login -->
    <table class="login">
      <tr align="center">
	<td>
	  <img src="images/negretti_logo.jpg" align="center" style="padding:10px 0 10px;">
	 <!-- <p style="padding-right:2em" align="right"><font size="3px">@utenza;noquote@</font></p> -->
	</td>
      </tr>
    </table><br> 
    
    <!-- Tabella dei programmi -->
    <table class="tabella">
      <tr class="sub">
        <td>
          <p>INVENTARIO</p>
        </td>
        <td>
          <p>PRODUTTORI</p>
        </td>
        <td>
          <p>TIPOLOGIE</p>
        <td>
      </tr>
      <tr class="punto">  
	<td>
	  <ul>
	    <li><a href="inventario-list">Visualizza elenco</a></li>
	    <li><a href="inventario-gest">Inserisci nuovo</a></li>	
	    <li><a href="inventario-stamp">Stampa in PDF</a></li>
	  </ul>
	</td>
	<td>
	  <ul>
	    <li><a href="marca-list">Visualizza elenco</a></li>
	    <li><a href="marca-gest">Inserisci nuovo</a></li>
	  </ul>
	</td>
	<td>
	  <ul>
	    <li><a href="tipo-list">Visualizza elenco</a></li>
	    <li><a href="tipo-gest">Inserisci nuova</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td align="right" colspan="3">
	  <a href="/register/logout?return_url=/negretti/"><big>Logout</big></a>
	</td>
      </tr>
    </table>
  </body>
</html>
