package SOAP::WSDL::Transport::HTTP;
use strict;
use base qw(LWP::UserAgent);

# create methods normally inherited from SOAP::Client
SUBFACTORY: {
    no strict qw(refs);
    foreach my $method ( qw(code message status is_success) ) {
        *{ $method } = sub { 
            my $self = shift;
            return $self->{ $method } if not @_;
            return $self->{ $method } = shift;
        };
    }
}

sub send_receive {
    my ($self, %parameters) = @_;
    my ($envelope, $soap_action, $endpoint, $encoding, $content_type) =
        @parameters{qw(envelope action endpoint encoding content_type)};

    $encoding = defined($encoding) 
        ? 'utf8' 
        : lc($encoding);

    # what's this all about?
    # unfortunately combination of LWP and Perl 5.6.1 and later has bug
    # in sending multibyte characters. LWP uses length() to calculate
    # content-length header and starting 5.6.1 length() calculates chars
    # instead of bytes. 'use bytes' in THIS file doesn't work, because
    # it's lexically scoped. Unfortunately, content-length we calculate
    # here doesn't work either, because LWP overwrites it with
    # content-length it calculates (which is wrong) AND uses length()
    # during syswrite/sysread, so we are in a bad shape anyway.
    #
    # what to do? we calculate proper content-length (using
    # bytelength() function from SOAP::Utils) and then drop utf8 mark
    # from string (doing pack with 'C0A*' modifier) if length and
    # bytelength are not the same

    # use bytes is lexically scoped
    my $bytelength = do { use bytes; length $envelope };
    $envelope = pack('C0A*', $envelope) 
        if length($envelope) != $bytelength;

    my $request = HTTP::Request->new( 'POST',
        $endpoint,
        [   'Content-Type', "$content_type; charset=$encoding",
            'Content-Length', $bytelength,
            'SOAPAction', $soap_action,
        ],
        $envelope );
  
    my $response = $self->request( $request );

    $self->code( $response->code);
    $self->message( $response->message);
    $self->is_success($response->is_success);
    $self->status($response->status_line);
    
    return $response->content();    
}

1;

=pod

=head1 NAME

SOAP::WSDL::Transport::HTTP - Fallback http(s) transport class

=head1 DESCRIPTION

Provides a thin transport class used by SOAP::WSDL::Transport when 
SOAP::Lite is not available.

=head1 LICENSE

Copyright 2004-2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under 
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 288 $
 $LastChangedBy: kutterma $
 $Id: HTTP.pm 288 2007-09-29 19:34:20Z kutterma $
 $HeadURL: http://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Transport/HTTP.pm $
 
=cut

