module ServicesHelper
  def getServiceName services, ser_id
    ser_name = services.find(ser_id)
    return ser_name.name
  end

  def getServiceCost services, ser_id
    ser_name = services.find(ser_id)
    return ser_name.cost
  end

  def sum_amount_cost amount, cost
    result = (amount.to_i)*(cost.to_i)
    return result
  end

  def use_electric_water old, new
    result = new.to_i - old.to_i
    return result
  end

  def getUseService service_id
    string = ''
    service_id.each do |ser|
      a = Service.find(ser)
      string += " #{a.name}, "
    end
    return string[0..(string.size-3)]
  end
end
