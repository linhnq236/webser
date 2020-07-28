module RoomsHelper
  def get_inf_last_name name
    arr = name.split(" ")
    return arr[arr.size-1]
  end

  def get_info_first_name name
      sub = name.gsub(get_inf_last_name(name), "")
      return sub
  end

  def check_Info_first_name_nil infor
    if !infor.nil?
      return get_info_first_name(infor.name)
    end
  end

  def check_Info_last_name_nil infor
    if !infor.nil?
      return get_inf_last_name(infor.name)
    end
  end
  def check_Info_indentifycard_nil infor
    if !infor.nil?
      return infor.indentifycard
    end
  end
  def check_Info_birth_nil infor
    if !infor.nil?
      return infor.birth
    end
  end
  def check_Info_daterange_nil infor
    if !infor.nil?
      return infor.daterange
    end
  end
  def check_Info_phone1_nil infor
    if !infor.nil?
      return infor.phone1
    end
  end
  def check_Info_phone2_nil infor
    if !infor.nil?
      return infor.phone2
    end
  end
  def check_Info_email_nil infor
    if !infor.nil?
      return infor.email
    end
  end
  def check_Info_placerange_nil infor
    if !infor.nil?
      return infor.placerange
    end
  end
  def check_Info_permanent_nil infor
    if !infor.nil?
      return infor.permanent
    end
  end
  def check_Info_deposit_nil infor
    if !infor.nil?
      return infor.deposit
    end
  end
  def check_Info_note_nil infor
    if !infor.nil?
      return infor.note
    end
  end
  def check_Info_sex_nil infor, value
    if !infor.nil?
      if infor.sex == value
        return "selected"
      end
    end
  end

end
