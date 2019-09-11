class oliver{

	if $facts['hostname'] == 'docker' {
		$env = "containers"
	}
	else{
		$env = "production"
	}

	file{"/etc/puppetlabs/puppet/puppet.conf":
		content => template("oliver/puppet.conf.erb"),
		ensure => present,
		before => Service['puppet']
	}

	service{'puppet':
		ensure => running,
		subscribe => File['/etc/puppetlabs/puppet/puppet.conf']
	}
}
