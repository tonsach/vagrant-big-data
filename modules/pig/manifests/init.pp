class pig {
  
  # check url
  $pig = "pig-0.12.0"
  $url = "http://archive.apache.org/dist/pig"

  exec { "download_pig":
    command => "rm -f /tmp/${pig}.tar.gz && wget -O /tmp/${pig}.tar.gz ${url}/${pig}/${pig}.tar.gz",
    path => $path,
    timeout => 1800,
    logoutput => "on_failure",
    require => Package["openjdk-6-jdk"]
  }

  exec { "unpack_pig":
    command => "rm -rf /opt/${pig} && tar -zxf /tmp/${pig}.tar.gz -C /opt",
    path => $path,
    logoutput => "on_failure",
    creates => "/opt/${pig}",
    require => Exec["download_pig"]
  }

  exec { "symlink_pig":
    command => "rm -f /usr/lib/pig && ln -s /opt/${pig} /usr/lib/pig",
    path => $path,
    logoutput => "on_failure",
    require => Exec["unpack_pig"]
  }

  exec { "set_owner_pig":
    command => "chown -R vagrant:vagrant /opt/${pig}", 
    path => $path,
    logoutput => "on_failure",
    require => Exec["symlink_pig"]
  }

}