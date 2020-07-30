module MembersHelper
  def getHouseRoom information_id
    room = Room.find_by_information_id(information_id)
    house = House.find(room.house_id)
    return "#{house.name} / Phong#{room.name}"
  end
end
