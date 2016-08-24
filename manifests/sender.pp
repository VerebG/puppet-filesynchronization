class filesynchronization::sender (
    $ensure = $::filesynchronization::lsyncd_ensure,
    ){

    validate_re($ensure, [ '^enabled', '^disabled' ])

    case $ensure {
	'enabled': {
	    include sender::setup
	    include sender::requirements
	    Class['sender::requirements']->
	    Class['sender::setup'] ~>
	    Class['services']
	}
	'disabled': {
	}
    }
}