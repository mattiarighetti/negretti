ad_page_contract {
    @author Mattia Righetti (mattiarighe@me.com)
} {
    oggetto_id:integer,optional
}
set user_id [ad_conn user_id]
if {$user_id == 0} {
   ad_returnredirect "login?return_url=/negretti/inventario-gest"
}
if {[ad_form_new_p -key oggetto_id]} {
    set page_title "Nuovo"
    set buttons [list [list "Salva" new]]
} else {
    set modifica [db_string query "SELECT descrizione FROM neg_oggetto WHERE oggetto_id = :oggetto_id"]
    set page_title "$modifica"
    set buttons [list [list "Aggiorna" edit]]
}
ad_form -name inventario \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	oggetto_id:key
	{tipo_id:text(select)
	    {options {{"" ""} [db_list_of_lists query "SELECT descrizione, tipo_id FROM neg_tipo ORDER BY descrizione"]} }
      	    {html {size 1 style "width:39.5em"}}
            {label "Tipologia"}
	    {help_text "Selezionare la tipologia del prodotto."}
	}	
	{marca_id:text(select)
	    {options {{"" ""} [db_list_of_lists query "SELECT denominazione, marca_id FROM neg_marca ORDER BY denominazione"]} }
      	    {html {size 1 style "width:39.5em"}}
            {label "Marca"}
	    {help_text "Selezionare la marca del prodotto."}
	}
	{modello:text,optional
	    {label "Modello"}
	    {html {size 70 maxleght 50}}
	    {help_text "Il campo può contenere fino a 50 caratteri."}
	}
	{descrizione:text,optional
	    {label "Descrizione"}
	    {html {size 70 maxlength 100}}
	    {help_text "Il campo può contenere fino a 100 caratteri."}
	}
	{dimensione:text,optional
	    {label "Dimensione"}
	    {html {size 70 maxlenght 20}}
	    {help_text "Il campo può contenere fino a 20 caratteri."}
	}
	{quantita:text
	    {label "Quantità"}
	    {html {size 70 maxlenght 10}}
	    {help_text "Il campo può contenere solo numeri interi."}
	}
	{prezzo:text
	    {label "Prezzo"}
	    {html {size 70 maxlenght 10}}
	    {help_text "Per esempio 29.90"}
	}
    } -select_query { "SELECT oggetto_id,
                              descrizione,
                              quantita,
                              modello,
                              dimensione,
                              tipo_id,
                              marca_id,
prezzo
	                 FROM neg_oggetto
 	                WHERE oggetto_id = :oggetto_id"
    } -new_data {
	set oggetto_id [db_string query "SELECT COALESCE (MAX(oggetto_id) + 1, 1) FROM neg_oggetto"]
	db_dml query "INSERT INTO neg_oggetto (oggetto_id
                                              ,descrizione
                                              ,marca_id 
                                              ,quantita
                                              ,modello
                                              ,dimensione
                                              ,tipo_id
,prezzo)            
                                      VALUES (:oggetto_id
                                             ,:descrizione
                                             ,:marca_id
                                             ,:quantita
                                             ,:modello
                                             ,:dimensione
                                             ,:tipo_id
,:prezzo)"	
    } -edit_data {
	db_dml query "UPDATE neg_oggetto   
                         SET oggetto_id  = :oggetto_id 
	                    ,descrizione = :descrizione
	                    ,marca_id    = :marca_id
                            ,quantita    = :quantita
                            ,tipo_id     = :tipo_id
                            ,modello     = :modello
                            ,dimensione  = :dimensione
,prezzo = :prezzo	
               WHERE oggetto_id  = :oggetto_id"
    } -on_submit {
	set ctr_errori 0
	if {$ctr_errori > 0} {
	    break
	}
    } -after_submit {
	ad_returnredirect "inventario-list"
	ad_script_abort
    }
