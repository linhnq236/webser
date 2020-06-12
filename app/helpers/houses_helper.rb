module HousesHelper
  def convert_address_to_number string
    arr = string.split(" ");
    return arr[0]
  end

  def convert_address_to_road string
    arr = string.split(" ");
    return arr[1..arr.size].join(" ")
  end
end
