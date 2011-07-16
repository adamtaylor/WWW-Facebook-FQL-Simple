# ABSTRACT: Simple interface for making FQL requests.
package WWW::Facebook::FQL::Simple;

use strict;
use warnings;

use JSON;
use LWP::UserAgent;
use URI::Encode qw( uri_encode );

my $API_BASE = 'http://api.facebook.com/method/fql.query?format=json&query=';

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
        die $response->status_line;
    }

}

1;
