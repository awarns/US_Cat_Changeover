When /^I setup products in the US$/ do

  @server = "https://productstageca.31gifts.corp/"


  @count = 1
  @rows = 839


  if @count == 1

    @browser= Watir::Browser.new :chrome
    @browser.goto("#{@server}/admin")
    @browser.text_field(:id, "ContentPlaceHolder1_txt_username").set("1387")
    @browser.text_field(:id, "ContentPlaceHolder1_txt_password").set("testing31")
    @browser.link(:id, "ContentPlaceHolder1_btnLogin").click
    @browser.goto("#{@server}/employee/admin/frm_product_Main.aspx")

    @excel = WIN32OLE::new("excel.Application")
    @wrkbook = @excel.Workbooks.Open('C:\Users\awarns\Desktop\product_setup_us.xlsx')
    @wrksheet = @wrkbook.worksheets(1)
    @wrksheet.select

    @count = 2

  end


  while @rows < 1105


    product_id = @wrksheet.Cells(@rows, "A").text
    product_description = @wrksheet.Cells(@rows, "B").text
    product_shopping_cart_code = @wrksheet.Cells(@rows, "C").text
    product_details = @wrksheet.Cells(@rows, "D").text
    product_category = @wrksheet.Cells(@rows, "E").text
    pricing_category = @wrksheet.Cells(@rows, "F").text
    product_type = @wrksheet.Cells(@rows, "G").text
    copy_pers_options_from = @wrksheet.Cells(@rows, "H").text
    product_code = @wrksheet.Cells(@rows, "I").text
    color_print_choice = @wrksheet.Cells(@rows, "J").text
    design_options = @wrksheet.Cells(@rows, "K").text


    @browser.text_field(:id, "txt_inv_code").set(product_id)

    @browser.button(:value, "Add / Edit").click

    @browser.text_field(:id, "desc").set(product_description)
    @browser.text_field(:id, "txt_sort_code").set(product_shopping_cart_code)

    if product_details != ""

      @browser.text_field(:id, "detail").set(product_details)

    end

    @browser.select_list(:id, "ddl_itemCat").select(product_category)
    @browser.select_list(:id, "ddl_price_cat").select(pricing_category)
    @browser.select_list(:id, "ddl_prodTypes").select(product_type)

    if copy_pers_options_from == ""

    else


      @browser.button(:value, "Personalization").click


      @browser.window(:url => /.*personalization.*/).use do


        @browser.text_field(:id, "txt_copy_from").set(copy_pers_options_from)
        @browser.button(:value, "Copy").click
        @browser.alert.ok
        @browser.window(:url => /.*personalization.*/).close

      end

    end


    if product_code != ""

      @browser.button(:value, "Selections").click

      @browser.window(:url => /.*selection.*/).use do

        if @browser.select_list(:id, "ddl_opt_1").exists? == true

          @browser.select_list(:id, "ddl_opt_1").select("Color or print choice")
          @browser.button(:value,"Save").click

        end

        @browser.link(:id, "lnk_add").click
        @browser.text_field(:id, "txt_choice_inv_code").set(product_code)
        @browser.select_list(:id, "ddl_choice_1").select(color_print_choice)

        if design_options != ""

          @browser.select_list(:id, "ddl_choice_2").select(design_options)

        end

        @browser.button(:value, "Save").click
        @browser.window(:url => /.*selection.*/).close

      end


    end


    @rows = @rows + 1

    @browser.button(:value,"Save").click


  end



end
