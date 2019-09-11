class nginx::del_apache {

	package{'apache2':
		ensure => absent,
		require => Service['apache2']
	}

	service{'apache2':
		ensure => stopped,
		notify => Package['apache2']
	}

}
