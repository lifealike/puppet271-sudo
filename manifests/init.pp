class sudo {

  package {'sudo':
    ensure => 'present',
  }

  file {'/etc/sudoers':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0440',
  }

  #  This version comparison was causing errors on some hosts.
  #  I think it relates to the version installed being 1.7.4p4 or 1.7.4p6
  #  (Emphasis on the p* bit)
  #
  # sudo fragments via #includedir is only available since version 1.7.2
  # /etc/sudoers content is therefore unmanaged on older systems by this
  # module. You should subclass this class to manage its content.
  #if versioncmp($::sudoversion,'1.7.2') >= 0 {

    file {'/etc/sudoers.d':
      ensure  => directory,
      owner   => root,
      group   => root,
      mode    => '0755',
      purge   => true,
      recurse => true,
      force   => true,
    }

    File ['/etc/sudoers'] { content => template('sudo/sudoers.erb'), }

  #}

}
