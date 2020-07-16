module MembersHelper
  def getHouseRoom information_id
    room = Room.find_by_information_id(information_id)
    # return "#{room.house.name} / Phong#{room.name}"
    return "Phong#{room.name}"
  end
end
