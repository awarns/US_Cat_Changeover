def lil_kids


  @browser2 = @browser.frame(:name, "order_bottom")

  @index_count = 0

  @browser2.select_list(:index, @index_count).select("Name below each Lil'")

  @index_count = @index_count + 1






end

def lil_kids_2

  arr = @browser2.select_list(:index, @index_count).options.map(&:text)
  arr.shift
  num = rand(arr.count)


  @kid_pet = arr[num]

  @browser2.select_list(:index, @index_count).select(@kid_pet)

  @index_count = @index_count + 1


end

def lil_kids_initial_options

  @lil_kids_array = []

  count = 1

  while @browser2.select_list(:index, @index_count).exists? == true and count == 1

    arr = @browser2.select_list(:index, @index_count).options.map(&:text)
    arr.shift

    if arr.include?('Yes') == true

      @browser2.select_list(:index, @index_count).select('Yes')
      @index_count = @index_count + 1

      count = 2

    else

      num = rand(arr.count)
      option = arr[num]

      @browser2.select_list(:index, @index_count).select(option)

      @lil_kids_array.push(option)
      @index_count = @index_count + 1

    end


  end


end

def lil_kids_complete_options

  array_count = 0
  count = 1
  option_count = 2


  while option_count < 6

    @browser2.select_list(:index, @index_count).select(@kid_pet)
    @index_count = @index_count + 1


    while @browser2.select_list(:index, @index_count).exists? == true and count == 1

      arr = @browser2.select_list(:index, @index_count).options.map(&:text)
      arr.shift


      if arr.include?('Yes') == true

        @browser2.select_list(:index, @index_count).select('Yes')
        @index_count = @index_count + 1

        @browser2.select_list(:index, @index_count).select(@kid_pet)
        @index_count = @index_count + 1
        array_count = 0
        option_count = option_count + 1

      else

        @browser2.select_list(:index, @index_count).select(@lil_kids_array[array_count])
        @index_count = @index_count + 1

        if array_count != @lil_kids_array.count

          array_count = array_count + 1

        end

      end


    end

  end

end