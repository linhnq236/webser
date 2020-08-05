class RemindersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "reminders_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
