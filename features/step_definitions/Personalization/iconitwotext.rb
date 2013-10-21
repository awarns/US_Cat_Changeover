def iconitnotext

  iconarray = ["Baseball", "Crown"]
  iconcolorarray = ["Aqua", "Black"]

  browser2 = @browser.frame(:name, "order_top")


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
  browser2.select_list(:index, 0).select("Icon-It w/o Text - add $7")
  sleep(2)


  arr = browser2.select_list(:index, 1).options.map(&:text)
  num = arr.count




  ary = arr[1..num].sort


  if iconarray != ary


    puts "SKU #{productid}, has an issue with Icon It No Text Icon's Options"

  end

  arr = browser2.select_list(:index, 2).options.map(&:text)
  num = arr.count


  ary = arr[1..num].sort


  if iconcolorarray != ary

    puts "SKU #{productid}, has an issue with Icon It No Text Icon Colors Available"

  end



  browser2.button(:value, "Cancel").click

end


