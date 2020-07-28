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

end
