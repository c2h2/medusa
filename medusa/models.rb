Dir[File.dirname(__FILE__) + '/../rails/app/models/*.rb'].each {|file| puts "Requiring #{file}"; require file }
