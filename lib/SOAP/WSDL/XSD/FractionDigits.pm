package SOAP::WSDL::XSD::FractionDigits;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::Base);

our $VERSION = $SOAP::WSDL::VERSION;
#<pattern value="">

# id provided by Base
# name provided by Base
# annotation provided by Base

# may be defined as atomic simpleType
my %value_of        :ATTR(:name<value> :default<()>);

1;
