def iconitnotext

  iconarray = ["Baseball", "Crown"]
  iconcolorarray = ["Aqua", "Black"]


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




    ary = arr[1..num].sort


    if iconarray != ary


      puts "SKU #{@productid} - Icon It w/o Text - Icon Options are wrong"

    end

    arr = browser2.select_list(:index, 2).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort


    if iconcolorarray != ary

      puts "SKU #{@productid} - Icon It w/o Text - Icon Colors are wrong"

    end



    browser2.button(:value, "Cancel").click



  end



end


