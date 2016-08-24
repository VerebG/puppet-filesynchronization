class filesynchronization::receiver::requirements {

    Package['rsync']

    -> file {
	$::filesynchronization::rsyncd_log_dir:
	    ensure => directory;
    }

}