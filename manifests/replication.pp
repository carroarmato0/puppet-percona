# = Definition: percona::replication
#
# A basic helper used to create a replication granted user.
#
# == Parameters:
#
# $user         The user used for the replication
#
# $password			Password needed to authenticate with the mysql server
#
# $host         Hostname or IP to the mysql server
#
# $db           Specify DBs to grant replication permissions on. Default is *.*
#
define percona::replication (
	$user,
	$password,
	$host,
	$db = '*.*',
) {

	exec { "replication-grant-${name}":
		command => "mysql -e \"grant replication slave on \'${db}\' to \'${user}\'@\'${host}\' identified by \'${password}\';\"",
		unless 	=> "test `mysql -Nse 'select count(User) from mysql.user where Host=\"${host}\" and User=\"${user}\"'` = 1",
		path    => ['/usr/bin','/bin',],
	}
}