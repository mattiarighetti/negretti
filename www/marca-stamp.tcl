ad_page_contract {
    @author Mattia Righetti (mattiarighe@me.com)
} {
    marca_id:integer
}
set user_id [ad_conn user_id]
if {$user_id == 0} {
   ad_returnredirect "login?return_url=/negretti/marca-stamp?marca_id=$marca_id"
}
set html "<html>"
set dataelaborazione [db_string query "SELECT TO_CHAR(CURRENT_DATE, 'DD/MM/YYYY')"] 
set denom_marca [db_string denom_marca "SELECT denominazione FROM neg_marca WHERE marca_id = :marca_id"] 
set intestazione "Stampa inventario"
append html "<table width=\"100%\" cellspacing=\"1\" cellpadding=\"1\">
                <tr>
                    <td align=\"left\"><img src=\"http://85.32.63.43:8000/applicazioni/spiaggia/righetti/images/negretti_logo.jpg\" width=\"181px\" height=\"30px\"></img></td>
                    <td align=\"right\">$dataelaborazione</td> 
                </tr>
                <tr>     
               <td colspan=\"2\" align=\"center\"><font face=\"Helvetica\"><b>Inventario dei prodotti $denom_marca</b></font></td>
                 </tr>
              </table> 
              <br>
              <table width=100% border='0.2' cellspacing=3 cellpadding=3 bordercolor=grey>
               <tr> 
                  <td align=center><font face=Helvetica><b>Tipologia</b></font></td>
                  <td align=center><font face=Helvetica><b>Modello</b></font></td>
                  <td align=center><font face=Helvetica><b>Descrizione</b></font></td>
                  <td align=center><font face=Helvetica><b>Dimensione</b></font></td>
                  <td align=center><font face=Helvetica><b>Q.tà</b></font></td>
                </tr>"
db_foreach query "SELECT o.descrizione, 
                         o.quantita,
                         o.modello,
                         o.dimensione,
                         t.descrizione AS tipo
                    FROM neg_oggetto o
         LEFT OUTER JOIN neg_tipo t ON o.tipo_id = t.tipo_id
                   WHERE o.marca_id = :marca_id
                ORDER BY o.descrizione " {
		     append html "</tr>
                                  <td align=center><font size='2px'>$tipo</font></td>
                                  <td align=center><font size='2px'>$modello</font></td>
                                  <td align=center><font size='2px'>$descrizione</font></td>
                                  <td align=center><font size='2px'>$dimensione</font></td>
                                  <td align=center><font size='2px'>$quantita</font></td>"
		 }
append html "</table>"
set filenamehtml "/tmp/stampa-per-marca.html"
set filenamepdf  "/tmp/stampa-per-marca.pdf"
set file_html [open $filenamehtml w]
puts $file_html $html
close $file_html
with_catch error_msg {
    exec htmldoc --portrait --webpage --header ... --footer ... --quiet --left 0.5cm --right 0.5cm --top 0.5cm --bottom 0.5cm --fontsize 12 -f $filenamepdf $filenamehtml
} {
    ns_log notice "errore htmldoc  <code>$error_msg </code>"
}
ns_returnfile 200 application/pdf $filenamepdf
ns_unlink $filenamepdf
ns_unlink $filenamehtml
ad_script_abort