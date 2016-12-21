namespace :export do
  desc "Prints Country.all in a seeds.rb way."
  task :seeds_format, [:model] => :environment do |t, args|
    if args[:model].present?
      klass = args[:model].constantize
      klass.order(:id).all.each do |i|
        puts "#{klass}.find_or_create_by(#{i.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id', 'birth_date', 'start_date', 'record_date', 'end_date', 'avatar_updated_at', 'banner_updated_at', 'show_day', 'file_updated_at', 'image_updated_at', 'reset_password_sent_at'].include?(key)}.to_s.gsub(/[{}]/,'')})"
      end
    else
      Rails.application.eager_load!
      klasses = ApplicationRecord.descendants

      klasses.each do |klass|
        unless klass.to_s.include?('City') || klass.to_s.include?('State') || klass.to_s.include?('Country')
          klass.order(:id).all.each do |i|
            puts "#{klass}.find_or_create_by(#{i.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id', 'birth_date', 'start_date', 'record_date', 'end_date', 'avatar_updated_at', 'banner_updated_at', 'show_day', 'file_updated_at', 'image_updated_at', 'reset_password_sent_at'].include?(key)}.to_s.gsub(/[{}]/,'')})"
          end
        end
      end
    end
  end
end
