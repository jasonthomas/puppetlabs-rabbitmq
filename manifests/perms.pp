define rabbitmq::perms(
  $user,
  $vhost,
  $perms = "'.*' '.*' '.*'"
){
  exec { "rabbitmq-set-perms-${user}-${vhost}":
    require => Exec["rabbitmq-add-vhost-${vhost}"],
    unless  => "/usr/sbin/rabbitmqctl list_user_permissions ${user} | /bin/grep -v 'Listing' | /bin/grep -q ${vhost}",
    command => "/usr/sbin/rabbitmqctl set_permissions -p ${vhost} ${user} $perms";

  }
}
