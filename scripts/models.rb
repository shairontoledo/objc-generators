module Types
  OBJECTS_MAP = {
    /^(string|text)$/ => "NSString",
    /^object$/ => "NSObject",
    /^(list|array)$/ => "NSMutableArray",
    /^dict|dictionaty/ => "NSMutableDictionary",
    /^date|datetime|time$/ => "NSDate",
    /^decimal$/ => "NSNumber",
  }
  PRIMITIVES_MAP = {
    /^(number|integer)$/ => "NSInteger",
    /^float$/ => "float",
    /^double$/ => "double",
    /^bool$/ => "BOOL"
  }
  MAP = OBJECTS_MAP.merge PRIMITIVES_MAP
  
end


class Property
  attr_accessor :name, :type, :type_key
  def initialize(prop_name,type)
    @name = prop_name
    @type_key = Types::MAP.keys.select{|regexp| regexp =~ type }.first
    @type = Types::MAP[@type_key]
    raise "Unknown type '#{type}'" unless @type
  end
  
  def is_an_object?
    Types::OBJECTS_MAP.has_key? @type_key
  end
  
  def declare 
     if is_an_object?
      "#@type *#@name;"
     else
       "#@type #@name;"
     end
  end
  def at_property
    flags = (is_an_object?) ? "(retain, nonatomic)" : ""
    "@property#{flags} #{declare}"
  end
  
  def self.parse
    ARGV.map do |entry|
        name,type = entry.split(/:/)
        Property.new(name,type)
    end
  end
end

require 'erb'

module Make
  class ModelFiles
    attr_accessor :class_name, :properties
    def initialize(class_name, properties=[])

      @class_name, @properties= class_name, properties
    end
    
    def write_files
      %w(h m).each do |type|
        template_file =  File.join(File.expand_path(File.dirname(__FILE__)),"dot_#{type}.erb")
        dot_h = ERB.new(File.open(template_file).read, 0,"")
        body = dot_h.result(binding)
        fname = File.join(Dir.pwd,"#{@class_name}.#{type}")
        puts "new file #{fname}"
        File.open(fname,'w').write(body)
     end
    end
  end
  
end