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
}
