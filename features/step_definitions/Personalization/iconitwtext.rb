def iconitwithtext


  iconarray = ["Baseball", "Basketball", "Butterfly", "Football","Paw Print", "Soccer Ball", "Tiara", "3D Stars", "Auto Racer", "Chick", "Daisy"]
  iconcolorarray = ["Aqua", "Black", "Brown", "Breezy Blue", "Burgundy", "Burnt Orange", "Coral Pink", "Forest Green", "Golden Yellow", "Hot Pink", "Kelly Green", "Lavender", "Lime Green", "Limeaid","Lemon Yellow", "Maroon", "Navy Blue", "Oatmeal", "Orange", "Platinum", "Powder Pink", "Purple", "Raspberry", "Red", "Royal Blue", "Sunset Gold", "Tangerine", "Turquoise", "White" ]
  iconfontstylearray = ['10', '12', '13', '15', '17', '19']


  if @count == 3


    browser2 = @browser.frame(:name, "order_top")


    browser2.text_field(:id, "Itemcode").set(@productid)
    browser2.text_field(:id, "QuantityList").set("1")
    browser2.button(:value, "Add To Order").click




    browser2 = @browser.frame(:name, "order_bottom")
    sleep(2)
    browser2.select_list(:index, 0).wait_until_present
    browser2.select_list(:index, 0).select(/.*Icon-It with Text.*/)
    sleep(2)

    browser2.select_list(:index, 1).wait_until_present
    arr = browser2.select_list(:index, 1).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort
    iconarray = iconarray.sort
    iconcolorarray = iconcolorarray.sort

    if iconarray != ary and @target_off_date != '2013-12-21 00:00:00 -0500'


      puts "SKU #{@productid} - Icon It With Text - Icon's Options are wrong"

    end

    arr = browser2.select_list(:index, 2).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort


    if iconcolorarray != ary and @target_off_date != '2013-12-21 00:00:00 -0500'

      puts "SKU #{@productid} - Icon It With Text - Icon Colors are wrong"

    end

    arr = browser2.select_list(:index, 3).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort


    if iconcolorarray != ary and @target_off_date != '2013-12-21 00:00:00 -0500'

      puts "SKU #{@productid} - Icon It With Text - Icon Colors are wrong"

    end

    arr = browser2.select_list(:index, 4).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort


    if iconfontstylearray != ary and @target_off_date != '2013-12-21 00:00:00 -0500'

      puts "SKU #{@productid} - Icon It with Text - Font Style Options are wrong"


    end



    browser2.button(:value, "Cancel").click



  end



end

