define rabbitmq::vhost(
  $vhost
){
  exec { "rabbitmq-add-vhost-${vhost}":
    require => Service['rabbitmq-server'],
    unless  => "/usr/sbin/rabbitmqctl list_vhosts | /bin/grep -q ${vhost}",
    command => "/usr/sbin/rabbitmqctl add_vhost ${vhost}";

  }
}
