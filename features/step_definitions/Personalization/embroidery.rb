require 'rubygems'
require 'win32ole'
require 'watir'



def embroidery


  @server = "https://uatpps.toguat.local"



  colorarry = ["Aqua", "Black", "Brown"]
  fontarry = [10, 12, 13, 15]


  if @count == 1

    @browser= Watir::Browser.new :chrome
    @browser.goto("#{@server}/admin")
    @browser.text_field(:id, "ContentPlaceHolder1_txt_username").set("1387")
    @browser.text_field(:id, "ContentPlaceHolder1_txt_password").set("testing31")
    @browser.link(:id, "ContentPlaceHolder1_btnLogin").click
    @browser.goto("#{@server}/employee/admin/frm_orderchoose.aspx")

    @browser.goto("#{@server}/employee/admin/frm_orderchoose.aspx?OT=RO")

    @browser.text_field(:id, "ContentPlaceHolder1_idnobox").set("102091")
    @browser.button(:value, "Enter Order").click


    @excel = WIN32OLE::new("excel.Application")
    @wrkbook = @excel.Workbooks.Open('C:\Users\awarns\Desktop\Summer 2013 Item Master Report.xlsx')
    @wrksheet = @wrkbook.worksheets(2)
    @wrksheet.select

    while @browser.link(:id, "ContentPlaceHolder1_btn_save").exists?

      @browser.link(:id, "ContentPlaceHolder1_btn_save").click

    end


    sleep (1)


    @count = 2

  end


   if @count == 2



     @product_desc = @wrksheet.Cells(@rows, "G").text

     while product_price == "#N/A" and @country == "CA"

       @rows = @rows + 1
       product_price = @wrksheet.Cells(@rows, "AN").text

     end


     while @product_desc =~ /.*Collegiate.*/

       @rows = @rows + 1
       @product_desc = @wrksheet.Cells(@rows, "G").text


     end

     @productid = @wrksheet.Cells(@rows, "F").value

     browser2 = @browser.frame(:name, "order_top")
     browser2.select_list(:id, "PriceLevelList").select("Replacement Price")

     browser2.text_field(:id, "Itemcode").set(@productid)
     browser2.text_field(:id, "QuantityList").set("1")
     browser2.button(:value, "Add To Order").click


     if @browser.text.include?('That item or description that you entered could not be found in our database and cannot be added to your order') or @browser.text.include?('The item that you entered is not allowed for this type of order')



       puts "SKU #{@productid} Could not be added to a replacement Order."

       @count = 2


     else

       @count = 3

     end

   end


    if @count == 3


      browser2 = @browser.frame(:name, "order_bottom")
      sleep(2)
      browser2.select_list(:index, 0).select("Embroidery - add $7")
      sleep(1)


      arr = browser2.select_list(:index, 1).options.map(&:text)
      num = arr.count


      ary = arr[1..num].sort


      if colorarry != ary

        puts "SKU #{@productid} - Embroidery - Thread Colors are wrong"

      end


      browser2.select_list(:index, 1).select(ary[2])


      arr = browser2.select_list(:index, 2).options.map(&:text)
      num = arr.count

      ary = arr[1..num].sort


      if fontarry != ary

        puts "SKU #{@productid} - Embroidery - Font Style's are wrong"

      end


      browser2.select_list(:index, 2).select("30")
      sleep(1)
      browser2.text_field(:index, 0).set("amw")


      browser2.button(:value, "Cancel").click


    end

end