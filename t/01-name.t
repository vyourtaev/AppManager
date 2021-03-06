use strict;
use warnings;
use v5.10;

use Test::More tests => 3;

use AppManager;

my $bar = AppManager->new(
    action => 'deploy',
    name   => 'hello-world-web',
    war => 'hello-world-web/target/hello-world-web.war',
    hostname => 'localhost',
    port => '8080',
    user => 'admin',
    passwd => 'admin',
    configfile => 'script/app-manager.conf',
);

isa_ok($bar, 'AppManager');

is($bar->name('tomcat'), 'tomcat', 'setter');
is($bar->name, 'tomcat', 'getter');
