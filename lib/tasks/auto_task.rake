namespace :custom do
  desc "Send email"
  task :auto_send_email => :environment do
    puts "we aaaaaaaare herrrrrrrrrrrrrrrrrrrrre"
    Information.delete_all
  end
end
