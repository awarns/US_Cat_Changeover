def none

  iconarray = ["Baseball", "Crown"]
  iconcolorarray = ["Aqua", "Black"]

  browser2 = @browser.frame(:name, "order_top")


  excel = WIN32OLE::new("excel.Application")
  wrkbook = excel.Workbooks.Open('C:\Users\awarns\Desktop\Summer 2013 Item Master Report.xlsx')
  wrksheet = wrkbook.worksheets(2)
  wrksheet.select


  productid = wrksheet.Cells(@rows, "F").value
  #puts productid

  wrkbook.close
  excel.quit

  browser2.text_field(:id, "Itemcode").set(productid)
  browser2.text_field(:id, "QuantityList").set("1")
  browser2.button(:value, "Add To Order").click

  browser2 = @browser.frame(:name, "order_bottom")
  sleep(2)
  browser2.select_list(:index, 0).select("None")
  sleep(2)


  browser2.button(:value, "Cancel").click

  @count = 2

end


