def iconitwithtext


  iconarray = ["Baseball", "Crown"]
  iconcolorarray = ["Aqua", "Black"]
  iconfontstylearray = [10 ,12]


  if @count == 3


    browser2 = @browser.frame(:name, "order_top")


    browser2.text_field(:id, "Itemcode").set(@productid)
    browser2.text_field(:id, "QuantityList").set("1")
    browser2.button(:value, "Add To Order").click




    browser2 = @browser.frame(:name, "order_bottom")
    sleep(2)
    browser2.select_list(:index, 0).wait_until_present
    browser2.select_list(:index, 0).select("Icon-It with Text - add $10")
    sleep(2)

    browser2.select_list(:index, 1).wait_until_present
    arr = browser2.select_list(:index, 1).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort


    if iconarray != ary


      puts "SKU #{@productid} - Icon It With Text - Icon's Options are wrong"

    end

    arr = browser2.select_list(:index, 2).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort


    if iconcolorarray != ary

      puts "SKU #{@productid} - Icon It With Text - Icon Colors are wrong"

    end

    arr = browser2.select_list(:index, 3).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort


    if iconcolorarray != ary

      puts "SKU #{@productid} - Icon It With Text - Icon Colors are wrong"

    end

    arr = browser2.select_list(:index, 4).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort


    if iconfontstylearray != ary

      puts "SKU #{@productid} - Icon It with Text - Font Style Options are wrong"


    end



    browser2.button(:value, "Cancel").click



  end



end

