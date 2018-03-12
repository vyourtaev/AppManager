#!/usr/bin/env perl
	
use strict;
use warnings;
use v5.10;

use REST::Client;
use File::Slurp;
use LWP::UserAgent;

use AppManager;

my $app = AppManager->new_with_options();

if ( $app->has_action ) {
    if ( $app->action eq 'deploy' ) {
        $app->deploy();

    } elsif ( $app->action eq 'undeploy' ) {
        $app->undeploy();

    } elsif ( $app->action eq 'reload' ) {
        $app->reload();

    } elsif ( $app->action eq 'start' ) {
        $app->start();

    } elsif ( $app->action eq 'stop' ) {
        $app->stop();

    } elsif ( $app->action eq 'status' ) {
        $app->check();

    } else {
        say $app->usage->text;
    }
} 


# vim: ai ts=4 sts=4 et sw=4 ft=perl
