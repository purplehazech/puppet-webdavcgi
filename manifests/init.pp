# Define: webdavcgi
#
# Configures the webdavcgi server
#
# Parameters:
#
# Actions:
# * Install Webdavcgi Module for Apache
#
# Requires:
#
# Sample Usage:
#
define webdavcgi (
    $ensure  = 'installed',
    $hostname,
    $docroot,
    $ldap = false
) {
    package {
        'www-apps/webdavcgi':
            ensure => installed;
    }

    file {
        "/var/www/${hostname}/etc/webdav.conf":
            content => template('webdavcgi/webdav.conf.erb')
    }

    apache::vhost {
        'webdav_vhost':
            port     => 80,
            docroot  => "/var/www/${hostname}/htdocs",
            options  => 'FollowSymLinks IncludesNOEXEC SymlinksIfOwnerMatch',
            override => [
                'AuthConfig',
                'FileInfo',
                'Indexes',
                'Limit'
            ],
            template => 'apache/vhost-default.conf.erb'
    }
    apache::vhost::include::rewrite {
        'webdav_rewrite':
            proxy_vhost => 'webdav_vhost',
            rules       => [
                '^/logout /cgi-bin/logout [PT,E=REALM:WebDAV-CGI,E=HOMEURL:/,L]',
                '^/ /cgi-bin/webdavwrapper [PT,E=WEBDAVCONF:/var/www/webdav.hq.rabe.ch/etc/webdav.conf,E=PERLLIB:/var/www/webdav.hq.rabe.ch/lib/perl,L]'
            ]
    }
}
