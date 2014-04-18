module TM
end

require_relative 'tm/database/in_memory.rb'
Dir[File.dirname(__FILE__) + '/use_case/*.rb'].each {|file| require_relative file }
Dir[File.dirname(__FILE__) + '/tm/entities/*.rb'].each {|file| require_relative file }
