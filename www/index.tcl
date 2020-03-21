ad_page_contract {  
    Programma per la gestione delle variabili nell'index.
    
    @author Mattia Righetti (mattiarighe@me.com)
    @creation-date 26 May 2013
    @cvs-id main-menu.tcl 
} {
}
set user_id [ad_conn user_id]
if {$user_id == 0} {
   ad_returnredirect "login?return_url=/negretti/"
}
set page_title "Inventario - Negretti Arreda, Mantova"
# prepares link to package parameters
#set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
#if {$user_id == 0} {
#    ad_return_complaint 1 "<font face='courier' size=5><b>Operazione non consentita.<br>Si prega di identificarsi cliccando <a href='/register/?return_url=/applicazioni/4bp/biblioteca/'>quà</a>.</b></font>"
#}
set parameters_url [export_vars -base "/shared/parameters" {package_id return_url} ]
if {$user_id != 0} {
    set utente "<a href='/pvt/home'>"
    append utente [db_string query "SELECT screen_name FROM users WHERE user_id = :user_id"]
    append utente "</a>"
    set utenza "Benvenuto, $utente - <a href='/register/logout?return_url=/applicazioni/4bp/biblioteca/'>Esci</a>"
} else {
    set utenza {<a href="/register?return_url=/applicazioni/4bp/biblioteca/">Login</a>}
}
ad_return_template