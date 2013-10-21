require 'rubygems'





When /^I Personalize using Embroider with "([^"]*)" "([^"]*)" "([^"]*)"$/ do |thread, font, text|

  @index = 0

  if @browser.frame(:id,"frm_bottom").exists?

   @index = 1

  else

    puts "cannot find dropdown"

  end

  puts @index
  sleep(1)


  if @index == 0

    @browser.select_list(:index,0).select("Embroidery - add $7")
    @browser.select_list(:index,1).wait_until_present
    @browser.select_list(:index,1).select(thread)
    @browser.select_list(:index,2).select(font)
    @browser.text_field(:index,0).wait_until_present
    @browser.text_field(:index,0).set(text)
    @browser.link(:id, "btn_save").wait_until_present
    @browser.link(:id, "btn_save").click

  elsif @index == 1

    browser2 = @browser.frame(:id,"frm_bottom")
    puts browser2
    browser2.select_list(:index,0).select("Embroidery - add $7")
    browser2.select_list(:index,1).wait_until_present
    browser2.select_list(:index,1).select(thread)
    browser2.select_list(:index,2).select(font)
    browser2.text_field(:index,0).wait_until_present
    browser2.text_field(:index,0).set(text)
    browser2.link(:id, "btn_save").wait_until_present
    browser2.link(:id, "btn_save").click


  end



  if @browser.link(:href, "https://uatpps.31gifts.corp/forms/frm_items_orig.aspx").exists?

    @browser.link(:href, "https://uatpps.31gifts.corp/forms/frm_items_orig.aspx").click


  end


end

When /^I Personalize using Icon-It with "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)"$/ do |icon, iconcolor, threadcolor, font, text|

     @index = 0

  if @browser.frame(:id,"frm_bottom").exists?

    @index = 1

  else

    puts "cannot find dropdown"

  end

  puts @index
  sleep(1)

     if @index == 0

        @browser.td(:class, "table_pers_data_style").wait_until_present
        @browser.select_list(:index,0).select("Icon-It - add $10")
        @browser.select_list(:index,1).select(icon)
        @browser.select_list(:index,2).select(iconcolor)
        @browser.select_list(:index,3).select(threadcolor)
        @browser.select_list(:index,4).select(font)
        @browser.text_field(:index,0).set(text)
        @browser.link(:id, "btn_save").wait_until_present
        @browser.link(:id, "btn_save").click


     elsif @index == 1


       browser2 = @browser.frame(:id,"frm_bottom")
       puts browser2
       browser2.select_list(:index,0).select("Icon-It - add $10")
       sleep (1)
       browser2.select_list(:index,1).select(icon)
       browser2.select_list(:index,2).select(iconcolor)
       browser2.select_list(:index,3).select(threadcolor)
       browser2.select_list(:index,4).select(font)
       browser2.text_field(:index,0).wait_until_present
       browser2.text_field(:index,0).set(text)
       browser2.link(:id, "btn_save").wait_until_present
       browser2.link(:id, "btn_save").click


    end



  if @browser.link(:href, "https://uatpps.31gifts.corp/forms/frm_items_orig.aspx").exists?

    @browser.link(:href, "https://uatpps.31gifts.corp/forms/frm_items_orig.aspx").click


  end

end

When /^I Personalize using None$/ do


  @browser.table(:id, "mainTable").wait_until_present


  if @browser.td(:class, "table_pers_data_style").exists?

    @browser.select_list(:index, 0).select("None")
  else

    puts "page loading error"
  end

  @browser.link(:id, "btn_save").wait_until_present
  @browser.link(:id, "btn_save").click



  if @browser.link(:href, "https://uatpps.31gifts.corp/forms/frm_items_orig.aspx").exists?

    @browser.link(:href, "https://uatpps.31gifts.corp/forms/frm_items_orig.aspx").click


  end
end
