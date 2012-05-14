Dir[File.dirname(__FILE__) + '/../../app/models/*.rb'].each {|file| puts "Requiring #{file}"; require file }

