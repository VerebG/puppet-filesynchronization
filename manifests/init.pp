class filesynchronization (
    $mode                    = $filesynchronization::params::mode,
    $rsyncd_conf_file        = $filesynchronization::params::rsyncd_conf_file,
    $rsyncd_daemon_conf_file = $filesynchronization::params::rsyncd_daemon_conf_file,
    $rsyncd_start_on_boot    = $filesynchronization::params::rsyncd_start_on_boot,
    $rsyncd_use_chroot       = $filesynchronization::params::rsyncd_use_chroot,
    $rsyncd_uid              = $filesynchronization::params::rsyncd_uid,
    $rsyncd_gid              = $filesynchronization::params::rsyncd_gid,
    $rsyncd_ipv4_listen      = $filesynchronization::params::rsyncd_ipv4_listen,
    $rsyncd_share_read_only  = $filesynchronization::params::rsyncd_share_read_only,
    $rsyncd_share_write_only = $filesynchronization::params::rsyncd_share_write_only,
    $rsyncd_incoming_chmod   = $filesynchronization::params::rsyncd_incoming_chmod,
    $rsyncd_outgoing_chmod   = $filesynchronization::params::rsyncd_outgoing_chmod,
    $rsyncd_log_dir          = $filesynchronization::params::rsyncd_log_dir,
    $rsyncd_shares           = {},
    $lsyncd_conf_dir	     = $filesynchronization::params::lsyncd_conf_dir,
    $lsyncd_conf_file        = $filesynchronization::params::lsyncd_conf_file,
    $lsyncd_log_dir          = $filesynchronization::params::lsyncd_log_dir,
    $lsyncd_status_file      = $filesynchronization::params::lsyncd_status_file,
    $lsyncd_targets          = {},
    ) inherits params {

    include services

    validate_ip_address($rsyncd_ipv4_listen)
    validate_hash($rsyncd_shares)
    validate_hash($lsyncd_targets)


    case $mode {
        'both': {
            $rsyncd_ensure  = enabled
            $lsyncd_ensure  = enabled
	}
	'share only': {
            $rsyncd_ensure  = enabled
            $lsyncd_ensure  = disabled
        }
        'sender only': {
            $rsyncd_ensure  = disabled
            $lsyncd_ensure  = enabled
        }
    }


    create_resources(receiver::target, $rsyncd_shares)
    create_resources(sender::target,   $lsyncd_targets)
}