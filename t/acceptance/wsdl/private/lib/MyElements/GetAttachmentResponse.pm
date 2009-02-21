
package MyElements::GetAttachmentResponse;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://tempuri2.org/' }

__PACKAGE__->__set_name('GetAttachmentResponse');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %GetAttachmentResult_of :ATTR(:get<GetAttachmentResult>);

__PACKAGE__->_factory(
    [ qw(        GetAttachmentResult

    ) ],
    {
        'GetAttachmentResult' => \%GetAttachmentResult_of,
    },
    {
        'GetAttachmentResult' => 'MyTypes::GetFileResponse',
    },
    {

        'GetAttachmentResult' => 'GetAttachmentResult',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

MyElements::GetAttachmentResponse

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
GetAttachmentResponse from the namespace http://tempuri2.org/.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * GetAttachmentResult

 $element->set_GetAttachmentResult($data);
 $element->get_GetAttachmentResult();




=back


=head1 METHODS

=head2 new

 my $element = MyElements::GetAttachmentResponse->new($data);

Constructor. The following data structure may be passed to new():

 {
   GetAttachmentResult =>  { # MyTypes::GetFileResponse
     item =>  { # MyTypes::SerializedItem
       Attachments =>  { # MyTypes::ArrayOfString1
         Attachment =>  $some_value, # string
       },
       Fields =>  { # MyTypes::ArrayOfField
         Field => ,
       },
     },
     properties =>  { # MyTypes::SerializedItem
       Attachments =>  { # MyTypes::ArrayOfString1
         Attachment =>  $some_value, # string
       },
       Fields =>  { # MyTypes::ArrayOfField
         Field => ,
       },
     },
     data =>  $some_value, # base64Binary
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut
