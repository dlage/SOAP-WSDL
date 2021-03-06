package SOAP::WSDL::Port;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use base qw(SOAP::WSDL::Base);

our $VERSION = $SOAP::WSDL::VERSION;

my %binding_of :ATTR(:name<binding> :default<()>);
my %address_of :ATTR(:name<address> :default<()>);

1;
