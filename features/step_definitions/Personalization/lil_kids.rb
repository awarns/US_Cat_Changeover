def lil_kids

  @browser2 = @browser.frame(:name, "order_top")
  @browser2.select_list(:id, "PriceLevelList").select("Replacement Price")
  @browser2.text_field(:id, "Itemcode").set(@productid)
  @browser2.text_field(:id, "QuantityList").set("1")
  @browser2.button(:value, "Add To Order").click


  @index_count = 0

  @browser2 = @browser.frame(:name, "order_bottom")

  sleep(2)

  @browser2.select_list(:index, @index_count).select("Name below each Lil'")

  @index_count = @index_count + 1

end


def lil_kids_different_pers_option


  arr = @browser2.select_list(:index, @index_count).options.map(&:text)
  arr.shift


  while @browser2.select_list(:index, @index_count).exists? == true and arr.include?('Yes') == false

    num = rand(arr.count)
    option = arr[num]

    @browser2.select_list(:index, @index_count).select(option)
    @index_count = @index_count + 1

    arr = @browser2.select_list(:index, @index_count).options.map(&:text)
    arr.shift


  end



end

def lil_kids_complete_options

  kid_count = 1
  count = 1
  option_count = 1

  lil_kids

  puts @lil_kids_hash

  while kid_count <= 6 and @browser2.select_list(:index, @index_count).exists?


    arr = @browser2.select_list(:index, @index_count).options.map(&:text)
    arr.shift

    num = rand(arr.count)
    @kid_pet = arr[num]

    @browser2.select_list(:index, @index_count).select(@kid_pet)
    @index_count = @index_count + 1
    count = 1


    while @browser2.select_list(:index, @index_count).exists? == true and count == 1

      arr = @browser2.select_list(:index, @index_count).options.map(&:text)
      arr.shift

      if arr.include?('Yes') == true

        @browser2.select_list(:index, @index_count).select('Yes')
        @index_count = @index_count + 1

        option_count = 1
        count = 2
        kid_count = kid_count + 1


      else

        @browser2.select_list(:index, @index_count).select( @lil_kids_hash["#{@kid_pet}_option_#{option_count}"])
        @index_count = @index_count + 1
        option_count = option_count + 1


      end


    end



  end


  @master_count = @master_count + 1
  sleep(3)
  @browser2.button(:value, "Cancel").click


end

def capture_options

  lil_kids

  loop_count = 0
  kid_pet_count = 0
  option_count = 1

  @browser2 = @browser.frame(:name, "order_bottom")

  arr = @browser2.select_list(:index, @index_count).options.map(&:text)
  arr.shift

  kid_pet_count = arr.count

  @lil_kids_hash = Hash.new

  while loop_count < kid_pet_count


    count = 1
    sleep(2)
    arr = @browser2.select_list(:index, @index_count).options.map(&:text)
    arr.shift



    @kid_pet = arr[loop_count]

    @browser2.select_list(:index, @index_count).select(@kid_pet)
    sleep(2)


    @index_count = @index_count + 1

    while @browser2.select_list(:index, @index_count).exists? == true and count == 1

      arr = @browser2.select_list(:index, @index_count).options.map(&:text)
      arr.shift

      if arr.include?('Yes') == true

        @browser2.select_list(:index, @index_count).select('Yes')
        @index_count = @index_count + 1

        @browser2.button(:value, "Cancel").click

        lil_kids

        loop_count = loop_count + 1

        option_count = 1

        count = 2

      else

        num = rand(arr.count)
        option = arr[num]

        @browser2.select_list(:index, @index_count).select(option)

        @lil_kids_hash["#{@kid_pet}_option_#{option_count}"] = option
        option_count = option_count + 1
        @index_count = @index_count + 1

      end


    end





  end


  @browser2.button(:value, "Cancel").click


end


