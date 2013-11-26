def iconitnotext

  iconarray = ["Baseball", "Basketball", "Butterfly", "Football", "Paw Print", "Soccer Ball", "Tiara", "3D Stars", "Auto Racer", "Chick", "Daisy"]
  iconcolorarray = ["Aqua", "Black", "Brown", "Breezy Blue", "Burgundy", "Burnt Orange", "Coral Pink", "Forest Green", "Golden Yellow", "Hot Pink", "Kelly Green", "Lavender", "Lime Green", "Limeaid","Lemon Yellow", "Maroon", "Navy Blue", "Oatmeal", "Orange", "Platinum", "Powder Pink", "Purple", "Raspberry", "Red", "Royal Blue", "Sunset Gold", "Tangerine", "Turquoise", "White" ]



  if @count == 3

    browser2 = @browser.frame(:name, "order_top")


    browser2.text_field(:id, "Itemcode").set(@productid)
    browser2.text_field(:id, "QuantityList").set("1")
    browser2.button(:value, "Add To Order").click
    browser2 = @browser.frame(:name, "order_bottom")
    sleep(2)
    browser2.select_list(:index, 0).select("Icon-It w/o Text - add $7")
    sleep(2)


    arr = browser2.select_list(:index, 1).options.map(&:text)
    num = arr.count



    iconarray = iconarray.sort
    iconcolorarray = iconcolorarray.sort
    ary = arr[1..num].sort


    if iconarray != ary and @target_off_date != '2013-12-21 00:00:00 -0500'


      puts "SKU #{@productid} - Icon It w/o Text - Icon Options are wrong"

    end

    arr = browser2.select_list(:index, 2).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort


    if iconcolorarray != ary and @target_off_date != '2013-12-21 00:00:00 -0500'

      puts "SKU #{@productid} - Icon It w/o Text - Icon Colors are wrong"

    end



    browser2.button(:value, "Cancel").click



  end



end


