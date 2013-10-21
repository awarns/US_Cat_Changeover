require 'rubygems'
require 'win32ole'
require 'watir'



def embroidery


  if @count == 1

    @browser= Watir::Browser.new :chrome
    @browser.goto("https://testpps.31gifts.corp/admin")
    @browser.text_field(:id, "ContentPlaceHolder1_txt_username").set("1387")
    @browser.text_field(:id, "ContentPlaceHolder1_txt_password").set("testing31")
    @browser.link(:id, "ContentPlaceHolder1_btnLogin").click
    @browser.goto("https://testpps.31gifts.corp/employee/admin/frm_orderchoose.aspx")

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

  end





  colorarry = ["Aqua", "Black", "Brown"]
  fontarry = [10, 12, 13, 15]






    sleep (1)
    browser2 = @browser.frame(:name, "order_top")
    browser2.select_list(:id, "PriceLevelList").select("Replacement Price")

    excel = WIN32OLE::new("excel.Application")
    wrkbook = excel.Workbooks.Open('C:\Users\awarns\Desktop\Summer 2013 Item Master Report.xlsx')
    wrksheet = wrkbook.worksheets(2)
    wrksheet.select


    productid = wrksheet.Cells(@rows, "F").value
    puts productid

    wrkbook.close
    excel.quit

    browser2.text_field(:id, "Itemcode").set(productid)
    browser2.text_field(:id, "QuantityList").set("1")
    browser2.button(:value, "Add To Order").click

    browser2 = @browser.frame(:name, "order_bottom")
    sleep(2)
    browser2.select_list(:index, 0).select("Embroidery - add $7")
    sleep(1)


    arr = browser2.select_list(:index, 1).options.map(&:text)
    num = arr.count


    ary = arr[1..num].sort


    if colorarry != ary

      puts "SKU #{productid} has an issue with Embroidery Thread Color"

    end


    browser2.select_list(:index, 1).select(ary[2])


    arr = browser2.select_list(:index, 2).options.map(&:text)
    num = arr.count

    ary = arr[1..num].sort


    if fontarry != ary

      puts "SKU #{productid} has an issue with Embroidery Font Style's Available"

    end


    browser2.select_list(:index, 2).select("30")
    sleep(1)
    browser2.text_field(:index, 0).set("amw")


    browser2.button(:value, "Cancel").click



end