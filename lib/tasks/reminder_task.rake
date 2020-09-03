namespace :reminder do
  desc "Send email when overduce pay the rent"
  task :reminder_rental => :environment do
    current_date = DateTime.now.to_date
    paytherents = Paytherent.where(status: 0)
    paytherents.each do |pay|
      date = (pay.created_at).strftime("%Y-%m-%d")
      result = (current_date.to_date - date.to_date).to_i
      if result > 3
        NoticeMailer.reminder_rental(pay.id).deliver_now!
      end
    end
  end
end
