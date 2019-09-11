class nginx {

	include nginx::del_apache
	include nginx::install_nginx

}
