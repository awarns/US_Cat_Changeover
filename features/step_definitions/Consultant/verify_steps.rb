require 'rubygems'
require 'win32ole'
require 'watir'


Given /^I Verify All Personalization Options$/ do

  @rows = 92
  @count = 1

  @country = "US"

  while @rows < 140

    embroidery
    iconitnotext
    iconitwithtext
    none


    @rows = @rows + 1

  end




end