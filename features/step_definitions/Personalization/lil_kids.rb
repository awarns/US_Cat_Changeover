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

def capture_options

  lil_kids

  sleep(2)

  loop_count = 0
  kid_pet_count = 0
  option_count = 1

  @browser2 = @browser.frame(:name, "order_bottom")

  arr = @browser2.select_list(:index, @index_count).options.map(&:text)
  arr.shift

  kid_pet_count = arr.count

  @lil_kids_hash = Hash.new
  @lil_kids_count_hash = Hash.new

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

        sleep(2)

        @browser2.button(:value, "Cancel").click

        @lil_kids_count_hash["#{@kid_pet}"] = option_count

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
  puts "New Combination of Choices ---------------------------------------------"


end



def lil_kids_complete_options

  kid_count = 1
  count = 1
  option_count = 1



  lil_kids

  @message = ""
  @message_2 = ""

  while kid_count <= 6


    if kid_count == 6

      kid_count = kid_count + 1

    end

    sleep(3)

    if  @browser2.select_list(:index, @index_count).exists?

    arr = @browser2.select_list(:index, @index_count).options.map(&:text)
    arr.shift

    num = rand(arr.count)
    @kid_pet = arr[num]

    @browser2.select_list(:index, @index_count).select(@kid_pet)
    @index_count = @index_count + 1
    count = 1

    @message << "#{@kid_pet} - "

    else

    @message << "Error. Could not Find DropDown to select next Kid ***** FAILED \n"
    kid_count = 7


   end

    sleep(2)

    while @browser2.select_list(:index, @index_count).exists? == true and count == 1

      arr = @browser2.select_list(:index, @index_count).options.map(&:text)
      arr.shift

      if arr.include?('Yes') == true and @lil_kids_count_hash["#{@kid_pet}"] == option_count

        @browser2.select_list(:index, @index_count).select('Yes')
        @index_count = @index_count + 1

        option_count = 1
        count = 2
        kid_count = kid_count + 1
        @message << "\n"


      elsif arr.include?('Yes') == true and @lil_kids_count_hash["#{@kid_pet}"] != option_count

        @message << " ERROR - Could not add option #{@lil_kids_hash["#{@kid_pet}_option_#{option_count}"]} because dropdown for option did not present itself ***** FAILED \n"
        count = 2
        kid_count = 7

      else

        if arr.include?(@lil_kids_hash["#{@kid_pet}_option_#{option_count}"])

          @browser2.select_list(:index, @index_count).select(@lil_kids_hash["#{@kid_pet}_option_#{option_count}"])

          @message << " #{@lil_kids_hash["#{@kid_pet}_option_#{option_count}"]} - "

          if  option_count == 1

            if @kid_pet != "Boy" and @kid_pet != "Girl"

              @message_2 << "#{@kid_pet} - "

            else

              @message_2 << "#{@kid_pet} "

            end

          end

          if @kid_pet == "Boy" or @kid_pet == "Girl" and option_count == 2

            @message_2 << "(#{@lil_kids_hash["#{@kid_pet}_option_#{option_count}"]}) "

          elsif @kid_pet == "Boy" or @kid_pet == "Girl" and option_count == 5

            @message_2 << "(#{@lil_kids_hash["#{@kid_pet}_option_#{option_count}"]}) - "

          end


          @index_count = @index_count + 1
          option_count = option_count + 1


          else


          @message << "ERROR - #{@lil_kids_hash["#{@kid_pet}_option_#{option_count}"]} Could not be added because option was not in dropdown ***** FAILED "

          @index_count = @index_count + 1
          kid_count = 7
          option_count = @lil_kids_count_hash["#{@kid_pet}"]

        end

      end

    end

  end


  @master_count = @master_count + 1
  sleep(1)
  @browser2.button(:value, "Cancel").click
  puts @message
  puts @message_2
  @message_2 = ""


end



