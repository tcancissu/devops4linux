#resource_type{'name_resource':
#	atributos => valor,
#	atributos => valor,
#	...
#}

$pacotes = ['vim','figlet','htop']

Exec { path => '/usr/bin' }

package{$pacotes:
	ensure => present
}

exec{'titulo':
	command => "free -h > /tmp/memfree",
	user => 'gaviao_negro'
}

file {'/root/memfree':
	source => "/tmp/memfree",
	mode => '654',
	owner => vagrant,
	group => root,
	ensure => present
}

service{'cron':
	enable => false,
	ensure => stopped,
}

