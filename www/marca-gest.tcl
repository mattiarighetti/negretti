ad_page_contract {
    @author Mattia Righetti (mattiarighe@me.com)
} {
    marca_id:integer,optional
}
set user_id [ad_conn user_id]
if {$user_id == 0} {
   ad_returnredirect "login?return_url=/negretti/marca-list"
}
if {[ad_form_new_p -key marca_id]} {
    set page_title "Nuovo"
    set buttons [list [list "Salva" new]]
} else {
    set modifica [db_string query "SELECT denominazione FROM neg_marca WHERE marca_id = :marca_id"]
    set page_title "$modifica"
    set buttons [list [list "Aggiorna" edit]]
}

ad_form -name marca \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	marca_id:key
	{denominazione:text
	    {label "Denominazione"}
	    {html {size 80 maxlenght 100}}
	}
	{via:text,optional
	    {label "Via e civico"}
	    {html {size 80 maxlength 100}}
	}
	{localita:text,optional
	    {label "Località"}
	    {html {size 80 maxlenght 100}}
	}
	{cap:text,optional
	    {label "CAP"}
	    {html {size 80 maxlenght 5}}
	}
	{stato:text,optional
	    {label "Stato"}
	    {html {size 80 maxlenght 50}}
	}
	{telefono:text,optional
	    {label "Telefono"}
	    {html {size 80 maxlenght 20}}
	}
	{email:text,optional
	    {label "Email"}
	    {html {size 80 maxlenght 50}}
	}
    } -select_query { "SELECT marca_id,
                              denominazione,
                              via,
                              localita,
                              cap,
                              stato,
                              telefono,
                              email
	                 FROM neg_marca
 	                WHERE marca_id = :marca_id"
    } -new_data {
	set marca_id [db_string query "SELECT COALESCE (MAX(marca_id) + 1, 1) FROM neg_marca"]
	db_dml query "INSERT INTO neg_marca (marca_id
                                            ,denominazione
                                            ,via
                                            ,localita
                                            ,cap
                                            ,stato
                                            ,telefono
                                            ,email)                        
                                    VALUES (:marca_id
                                           ,:denominazione
                                           ,:via
                                           ,:localita
                                           ,:cap
                                           ,:stato
                                           ,:telefono
                                           ,:email)"	
    } -edit_data {
	db_dml query "UPDATE neg_marca  
                         SET marca_id      = :marca_id 
	                    ,denominazione = :denominazione
	                    ,via           = :via
                            ,localita      = :localita
                            ,cap           = :cap
                            ,stato         = :stato
                            ,telefono      = :telefono
                            ,email         = :email
	               WHERE marca_id      = :marca_id"
    } -on_submit {
	set ctr_errori 0
	if {$ctr_errori > 0} {
	    break
	}
    } -after_submit {
	ad_returnredirect "marca-list"
	ad_script_abort
    }