ad_page_contract {
    @author Mattia Righetti (mattiarighe@me.com)
} {
    marca_id:integer
}
set user_id [ad_conn user_id]
if {$user_id == 0} {
   ad_returnredirect "login?return_url=/negretti/marca-canc?marca_id=$marca_id"
}
set user_id [ad_conn user_id]
#if {$user_id == 0} {
 #   ad_return_complaint 1 "<font face='courier' size=5><b>Operazione non consentita.<br>Si prega di identificarsi cliccando <a href='/register/?return_url=/applicazioni/4bp/biblioteca/libri-canc?libri_id=$libri_id'>quà</a>.</b></font>"}
with_catch errmsg {
    db_dml query "DELETE FROM neg_marca
                   WHERE marca_id = :marca_id"
} {
    ad_return_complaint 1 "<b>Attenzione: non è stato possibile cancellare la marca. Si prega di ritornare indietro e riprovare.</b>" 
    return
}
ad_returnredirect "marca-list"
ad_script_abort