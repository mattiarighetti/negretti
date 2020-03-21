<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta name="author" content="Mattia Righetti (mattiarighe@me.com)">
    <title>Login - Negretti Arreda, Mantova</title>
    <script language="JavaScript" src="header.js"></script>
    <style type="text/css">
      body { background-image:url('images/login.jpg'); background-size: cover; background-position: center center; repeat:repeat;}
    </style>
  </head>
  <body><br>
    <div id="context">
      <p align="center"><big>LOGIN</big></p>
    </div>
    <br><br><br><br>
    <table class="tabella">
      <tr>
	<td align="left">
	  <include src="@login_template@" return_url="@return_url;noquote@" no_frame_p="1" authority_id="@authority_id@" username="@username;noquote@" email="@email;noquote@" &="__adp_properties">
	</td>
      </tr>
    </table>
  </body>
</html>
