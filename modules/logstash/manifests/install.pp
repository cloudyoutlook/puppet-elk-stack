class logstash::install {

  # configure the repo we want to use
  yumrepo { 'logstash_2.2_repo':
    enabled  => 1,
    descr    => 'logstash repository for 2.2 packages',
    baseurl  => 'http://packages.elasticsearch.org/logstash/2.2/centos',
    gpgcheck => 1,
    gpgkey   => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
  }

  package { 
    "logstash":
      ensure => latest,
      require => Yumrepo['logstash_2.2_repo'],
  }

  service {
    "logstash":
      enable      => true,
      ensure      => running,
      hasstatus   => true,
      hasrestart  => true,
      require => [
        Package['logstash'],
      ],
  }

file { '/etc/logstash/conf.d/02-syslog-input.conf':
  ensure  => file,
  mode    => '0750',
  source  => 'puppet:///modules/logstash/02-syslog-input.conf',
  require => Package['logstash'],
}

}
