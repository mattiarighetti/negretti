ad_page_contract {
    @author Mattia Righetti (mattiarighe@me.com)
} {
    tipo_id:integer
}
set user_id [ad_conn user_id]
if {$user_id == 0} {
   ad_returnredirect "login?return_url=/negretti/tipo-canc?tipo_id=$tipo_id"
}
set user_id [ad_conn user_id]
#if {$user_id == 0} {
#   ad_return_complaint 1 "<font face='courier' size=5><b>Operazione non consentita.<br>Si prega di identificarsi cliccando <a href='/register/?return_url=/applicazioni/4bp/biblioteca/libri-canc?libri_id=$libri_id'>quà</a>.</b></font>"}
with_catch errmsg {
    db_dml query "DELETE FROM neg_tipo
                   WHERE tipo_id = :tipo_id"
} {
    ad_return_complaint 1 "<b>Attenzione: non è stato possibile cancellare la tipologia. Si prega di tornare indietro e riprovare.</b>" 
    return
}
ad_returnredirect "tipo-list"
ad_script_abort