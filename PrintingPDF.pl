#!/usr/bin/perl

use PDF::API2;

sub printPDF {
    

    # Create a blank PDF file
    my $pdf = PDF::API2->new();
    
    # Add a blank page
    my $page = $pdf->page();

    # # Retrieve an existing page
    # $page = $pdf->openpage($page_number);

    # Set the page size
    $page->mediabox('Letter');

    # Add a built-in font to the PDF
    my $font = $pdf->corefont('Helvetica-Bold');
    
    

    # Add some text to the page
    my $text = $page->text();
    
    
    
    for ($i = 0;$i<=5;$i++) {
           $text->font($font, 20);
           $text->translate(100, (700 + 15*$i));
           $text->text($i);
    }

    # Save the PDF
    $pdf->saveas('Scores.pdf');
      return true;
    
}
1;