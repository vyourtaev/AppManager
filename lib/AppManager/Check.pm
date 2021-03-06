package AppManager::Check;

use v5.10;
use strict;
use warnings;

=head1 NAME

AppManager::Check - The great new AppManager::Check!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SUBROUTINES/METHODS

=head2 status

 perl app-manager.pl -a status -n hello-world-web  --configfile script/app-manager.conf 

 OK - hello-world-web application for virtual host localhost

 Context: /hello-world-web
 Status: running
 Sessions: 1
 Name: hello-world-web

=cut

sub check{
    my($package, $self) = @_;
    my $name = $self->name;

    $self->{client}->GET('/manager/text/list');
    my $response = $self->{client}->responseContent();

    my ($context, $state, $sessions, $app) = split /:/,  join('', grep {/$name/} split /\n/, $response);

    $context? say "Context: $context": say "Context: Not found";
    $state ? say "Status: $state": say "Status: Not defined";
    $sessions ? say "Sessions: $sessions": say "Sessions: 0";
    $app ? say "Name: $app": say "Application $name not installed";
}

=head1 AUTHOR

Vladimir Yourtaev, C<< <yourtaev at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-appmanager at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=AppManager>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc AppManager::Check


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=AppManager>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/AppManager>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/AppManager>

=item * Search CPAN

L<http://search.cpan.org/dist/AppManager/>

=back


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
1; # End of AppManager::Check
