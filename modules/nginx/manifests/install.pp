class nginx::install {

  package { 
    "epel-release":
      ensure => latest,
  }

  package { 
    $nginx::required_packages_list:
      ensure => latest,
      require => Package['epel-release'],
  }


  exec { 'set_basic_auth_user':
    command => "htpasswd -b -c /etc/nginx/htpasswd.users kibanaadmin ${nginx::htpasswd_pass}",
    path    => '/usr/bin/',
    creates => '/etc/nginx/htpasswd.users',
    require => Package['httpd-tools'],
  }

#  file { '/etc/nginx/nginx.conf':
#    ensure  => file,
#    mode    => '0664',
#    group   => 'root',
#    source  => 'puppet:///modules/nginx/nginx.conf',
#    require => Package['nginx'],
#  }

  service {
    "nginx":
      enable      => true,
      ensure      => running,
      hasstatus   => true,
      hasrestart  => true,
      require => [
        Package['nginx'],
#        File['/etc/nginx/nginx.conf'],
      ],
  }
}
