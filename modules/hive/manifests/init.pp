#init.pp for hive
class hive {
  
  # check url
  $hive = "hive-0.12.0-bin"
  $url = "https://archive.apache.org/dist/hive/hive-0.12.0"

  exec { "download_hive":
    command => "rm -f /tmp/${hive}.tar.gz && wget -O /tmp/${hive}.tar.gz ${url}/${hive}.tar.gz",
    path => $path,
    timeout => 1800,
    logoutput => "on_failure",
    require => Package["openjdk-6-jdk"]
  }

  exec { "unpack_hive":
    command => "rm -rf /opt/${hive} && tar -zxf /tmp/${hive}.tar.gz -C /opt",
    path => $path,
    logoutput => "on_failure",
    creates => "/opt/${hive}",
    require => Exec["download_hive"]
  }

  exec { "symlink_hive":
    command => "rm -f /usr/lib/hive && ln -s /opt/${hive} /usr/lib/hive",
    path => $path,
    logoutput => "on_failure",
    require => Exec["unpack_hive"]
  }

  exec { "set_owner_hive":
    command => "chown -R vagrant:vagrant /opt/${hive}", 
    path => $path,
    logoutput => "on_failure",
    require => Exec["symlink_hive"]
  }

}