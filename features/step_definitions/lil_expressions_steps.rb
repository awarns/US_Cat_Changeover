When /^I validate lil expressions$/ do


  @server = "https://uatpps.toguat.local"

  @count = 1

  @rows = 1021

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

  @productid = @wrksheet.Cells(@rows, "F").value




end


  @master_count = 0

  while @master_count <= 1000

    capture_options
    @switch_pers_count = 1

    while @switch_pers_count <= 5

      lil_kids_complete_options
      @switch_pers_count = @switch_pers_count + 1

    end



  end



end