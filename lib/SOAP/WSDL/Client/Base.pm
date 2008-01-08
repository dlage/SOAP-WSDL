package SOAP::WSDL::Client::Base;
use strict;
use warnings;
use base 'SOAP::WSDL::Client';
use Scalar::Util qw(blessed);

our $VERSION = '2.00_25';

sub call {
    my ($self, $method, $body, $header) = @_;
    if (not blessed $body) {
        $body = {} if not defined $body;
        $body = ref $body eq 'ARRAY' ? $body : [ $body ];
        my $index = 0;
        my @part_from;
        foreach my $part (@{ $body }) {
            my $class = $method->{ body }->{ parts }->[$index];
            eval "require $class" || die $@;
            push @part_from, $class->new($part);
            $index++;
        }
        $body = $#part_from ? \@part_from : $part_from[0];
    }

    # if we have a header
    if (%{ $method->{ header } }) {
        if (not blessed $header) {
            my $class = $method->{ header }->{ parts }->[0];
            eval "require $class" || die $@;
            $header = $class->new($header);
        }
    }
    return $self->SUPER::call($method, $body, $header);
}

#sub __create_methods {
#    my ($package, %info_of) = @_;
#
#    no strict qw(refs);
#    no warnings qw(redefine);
#    for my $method (keys %info_of){
#    my ($soap_action, @parts);
#
#    # up to 2.00_10 we had list refs...
#    if (ref $info_of{ $method }eq 'HASH') {
#        @parts = @{ $info_of{ $method }->{ parts } };
#        $soap_action = $info_of{ $method }->{ soap_action };
#    }
#    else {
#        die "Pre-v2.00_10 Interfaces are no longer supported. Please re-generate your interface.";
#    }
#
#    *{ "$package\::$method" } = sub {
#        my $self = shift;
#        my @param = map {
#            my $data = shift || {};
#            eval "require $_";
#            $_->new( $data );
#        } @parts;
#
#        return $self->SUPER::call( {
#            operation => $method,
#            soap_action => $soap_action,
#        }, @param );
#      }
#  }
#}

1;

__END__

=pod

=head1 NAME

SOAP::WSDL::Client::Base - Factory class for WSDL-based SOAP access

=head1 SYNOPSIS

 package MySoapInterface;
 use SOAP::WSDL::Client::Base;
 __PACKAGE__->__create_methods( qw(one two three) );
 1;

=head1 DESCRIPTION

Factory class for creating interface classes. Should probably be renamed to
SOAP::WSDL::Factory::Interface...

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under the same
terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 440 $
 $LastChangedBy: kutterma $
 $Id: Base.pm 440 2007-12-04 22:24:33Z kutterma $
 $HeadURL: http://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Client/Base.pm $

=cut