module NotifyMailerHelper
  def getNameInfor id
    infor = Information.where(id: id)
    infor.each do |inf|
      return inf.name
    end
  end
  def getEmailInfor id
    infor = Information.where(id: id)
    infor.each do |inf|
      return inf.email
    end
  end
end
