def iconitwithtext


  iconarray = ["Baseball", "Crown"]
  iconcolorarray = ["Aqua", "Blac"]
  iconfontstylearray = [10 ,12]

  browser2 = @browser.frame(:name, "order_top")
  browser2.select_list(:id, "PriceLevelList").select("Replacement Price")

  excel = WIN32OLE::new("excel.Application")
  wrkbook = excel.Workbooks.Open('C:\Users\awarns\Desktop\Summer 2013 Item Master Report.xlsx')
  wrksheet = wrkbook.worksheets(2)
  wrksheet.select


  productid = wrksheet.Cells(@rows, "F").value

  wrkbook.close
  excel.quit


  browser2.text_field(:id, "Itemcode").set(productid)
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


    puts "SKU #{productid}, has an issue with Icon It With Text Icon's Options"

  end

  arr = browser2.select_list(:index, 2).options.map(&:text)
  num = arr.count


  ary = arr[1..num].sort


  if iconcolorarray != ary

    puts "SKU #{productid}, has an issue with Icon It With Text Icon Color"

  end

  arr = browser2.select_list(:index, 3).options.map(&:text)
  num = arr.count


  ary = arr[1..num].sort


  if iconcolorarray != ary

    puts "SKU #{productid}, has an issue with Icon It With Text Icon Color"

  end

  arr = browser2.select_list(:index, 4).options.map(&:text)
  num = arr.count


  ary = arr[1..num].sort


  if iconfontstylearray != ary

    puts "SKU #{productid}, has an issue with Icon IT Font Style Options"


  end



  browser2.button(:value, "Cancel").click


end

