namespace :reminder do
  desc "Send email"
  task :auto_notify_reminder => :environment do
    Information.all.each do |a|
      NoticeMailer.notify_cost(a.id).deliver_now!
    end
  end
end
