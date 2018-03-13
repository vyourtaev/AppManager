use strict;
use warnings;
use Test::More tests => 6;

BEGIN {
	require_ok( 'AppManager' ) || print "Bail out!\n";
}
diag( "Testing AppManager $AppManager::VERSION, Perl $], $^X" );

ok( defined &AppManager::deploy, 'AppManager::deploy is defined' );
ok( defined &AppManager::undeploy, 'AppManager::undeploy is defined' );
ok( defined &AppManager::start, 'AppManager::start is defined' );
ok( defined &AppManager::stop, 'AppManager::stop is defined' );
ok( defined &AppManager::check, 'AppManager::check is defined' );


