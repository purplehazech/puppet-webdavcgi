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
    $ldap = false
) {
    package {
        'www-apps/webdavcgi':
            ensure => installed;
    }
}
