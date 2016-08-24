class filesynchronization::services {

    case $::filesynchronization::mode {
	'both': {
	    $rsyncd_service = running
	    $lsyncd_service = running
	}
	'share only': {
	    $rsyncd_service = running
	    $lsyncd_service = stopped
	}
	'sender only': {
	    $rsyncd_service = stopped
	    $lsyncd_service = running
	}

    }

    service {
        'rsync':
	    ensure => $rsyncd_service,
            enable => true;
    }


}