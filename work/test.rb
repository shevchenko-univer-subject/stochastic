p __FILE__

p File.dirname(__FILE__)
p Dir.entries('..')
require 'pathname'

p Pathname.new(__dir__).parent.join('lr3', 'tools')