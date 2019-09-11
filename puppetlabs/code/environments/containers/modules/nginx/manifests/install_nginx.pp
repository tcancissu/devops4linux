class nginx::install_nginx {

	package{'nginx':
		ensure => present,
		require => Package['apache2']
	}

	~> service{'nginx':
		ensure => "running",
		enable => true
	}

}
