define rabbitmq::user(
  $user,
  $password
){
  exec { "rabbitmq-add-user-${user}":
    require => Service['rabbitmq-server'],
    unless  => "/usr/sbin/rabbitmqctl list_users | /bin/grep -q ${user}",
    command => "/usr/sbin/rabbitmqctl add_user ${user} ${password}";

  }
}
