Given /^I validate all business supplies$/ do


  @rows = 1111


  @count = 1

  while @count == 1

    @browser= Watir::Browser.new :chrome
    @browser.goto("https://testpps.31gifts.corp/")

    @browser.link(:text, "Consultant Login").click
    @browser.text_field(:id, "txt_username").set("102091")
    @browser.text_field(:id, "txt_password").set("testing31")
    @browser.link(:id, "MasterContentBody1_btnLogin").click
    @browser.link(:text, "Order").click
    @browser.link(:text, /.*Business.*/).click
    @browser.link(:id, "MasterContentBody1_btn_save").click

    excel = WIN32OLE::new("excel.Application")
    wrkbook = excel.Workbooks.Open('C:\Users\awarns\Desktop\Summer 2013 Item Master Report.xlsx')
    wrksheet = wrkbook.worksheets(2)
    wrksheet.select

    @count = 2

  end

  while @rows < 1130

    product_desc = wrksheet.Cells(@rows, "G").text


    while product_desc =~ /.*Canad.*/

      @rows = @rows + 1
      product_desc = wrksheet.Cells(@rows, "G").text

    end


    productid = wrksheet.Cells(@rows, "F").value
    product_price = wrksheet.Cells(@rows, "Y").text


    @browser.text_field(:id, "Itemcode").set(productid)
    @browser.button(:value,"Add/Lookup").click


    browser2 =  @browser.frame(:name, "frm_bottom")

    if browser2.table(:id => "DataGrid1").tr(:class => "table_data_style gv-item").table(:class => "gv").exists? == false

      puts productid + " Could not be added to a business supply order"

      @rows = @rows + 1

    else

      table_id = browser2.table(:id => "DataGrid1").tr(:class => "table_data_style gv-item").table(:class => "gv").tr(:class => "table_data_style gv-item").cell(:index => 0).text
      table_price =  browser2.table(:id => "DataGrid1").tr(:class => "table_data_style gv-item").table(:class => "gv").tr(:class => "table_data_style gv-item").cell(:index => 4).text


      if productid != table_id

        puts "Product ID " + productid + " Did not match what was on the order " + table_id

      end

      if  product_price != table_price

        puts "The Price for " + productid + " is wrong. Item master says it should be " + product_price + " But on the order it was " + table_price

      end

      browser2.link(:text => "Remove").click

      @rows = @rows + 1

    end





  end



end