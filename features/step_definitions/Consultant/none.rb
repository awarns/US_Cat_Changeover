require 'rubygems'
require 'test/unit'
require 'win32ole'
require 'watir'


When(/^Place a Retail Order None and Verify Personalization$/) do


  rows = 520
  while rows <= 906


    @browser.goto("https://testpps.31gifts.corp/employee/admin/frm_orderchoose.aspx?OT=RO")

    @browser.text_field(:id, "ContentPlaceHolder1_idnobox").set("102091")
    @browser.button(:value, "Enter Order").click
    #@browser.text_field(:id, "ContentPlaceHolder1_ship_fname").set("Andy")
    #@browser.text_field(:id, "ContentPlaceHolder1_ship_lname").set("Warns")
    #@browser.text_field(:id, "ContentPlaceHolder1_shipping_info_txt_street_1").set("205 N. Nelson rd")
    #@browser.text_field(:id, "ContentPlaceHolder1_shipping_info_txtPostalCode").set("43219")
    while @browser.link(:id, "ContentPlaceHolder1_btn_save").exists?

      @browser.link(:id, "ContentPlaceHolder1_btn_save").click

    end

    sleep (1)
    browser2 = @browser.frame(:name, "order_top")
    browser2.select_list(:id, "PriceLevelList").select("Replacement Price")

    excel = WIN32OLE::new("excel.Application")
    wrkbook = excel.Workbooks.Open('C:\Users\awarns\Desktop\Summer 2013 Item Master Report.xlsx')
    wrksheet = wrkbook.worksheets(2)
    wrksheet.select


    productid = wrksheet.Cells(rows, "F").value
    #puts productid

    productid.to_s
    browser2.text_field(:id, "Itemcode").set(productid)
    browser2.text_field(:id, "QuantityList").set("1")
    browser2.button(:value, "Add To Order").click
    sleep(4)

    aw = @browser.frame(:name, "order_top").div(:class, "txt_warning")

    if   aw.text.include?("That")

      puts productid + "Is not allowed on this type of order"
      rows=rows+1


    elsif aw.text.include?("The")

      puts productid + "Is not allowed on this type of order"
      rows=rows+1

    else


      #browser2 = @browser.frame(:name,"order_bottom")
      #sleep(2)
      #browser2.select_list(:index,0).select("None")
      #sleep(2)
      #
      #
      #
      #browser2.button(:value,"Done Personalizing").click


      @browser.goto("https://testpps.31gifts.corp/employee/admin/frm_payment.aspx")


      #aw =  @browser.form(:id, "frm_payment").text
      #puts aw
      balance = @browser.table(:class, "normal").text
      arr = balance.split /[\$_]/

      @browser.form(:id, "frm_payment").link(:text, "+ Credit Card Payment").click
      @browser.text_field(:id, "txt_cno").set("4111111111111111")
      @browser.text_field(:id, "txt_cdate").set("1215")
      @browser.text_field(:id, "txt_camount").set(arr[3])
      @browser.button(:value, "Save Payment").click
      @browser.button(:value, "Save Order").wait_until_present
      @browser.button(:value, "Save Order").click

      sleep(6)
      ordernum = @browser.div(:id, "div_submit_out").text
      ordernum = ordernum.split /[\#_]/
      puts ordernum[1]


      rows=rows+1


    end


    wrkbook.close
    excel.quit

  end


end