class LedstatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ledstatus_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
