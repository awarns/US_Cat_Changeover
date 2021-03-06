Given /^I validate items on a party order for canada$/ do
  @rows = 350


  @count = 1

  @server = "https://testleaf.31gifts.corp"

  while @count == 1

    @browser= Watir::Browser.new :chrome
    @browser.goto("#{@server}")

    @browser.link(:text, "Consultant Login").click
    @browser.text_field(:id, "txt_username").set("231211")

    @browser.text_field(:id, "txt_password").set("testing31")
    @browser.link(:id, "MasterContentBody1_btnLogin").click
    @browser.link(:text, "Order").click
    @browser.link(:text, /.*Party.*/).click

    @browser.text_field(:id, "ctl00_MasterContentBody1_event_date_dateInput").set("06/06/2013")
    @browser.text_field(:id, "MasterContentBody1_shipping_info_txt_street_1").set("205 N. Nelson rd.")
    @browser.text_field(:id, "MasterContentBody1_shipping_info_txtPostalCode").set("N8N 1A0")
    @browser.text_field(:id, "MasterContentBody1_ship_fname").set("Andy")
    @browser.text_field(:id, "MasterContentBody1_ship_lname").set("Warns")
    sleep(2)
    @browser.text_field(:id, "MasterContentBody1_shipping_info_txt_city").set("Toronto")



    while @browser.link(:id, "MasterContentBody1_btn_save").exists?

      @browser.link(:id, "MasterContentBody1_btn_save").click
      sleep(1)


    end

    @browser.link(:id, "lnk_add_guest").click
    @browser.text_field(:id, "MasterContentBody1_ship_fname").set("Automation")
    @browser.text_field(:id, "MasterContentBody1_ship_lname").set("Catalog")

    while @browser.link(:id, "MasterContentBody1_btn_save").exists?

      @browser.link(:id, "MasterContentBody1_btn_save").click
      sleep(1)

    end



    excel = WIN32OLE::new("excel.Application")
    wrkbook = excel.Workbooks.Open('C:\Users\awarns\Desktop\Summer 2013 Item Master Report.xlsx')
    wrksheet = wrkbook.worksheets(2)
    wrksheet.select

    @count = 2

  end

  while @rows < 714

    product_desc = wrksheet.Cells(@rows, "G").text


    while product_desc =~ /.*Collegiate.*/

      @rows = @rows + 1
      product_desc = wrksheet.Cells(@rows, "G").text

    end


    productid = wrksheet.Cells(@rows, "F").value
    product_price = wrksheet.Cells(@rows, "AO").text


    @browser.text_field(:id, "Itemcode").set(productid)
    @browser.button(:value,"Add/Lookup").click

    browser2 =  @browser.frame(:name, "frm_bottom")

    personalization_code = wrksheet.Cells(@rows, "T").text
    target_on_date = wrksheet.Cells(@rows, "K").text
    target_off_date = wrksheet.Cells(@rows, "L").text

    if personalization_code == "None"

      if browser2.table(:id => "DataGrid1").tr(:class => "gv-alt-item").table(:class => "gv").exists? == false

        if target_on_date == "9/1/13" or nil and target_off_date != "9/1/13" and product_price != "#N/A"

          puts "SKU #{productid} is not available on Party Orders in Canada but should be"

          @rows = @rows + 1

        else

          @rows = @rows + 1

        end

      else

        table_id = browser2.table(:id => "DataGrid1").tr(:class => "gv-alt-item").table(:class => "gv").tr(:class => "table_data_style gv-item").cell(:index => 0).text
        table_price =  browser2.table(:id => "DataGrid1").tr(:class => "gv-alt-item").table(:class => "gv").tr(:class => "table_data_style gv-item").cell(:index => 4).text

        if target_off_date == "9/1/13"

          puts "SKU #{productid} has an off date of #{target_off_date}, but is still available on Party Orders in Canada"

        end

        if product_price == "#N/A"

          puts "SKU #{productid} is available in Canada, but should not be"

        end


        if productid != table_id

          puts "Product ID " + productid + " Did not match what was on the order " + table_id

        end

        if  product_price != table_price

          puts "The Price for Sku " + productid + " is wrong in Canada. Item master says it should be " + product_price + " But on the order it was " + table_price

        end

        browser2.link(:text => "Remove").click

        @rows = @rows + 1

      end

    else


      if browser2.link(:name, "btn_save").exists? == false

        if target_on_date == "9/1/13" or nil and target_off_date != "9/1/13" and product_price != "#N/A"

          puts "SKU #{productid} is not available on Party Orders in Canada but should be"

          @rows = @rows + 1

        else

          @rows = @rows + 1

        end

      else

        sleep(3)
        browser2.select_list(:index, 0).select("None")
        browser2.link(:name, "btn_save").click

        table_id = browser2.table(:id => "DataGrid1").tr(:class => "gv-alt-item").table(:class => "gv").tr(:class => "table_data_style gv-item").cell(:index => 0).text
        table_price =  browser2.table(:id => "DataGrid1").tr(:class => "gv-alt-item").table(:class => "gv").tr(:class => "table_data_style gv-item").cell(:index => 4).text

        if target_off_date == "9/1/13"

          puts "SKU #{productid} has an off date of #{target_off_date}, but is still available on Party Orders in Canada"

        end

        if product_price == "#N/A"

          puts "SKU #{productid} is available in Canada on Party Orders, but should not be"

        end

        if productid != table_id

          puts "Product ID " + productid + " Did not match what was on the order " + table_id

        end

        if  product_price != table_price

          puts "The Price for SKU " + productid + " is wrong in Canada. Item master says it should be " + product_price + " But on the order it was " + table_price

        end

        browser2.link(:text => "Remove").click

        @rows = @rows + 1



      end


    end




  end




end