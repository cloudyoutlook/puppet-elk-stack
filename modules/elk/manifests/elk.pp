class elk::install {

  # configure the repo we want to use
  yumrepo { 'elasticsearch_repo':
    enabled  => 1,
    descr    => 'Elasticsearch repository for 2.x packages',
    baseurl  => 'http://packages.elastic.co/elasticsearch/2.x/centos',
    gpgcheck => 1,
    gpgkey   => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
  }

  package { 
    $elk::prefered_packages_list:
      ensure => latest,
      require => Yumrepo['elasticsearch_repo'],
  }

  exec { 'switch_java_version':
    command => 'alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java',
    path    => '/usr/local/bin/:/usr/sbin/:/bin/',
  }

file { '/etc/elasticsearch/elasticsearch.yml':
  ensure  => file,
  mode    => '0750',
  group   => 'elasticsearch',
  source  => 'puppet:///modules/elk/elasticsearch.yml',
  require => Package['elasticsearch'],
}

  service {
    "elasticsearch":
      enable      => true,
      ensure      => running,
      hasstatus   => true,
      hasrestart  => true,
      require => [
        Package['elasticsearch'],
        File['/etc/elasticsearch/elasticsearch.yml'],
      ],
  }

}
