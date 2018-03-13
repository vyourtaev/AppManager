use v5.10;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'AppManager',
    AUTHOR           => q{Vladimir Yourtaev <yourtaev@gmail.com>},
    VERSION_FROM     => 'lib/AppManager.pm',
    ABSTRACT_FROM    => 'lib/AppManager.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    MIN_PERL_VERSION => 'v5.10',
    # EXE_FILES => [ qw( scripts/app-manager.pl ) ],
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    BUILD_REQUIRES => {
        'Test::More' => '0',
    },
    PREREQ_PM => {
	'MooseX::Getopt' => '0.47',
	'MooseX::SimpleConfig' => '0.02',
	'REST::Client' => '272',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'AppManager-*' },
);
