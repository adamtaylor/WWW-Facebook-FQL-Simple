# ABSTRACT: Simple interface for making FQL requests.
package WWW::Facebook::FQL::Simple;

=head1 SYNOPSIS

    use WWW::Facebook::FQL::Simple;

    WWW::Facebook::FQL::Simple->query(
        query => 'SELECT like_count FROM link_stat WHERE url="http://twitter.com"'
    );

=head1 DESCRIPTION

A no nonesense, dead simple interface to for making FQL requests. This module
does not handle sessions or authentication so presumably some requests will not
work.

If your needs are more complex, you probably need L<WWW::Facebook::API> or
L<WWW::Facebook::FQL>.

=head1 METHODS

=cut

use strict;
use warnings;

use JSON;
use LWP::UserAgent;
use URI::Encode qw( uri_encode );
use Carp qw/croak/;

my $API_BASE = 'http://api.facebook.com/method/fql.query?format=json&query=';

=head2 query

    WWW::Facebook::FQL::Simple->query({
        query => 'SELECT like_count FROM link_stat WHERE url="http://twitter.com"'
    });

Returns a hash reference of the JSON returned from the API.

=cut

sub query {
    my $class = shift;
    my $args  = shift;

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    my $response = $ua->get( uri_encode( $API_BASE . $args->{query} ) );

    if ( $response->is_success ) {
        return decode_json $response->content;
    }
    else {
        croak $response->status_line;
    }

}

=head1 SEE ALSO

L<Facebook>, L<WWW::Facebook::API>, L<WWW::Facebook::FQL>

=cut

1;
