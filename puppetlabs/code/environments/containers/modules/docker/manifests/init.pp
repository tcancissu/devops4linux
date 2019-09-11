class docker {

	Exec  { path => '/usr/bin' }

        case $osfamily{

                "debian":{
			$pacotes = ['apt-transport-https','ca-certificates','curl','gnupg-agent','software-properties-common']
			$codename = $facts['os']['distro']['codename']

                        exec{"apt_update":
                                command => "apt update"
                        }

			exec{'docker_repo':
				command => "add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu $codename stable'",
				onlyif => 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -',
				notify => Exec['apt_update'],
				require => Package[$pacotes]
			}

                }

                "redhat":{
	                $pacotes = ['yum-utils','device-mapper-persistent-data','lvm2']

			yumrepo{'docker_repo':
				descr => "Repositorio do DOCKER-CE",
				baseurl => 'https://download.docker.com/linux/centos/7/$basearch/stable',
				gpgkey => 'https://download.docker.com/linux/centos/gpg',
				gpgcheck => 1,
				enable => 1,
				requere => Package[$pacotes]	
			}
                }
        }

	package{$pacotes:
		ensure => present,
		before => Package['docker-ce']
	}

	package{'docker-ce':
		ensure => present,
		before => Service['docker']
	}
	
	service{'docker':
		ensure => running,
		enable => true,
		subscribe => Package['docker-ce']
	}

}
