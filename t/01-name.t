use strict;
use warnings;
use v5.10;

use Test::More tests => 5;

use AppManager;

my $bar = AppManager->new;
isa_ok($bar, 'AppManager');

is($bar->name('Tomcat'), 'Tomcat', 'setter');
is($bar->name, 'Tomcat', 'getter');

my $foo = AppManager->new( name => 'GlassFish' );
isa_ok($foo, 'AppManager');
is($foo->name, 'GlassFish')

