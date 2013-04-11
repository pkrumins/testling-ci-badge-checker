#!/usr/bin/perl
#

use warnings;
use strict;

use WWW::Mechanize;
use List::Util qw/min/;
use JSON;

use async_retry qw/async_retry/;

$|++;

sub main {
    my $mech = WWW::Mechanize->new;
    $mech->get('http://ci.testling.com/commits.json');
    unless ($mech->success) {
        die "failed getting commits.json: " . $mech->status;
    }
    my $commits = decode_json($mech->content);
    my @github_urls;
    for my $commit (@$commits) {
        my $github_url = "https://github.com/" . $commit->{key};
        $github_url =~ s/\.git$//;
        push @github_urls, $github_url;
    }

    my $have_badge = 0;
    my $total_urls = scalar @github_urls;
    my $processed_urls = 0;

    while (@github_urls) {
        async_retry(
            {
                retries => 5,
                timeout => 10,
                max_request_time => 20
            },
            [
                map { HTTP::Request->new(GET => $_) } @github_urls[0..min(10, scalar @github_urls)]
            ],
            sub {
                my ($req, $res) = @_;
                if ($res->is_success) {
                    if ($res->content =~ /ci.testling.com.*png/) {
                        $have_badge++; 
                        print "@{[$res->base]} as a badge (total repos having badges: $have_badge)\n"
                    }
                }
                $processed_urls++;
            }
        );
        splice(@github_urls, 0, 10);
        print "Processed: $processed_urls/$total_urls\n";
    }

    print "Stats: $have_badge repos have the testling-ci badge\n";
}

main();
