namespace :custom do
  desc "Send email"
  task :auto_send_email => :environment do
    puts "we aaaaaaaare herrrrrrrrrrrrrrrrrrrrre"
    Information.all.each do |a|
      NoticeMailer.notify_cost(a.id).deliver_now!
    end
  end
end
