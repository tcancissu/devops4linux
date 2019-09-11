class speedy {

	case $osfamily{
		"redhat":{
			$pacotes = ['epel-release','git','vim','sysstat','fortune-mod','figlet','fish']
		}
	
		"debian":{
			exec{"atualizando_pacotes":
				command => "/usr/bin/apt update"
			}
			
			$pacotes = ['git','vim','sysstat','fortunes-br','figlet','fish']
		}
	}

	package{$pacotes:
		ensure => present,
	}

	file{'/root/.bashrc':
		source => "puppet:///modules/speedy/bashrc",
		ensure => present
	}

        file{'/root/.bash_logout':
                source => "puppet:///modules/speedy/bashrc_logout",
                ensure => present
        }

	user{'ricardito':
		ensure => present,
		managehome => true,
		password => Sensitive('4linux'),
		shell => "/usr/bin/fish"
	}
}
