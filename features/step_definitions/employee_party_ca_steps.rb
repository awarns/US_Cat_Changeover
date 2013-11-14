When /^I validate party items as an employee in Canada$/ do

  @server = "https://uatleaf.toguat.local"


  @count = 1
  @rows = 30

  if @count == 1

    @browser= Watir::Browser.new :chrome
    @browser.goto("#{@server}/admin")
    @browser.text_field(:id, "ContentPlaceHolder1_txt_username").set("1387")
    @browser.text_field(:id, "ContentPlaceHolder1_txt_password").set("testing31")
    @browser.link(:id, "ContentPlaceHolder1_btnLogin").click
    @browser.goto("#{@server}/employee/admin/frm_orderchoose.aspx")

    @browser.goto("#{@server}/employee/admin/frm_orderchoose.aspx?OT=CPT")

    @browser.text_field(:id, "ContentPlaceHolder1_idnobox").set("231211")
    @browser.button(:value, "Enter Order").click


    @excel = WIN32OLE::new("excel.Application")
    @wrkbook = @excel.Workbooks.Open('C:\Users\awarns\Desktop\Summer 2013 Item Master Report.xlsx')
    @wrksheet = @wrkbook.worksheets(2)
    @wrksheet.select

    @browser.text_field(:id, "ctl00_ContentPlaceHolder1_event_date_dateInput").set("6/6/2013")
    @browser.text_field(:id, "ContentPlaceHolder1_ship_fname").set("Andy")
    @browser.text_field(:id, "ContentPlaceHolder1_ship_lname").set("Warns")
    @browser.text_field(:id, "ContentPlaceHolder1_shipping_info_txt_street_1").set("205 N. Nelson Rd")
    sleep(2)
    @browser.text_field(:id, "ContentPlaceHolder1_shipping_info_txt_city").set("Columbus")
    @browser.text_field(:id, "ContentPlaceHolder1_shipping_info_txtPostalCode").set("N8N 1A1")
    while @browser.link(:id, "ContentPlaceHolder1_btn_save").exists?

      @browser.link(:id, "ContentPlaceHolder1_btn_save").click

    end


    sleep (1)

    browser2 = @browser.frame(:name, "order_top")

    browser2.link(:id, "HyperLink1").click
    @browser.text_field(:id, "ContentPlaceHolder1_ship_fname").set("Automation")
    @browser.text_field(:id, "ContentPlaceHolder1_ship_lname").set("Test")

    while @browser.link(:id, "ContentPlaceHolder1_btn_save").exists?

      @browser.browser.link(:id, "ContentPlaceHolder1_btn_save").click
      sleep(1)

    end


    @count = 2

  end




  while @rows < 1200

    if @count == 2


      product_price = @wrksheet.Cells(@rows, "AN").text
      @product_desc = @wrksheet.Cells(@rows, "G").text

      while product_price == "#N/A"

        @rows = @rows + 1
        product_price = @wrksheet.Cells(@rows, "AN").text

      end

      while @product_desc =~ /.*Collegiate.*/

        @rows = @rows + 1
        @product_desc = @wrksheet.Cells(@rows, "G").text

      end

      @productid = @wrksheet.Cells(@rows, "F").value



      browser2 = @browser.frame(:name, "order_top")

      browser2.text_field(:id, "Itemcode").set(@productid)
      browser2.text_field(:id, "QuantityList").set("1")
      browser2.button(:value, "Add To Order").click


      if @browser.text.include?('That item or description that you entered could not be found in our database and cannot be added to your order') or @browser.text.include?('The item that you entered is not allowed for this type of order')


        puts "SKU #{@productid} Could not be added to a party order through employee back office in Canada."

        @count = 2
        @rows = @rows + 1


      else

        @count = 2
        @rows = @rows + 1
        browser2 = @browser.frame(:name, "order_bottom")
        browser2.button(:value, "Cancel").click

      end

    end




  end





end