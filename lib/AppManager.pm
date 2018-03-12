package AppManager;

use v5.10;

use REST::Client;

require AppManager::Deploy;
require AppManager::Undeploy;
require AppManager::Reload;
require AppManager::Start;
require AppManager::Stop;
require AppManager::Check;

use Moose;

with 'MooseX::SimpleConfig';
with 'MooseX::Getopt';

our $VERSION = '0.01';

has 'hostname'        => ( 
    is              => 'rw', 
    isa             => 'Str',
    traits          => ['Getopt'],
    predicate       => 'has_hostname',
    required        => 1,
    cmd_aliases     => ['h'],
    documentation   => 'hostname or IP',
);

has 'port'        => ( 
    is              => 'rw', 
    isa             => 'Str',
    traits          => ['Getopt'],
    predicate       => 'has_port',
    required        => 1,
    cmd_aliases     => ['p'],
    documentation   => 'port',
);

has 'user'       => ( 
    is          => 'rw', 
    isa         => 'Str',
    traits      => ['Getopt'],
    predicate   => 'has_user',
    required        => 1,
    cmd_aliases => ['u'],
    documentation => 'Username',
);

has 'passwd'       => ( 
    is          => 'rw', 
    isa         => 'Str',
    traits      => ['Getopt'],
    predicate   => 'has_passwd',
    required        => 1,
    cmd_aliases => ['P'],
    documentation => 'Password',
);

has 'action'    => ( 
    is          => 'rw', 
    isa         => 'Str',
    traits      => ['Getopt'],
    predicate   => 'has_action',
    required    => 1,
    cmd_aliases => ['a'],
    documentation => 'Action [deploy, undeploy, start, stop, reload, check]',
);

before 'action' => sub {
    my ($self) = shift;
    my $client = REST::Client->new();
    my $host = sprintf("http://%s:%s@%s:%s",($self->user,$self->passwd,$self->hostname,$self->port));
    $client->setHost($host);
    $self->{client} = $client;
};

has 'name'       => ( 
    is          => 'rw', 
    isa         => 'Str',
    traits      => ['Getopt'],
    predicate   => 'has_name',
    default     => 'manager',
    required        => 0,
    cmd_aliases => ['n'],
    documentation => 'Application name',
);

has 'war'       => ( 
    is          => 'rw', 
    isa         => 'Str',
    traits      => ['Getopt'],
    predicate   => 'has_war',
    required        => 0,
    cmd_aliases => ['w'],
    documentation => 'Application package war file',
);

=head1 NAME

AppManager - Simple Apache Tomcat Manager application!

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

In many production environments, it is very useful to have the capability to deploy 
a new web application, or undeploy an existing one, without having to shut down and 
restart the entire container. In addition, you can request an existing application 
to reload itself, even if you have not declared it to be reloadable in the 
Tomcat server configuration file.  

    use AppManager;

    my $app = AppManager->new();
    $app->deploy('/path/to/war');

    $app->stop('webapps');

    $app->start('webapps');

    $spp->undeploy('webapps');


=head1 SUBROUTINES/METHODS

=head2 deploy {
    perl app-manager.pl -a deploy  -n hello-world-web -w hello-world-web/target/hello-world-web.war  --configfile script/app-manager.conf 

    OK - Deployed application at context path /hello-world-web
}

=cut

sub deploy {

    my ($self) = shift;
    AppManager::Deploy->deploy($self);

}

=head2 undeploy
    --action undeploy ( undeployment of applicaton )

=cut

sub undeploy {

    my ($self) = shift;
    AppManager::Undeploy->undeploy($self);

}

=head2 reload

    perl -Ilib script/app-manager.pl -a reload  -n hello-world-web  --configfile script/app-manager.conf 
    OK - Reloaded application at context path /hello-world-web

=cut

sub reload {

    my $self = shift;
    AppManager::Reload->reload( $self );

}

=head2 start
    perl app-manager.pl -a start -n hello-world-web  --configfile script/app-manager.conf 

    OK - Started application at context path /hello-world-web
=cut

sub start {

    my $self = shift;
    AppManager::Start->start( $self );

}

=head2 stop

=cut

sub stop {

    my $self = shift;
    AppManager::Stop->stop( $self );

}

=head2 check 

 perl app-manager.pl -a status -n hello-world-web  --configfile script/app-manager.conf 

 OK - hello-world-web application for virtual host localhost

 Context: /hello-world-web
 Status: running
 Sessions: 1
 Name: hello-world-web

=cut

sub check {
    my $self = shift;
    AppManager::Check->check( $self );
}


=head1 AUTHOR

Vladimir Yourtaev, C<< <yourtaev at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-appmanager at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=AppManager>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc AppManager


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Vladimir Yourtaev.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut
# vim: ai ts=4 sts=4 et sw=4 ft=perl
1; # End of AppManager
