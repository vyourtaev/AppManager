use strict;
use warnings;
use v5.10;

use Test::More tests => 2;

use Data::Dumper;

use AppManager;
use AppManager::Check;

my $app = AppManager->new_with_options(
    action => 'deploy',
    name   => 'hello-world-web',
    war => 'hello-world-web/target/hello-world-web.war',
    hostname => 'localhost',
    port => '8080',
    user => 'admin',
    passwd => 'admin',
    configfile => 'script/app-manager.conf',
);

isa_ok($app, 'AppManager');

ok $app->check();


# vim: ai ts=4 sts=4 et sw=4 ft=perl
