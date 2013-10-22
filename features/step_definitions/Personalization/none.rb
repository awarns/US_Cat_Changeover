def none


  if @count == 3

    browser2 = @browser.frame(:name, "order_top")

    browser2.text_field(:id, "Itemcode").set(@productid)
    browser2.text_field(:id, "QuantityList").set("1")
    browser2.button(:value, "Add To Order").click

    browser2 = @browser.frame(:name, "order_bottom")
    sleep(2)
    browser2.select_list(:index, 0).select("None")
    sleep(2)


    browser2.button(:value, "Cancel").click

    @count = 2



  end



end


