require 'rubygems'
require 'win32ole'
require 'watir'


When /^I attach pers tree$/ do


  @browser= Watir::Browser.new :chrome
  @browser.goto("https://www.mythirtyone.ca/admin")
  @browser.text_field(:id, "ContentPlaceHolder1_txt_username").set("1387")
  @browser.text_field(:id, "ContentPlaceHolder1_txt_password").set("testing31")
  @browser.link(:id, "ContentPlaceHolder1_btnLogin").click

  @browser.goto("https://www.mythirtyone.ca/employee/admin/frm_product_Main.aspx")

  count = 2

  excel = WIN32OLE::new("excel.Application")
  wrkbook = excel.Workbooks.Open('C:\Users\awarns\Desktop\RibbonPersCA.xlsx')
  wrksheet = wrkbook.worksheets(1)
  wrksheet.select


  while count <220


    productid = wrksheet.Cells(count, "A").value
    perscode = wrksheet.Cells(count, "B").value

    @browser.text_field(:id, "txt_inv_code").set(productid)
    @browser.button(:value, "Add / Edit").click
    @browser.button(:value, "Personalization").click

    @browser.window(:url => /.*personalization.*/).use do

      @browser.text_field(:id, "txt_copy_from").set(perscode)
      @browser.button(:value,"Copy").click
      @browser.alert.ok
      @browser.window(:url => /.*personalization.*/).close

    end

    count = count + 1

  end

  wrkbook.close
  excel.quit

end