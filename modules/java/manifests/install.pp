class java::install {

  package { 
    "java-1.8.0-openjdk":
      ensure => latest,
  }

  exec { 'switch_java_version':
    command => 'alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java',
    path    => '/usr/local/bin/:/usr/sbin/:/bin/',
  }

}
