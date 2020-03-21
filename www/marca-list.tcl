ad_page_contract {
    @author Mattia Righetti (mattiarighe@me.com)
} {
    {offset 0}
    orderby:optional
    {q ""}
    {rows_per_page 30}
}
set user_id [ad_conn user_id]
if {$user_id == 0} {
    ad_returnredirect "login?return_url=/negretti/marca-list"
}
set page_title "Marca"
set actions {"Aggiungi" marca-gest "Aggiunge una nuova marca."}
source [ah::package_root -package_key ah-util]/paging-buttons.tcl
template::list::create \
    -name marca \
    -multirow marca \
    -actions $actions \
    -elements {
	denominazione {
	    label "Denominazione"
	}
	telefono {
	    label "Telefono" 
        }
	email {
            label "Email" 
        }
	edit {
            link_url_col edit_url
            display_template {<img src="images/icona-edit.ico" width="20px" height="20px" border="0">}
            link_html {title "Modifica marca." width="20px"}
            sub_class narrow
	}
	print {
	    link_url_col print_url
	    display_template {<img src="images/icona-stampa.ico" width="20px" height="20px" border="0">}
	    link_html {title "Stampa i prodotti di questa marca." width="20px"}
	    sub_class narrow
	}
   	delete {
	    link_url_col delete_url 
	    display_template {<img src="images/icona-delete.ico" width="20px" height="20px" border="0">}
	    link_html {title "Cancella marca." onClick "return(confirm('Sei davvero sicuro?'));" width="20px"}
	    sub_class narrow
	}
    } \
    -filters {
	q {
	    hide_p 1
	    values {$q $q}
	    where_clause {UPPER(denominazione) LIKE UPPER('%$q%')}
	}
	rows_per_page {
	    label "Righe per pagina"
	    values {{Quindici 15} {Trenta 30} {Cento 100}}
	    where_clause {1 = 1}
	    default_value 10
	}
    } \
    -orderby {
	default_value denominazione
	denominazione {
	    label "Denominazione"
	    orderby denominazione
	}
    }
db_multirow \
    -extend {
	edit_url
	print_url
	delete_url 
    } marca query "SELECT marca_id, 
                          denominazione,
                          telefono,
                          email
                     FROM neg_marca 
                    WHERE 1 = 1
                           [template::list::filter_where_clauses -name marca -and]
                           [template::list::orderby_clause -name marca -orderby]
                     LIMIT $rows_per_page
	            OFFSET $offset" {
			set edit_url [export_vars -base "marca-gest" {marca_id}]
			set print_url [export_vars -base "marca-stamp" {marca_id}]
			set delete_url [export_vars -base "marca-canc" {marca_id}]
		    }