require 'rubygems'
require 'win32ole'
require 'watir'


Given /^I Verify All Personalization Options$/ do

  @rows = 137
  @count = 1

  while @rows < 140

    embroidery
    iconitnotext
    iconitwithtext
    none


    @rows = @rows + 1

  end




end