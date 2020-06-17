module HomeHelper
  def get_field_address house
    address = ''
    house.each do |h|
      address = "#{h.address}, #{h.ward.name}, #{h.district.name}, #{h.city.name} "
    end
    return address
  end

  def get_fild_name_room room
    name = ''
    room.each do |h|
      name = h.name
    end
    return name
  end

  def get_fild_cost_room  room
    cost = ''
    room.each do |h|
      cost = h.cost
    end
    return cost
  end
end
