class elasticsearch::install {

  # configure the repo we want to use
  yumrepo { 'elasticsearch_repo':
    enabled  => 1,
    descr    => 'Elasticsearch repository for 2.x packages',
    baseurl  => 'http://packages.elastic.co/elasticsearch/2.x/centos',
    gpgcheck => 1,
    gpgkey   => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
  }

  package { 
    $elasticsearch::prefered_packages_list:
      ensure => latest,
      require => Yumrepo['elasticsearch_repo'],
  }

file { '/etc/elasticsearch/elasticsearch.yml':
  ensure  => file,
  mode    => '0750',
  group   => 'elasticsearch',
  source  => 'puppet:///modules/elasticsearch/elasticsearch.yml',
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
