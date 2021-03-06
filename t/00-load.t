#!perl -T
use v5.10;

use strict;
use warnings;

use Test::More;

plan tests => 7;

BEGIN {
    use_ok( 'AppManager' ) || print "Bail out!\n";
    use_ok( 'AppManager::Deploy' ) || print "Bail out!\n";
    use_ok( 'AppManager::Undeploy' ) || print "Bail out!\n";
    use_ok( 'AppManager::Start' ) || print "Bail out!\n";
    use_ok( 'AppManager::Stop' ) || print "Bail out!\n";
    use_ok( 'AppManager::Check' ) || print "Bail out!\n";
    use_ok( 'AppManager::Reload' ) || print "Bail out!\n";
}

diag( "Testing AppManager $AppManager::VERSION, Perl $], $^X" );
