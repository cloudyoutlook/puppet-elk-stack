class kibana::install {

  # configure the repo we want to use
  yumrepo { 'kibana_repo':
    enabled  => 1,
    descr    => 'Kibana repository for 4.4.x packages',
    baseurl  => 'http://packages.elastic.co/kibana/4.4/centos',
    gpgcheck => 1,
    gpgkey   => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
  }

  package { 
    "kibana":
      ensure => latest,
      require => Yumrepo['elasticsearch_repo'],
  }

  file { '/opt/kibana/config/kibana.yml':
    ensure  => file,
    mode    => '0664',
    group   => 'root',
    source  => 'puppet:///modules/kibana/kibana.yml',
    require => Package['kibana'],
  }

  service {
    "kibana":
      enable      => true,
      ensure      => running,
      hasstatus   => true,
      hasrestart  => true,
      require => [
        Package['kibana'],
        File['/opt/kibana/config/kibana.yml'],
      ],
  }
}
