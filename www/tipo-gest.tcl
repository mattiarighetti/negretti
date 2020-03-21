ad_page_contract {
    @author Mattia Righetti (mattiarighe@me.com)
} {
    tipo_id:integer,optional
}
set user_id [ad_conn user_id]
if {$user_id == 0} {
   ad_returnredirect "login?return_url=/negretti/tipo-list"
}
if {[ad_form_new_p -key tipo_id]} {
    set page_title "Nuovo"
    set buttons [list [list "Salva" new]]
} else {
    set modifica [db_string query "SELECT descrizione FROM neg_tipo WHERE tipo_id = :tipo_id"]
    set page_title "$modifica"
    set buttons [list [list "Aggiorna" edit]]
}

ad_form -name tipologia \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	tipo_id:key
	{descrizione:text
	    {label "Tipologia"}
	    {html {size 80 maxlenght 100}}
	}
    } -select_query { "SELECT tipo_id,
                              descrizione
	                 FROM neg_tipo
 	                WHERE tipo_id = :tipo_id"
    } -new_data {
	set tipo_id [db_string query "SELECT COALESCE (MAX(tipo_id) + 1, 1) FROM neg_tipo"]
	db_dml query "INSERT INTO neg_tipo (tipo_id
                                           ,descrizione)
                                   VALUES (:tipo_id
                                          ,:descrizione)"	
    } -edit_data {
	db_dml query "UPDATE neg_tipo
                         SET tipo_id     = :tipo_id 
	                    ,descrizione = :descrizione
	               WHERE tipo_id    = :tipo_id"
    } -on_submit {
	set ctr_errori 0
	if {$ctr_errori > 0} {
	    break
	}
    } -after_submit {
	ad_returnredirect "tipo-list"
	ad_script_abort
    }