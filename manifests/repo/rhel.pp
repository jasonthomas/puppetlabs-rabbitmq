class rabbitmq::repo::rhel (
    $key = "http://www.rabbitmq.com/rabbitmq-signing-key-public.asc",
    $version = "2.8.4",
    $relversion = "1",
) { 
    exec { 'install_rmq_key':
   command => "rpm --import ${key} && touch /root/.rmq_key_import",
        path => ["/bin","/usr/bin","/sbin","/usr/sbin"],
        unless => 'test -f /root/.rmq_key_import'
    }
    package { "erlang":
        ensure => installed,
        before => Package['rabbitmq-server'];
    }
    package { "rabbitmq-server":
        provider => rpm,
        ensure => installed,
        source => "http://www.rabbitmq.com/releases/rabbitmq-server/v${version}/rabbitmq-server-${version}-${relversion}.noarch.rpm",
        require => Exec['install_rmq_key'];
    }
}
