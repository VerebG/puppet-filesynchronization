class filesynchronization::receiver (
    $ensure = $::filesynchronization::rsyncd_ensure,
    ){

    validate_re($ensure, [ '^enabled', '^disabled' ])

    case $ensure {
	'enabled': {
	    include receiver::setup
	    include receiver::requirements
	    Class['receiver::requirements']->
	    Class['receiver::setup'] ~>
	    Class['services']
	}
	'disabled': {
	    include receiver::uninstall
	    Class['receiver::uninstall'] ~>
	    Class['services']
	}
    }
}