module RoomsHelper
  def get_inf_last_name name
    arr = name.split(" ")
    return arr[arr.size-1]
  end

  def get_info_first_name name
      sub = name.gsub(get_inf_last_name(name), "")
      return sub
  end
end
