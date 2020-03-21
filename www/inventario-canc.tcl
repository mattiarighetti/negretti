ad_page_contract {
    @author Mattia Righetti (mattiarighe@me.com)
} {
    oggetto_id:integer
}
set user_id [ad_conn user_id]
if {$user_id == 0} {
   ad_returnredirect "login?return_url=/negretti/inventario-canc?oggetto_id=$oggetto_id"
}
with_catch errmsg {
    db_dml query "DELETE FROM neg_oggetto
                   WHERE oggetto_id = :oggetto_id"
} {
    ad_return_complaint 1 "<b>Attenzione: non è stato possibile cancellare l'oggetto. Si prega di tornare indietro e riprovare.</b>" 
    return
}
ad_returnredirect "inventario-list"
ad_script_abort