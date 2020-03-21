ad_page_contract {
    @author Mattia Righetti (mattiarighe@me.com)
} {
    {offset 0}
    {q ""}
    {rows_per_page 30}
    orderby:optional
    
}
set user_id [ad_conn user_id]
if {$user_id == 0} {
    ad_returnredirect "login?return_url=/negretti/tipo-list"
}
set page_title "Tipologia"
set actions { "Aggiungi" tipo-gest "Aggiunge una nuova tipologia."}
source [ah::package_root -package_key ah-util]/paging-buttons.tcl
template::list::create \
    -name tipologia \
    -multirow tipologia \
    -actions $actions \
    -elements {
	descrizione {
	    label "Tipologia"
	}
	edit {
            link_url_col edit_url
            display_template {<img src="images/icona-edit.ico" width="20px" height="20px" border="0">}
            link_html {title "Modifica tipologia." width="20px"}
            sub_class narrow
	}
	print {
	    link_url_col print_url
	    display_template {<img src="images/icona-stampa.ico" width="20px" height="20px" border="0">}
	    link_html {title "Stampa tutti i prodotti di questa tipologia." width="20px"}
	    sub_class narrow
	}
   	delete {
	    link_url_col delete_url 
	    display_template {<img src="images/icona-delete.ico" width="20px" height="20px" border="0">}
	    link_html {title "Cancella tipologia." onClick "return(confirm('Sei davvero sicuro?'));" width="20px"}
	    sub_class narrow
	}
    } \
    -filters {
	q {
	    hide_p 1
	    values {$q $q}
	    where_clause {UPPER(descrizione) LIKE UPPER('%$q%')}
	}
	rows_per_page {
	    label "Righe per pagina"
	    values {{Quindici 15} {Trenta 30} {Cento 100}}
	    where_clause {1 = 1}
	    default_value 10
	}
    } \
    -orderby {
	default_value descrizione
	descrizione {
	    label "Descrizione"
	    orderby descrizione
	}
    }
db_multirow \
    -extend {
	edit_url
	print_url
	delete_url 
    } tipologia query "SELECT descrizione, tipo_id
                          FROM neg_tipo where 1=1
                           [template::list::filter_where_clauses -name tipologia -and]
                           [template::list::orderby_clause -name tipologia -orderby]
                     LIMIT $rows_per_page
	            OFFSET $offset" {
			set edit_url [export_vars -base "tipo-gest" {tipo_id}]
			set print_url [export_vars -base "tipo-stamp" {tipo_id}]
			set delete_url [export_vars -base "tipo-canc" {tipo_id}]
		    }