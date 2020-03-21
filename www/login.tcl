ad_page_contract {
    Programma per il login.
} {
    {authority_id ""}
    {username ""}
    {email ""}
    {return_url "/negretti/"}
}
set subsite_id [ad_conn subsite_id]
set login_template [parameter::get -parameter "LoginTemplate" -package_id $subsite_id]
if {$login_template eq ""} {
    set login_template "/packages/negretti/www/lib/login"
}