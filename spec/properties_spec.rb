$: << File.join(File.expand_path(File.dirname(__FILE__)), "../../Scripts")
require "models"


describe Property do
  context "about type parsing" do
    it "should convert raw type 'string' to NSString" do
      prop = Property.new("name","string")
      prop.type.should == "NSString"
    
      prop = Property.new("name","text")
      prop.type.should == "NSString"
    end
  
    it "should convert raw type float in to float and double to double" do
      prop = Property.new("balance","float")
      prop.type.should == "float"
    
      prop = Property.new("balance","double")
      prop.type.should == "double"
    end

    it "should convert raw type integer or number to NSInteger" do
      prop = Property.new("balance","integer")
      prop.type.should == "NSInteger"
    
      prop = Property.new("balance","number")
      prop.type.should == "NSInteger"
    end
  
    it "should convert raw type decimal to NSNumber" do
      prop = Property.new("balance","decimal")
      prop.type.should == "NSNumber"
    end
  
  
    it "should convert raw type list to NSMutableArray" do
      prop = Property.new("balance","list")
      prop.type.should == "NSMutableArray"
    
      prop = Property.new("balance","array")
      prop.type.should == "NSMutableArray"
    
    end

    it "should convert raw type date,datetime and time to NSDate" do
      prop = Property.new("created_at","date")
      prop.type.should == "NSDate"
      prop = Property.new("created_at","datetime")
      prop.type.should == "NSDate"
      prop = Property.new("created_at","time")
      prop.type.should == "NSDate"
    
    end

    it "should convert raw type dict or dictionary to NSMutableDictionaty" do
      prop = Property.new("collection","dict")
      prop.type.should == "NSMutableDictionary"
    
      prop = Property.new("balance","dictionary")
      prop.type.should == "NSMutableDictionary"
    
    end
    it "should convert raw type bool to BOOL" do
      prop = Property.new("valid","bool")
      prop.type.should == "BOOL"
    
    end

  end
  
  context "about property in declaration block (.h) " do
  
    it "should declare variables without * before their names" do
      
      Property.new("value","integer").declare.should == "NSInteger value;"

      Property.new("value","float").declare.should == "float value;"
      Property.new("value","double").declare.should == "double value;"
      Property.new("valid","bool").declare.should == "BOOL valid;"
    
    end  

    it "should declare variables with * before their names" do
      
      Property.new("value","string").declare.should == "NSString *value;"
      Property.new("value","object").declare.should == "NSObject *value;"
      Property.new("value","array").declare.should  ==  "NSMutableArray *value;"
      Property.new("value","dict").declare.should   == "NSMutableDictionary *value;"
      Property.new("value","decimal").declare.should == "NSNumber *value;"
      Property.new("value","date").declare.should == "NSDate *value;"
  
    end  
    
    
  end

  context "about @property for each property" do
  
    it "should declare variables without * before their names" do
      
      Property.new("value","integer").at_property.should == "@property NSInteger value;"
      Property.new("value","float").at_property.should == "@property float value;"
      Property.new("value","double").at_property.should == "@property double value;"
      Property.new("valid","bool").at_property.should == "@property BOOL valid;"
    
    end  

    it "should declare variables with * before their names" do
      
      Property.new("value","string").at_property.should == "@property(retain, nonatomic) NSString *value;"
      Property.new("value","object").at_property.should == "@property(retain, nonatomic) NSObject *value;"
      Property.new("value","array").at_property.should  ==  "@property(retain, nonatomic) NSMutableArray *value;"
      Property.new("value","dict").at_property.should   == "@property(retain, nonatomic) NSMutableDictionary *value;"
      Property.new("value","decimal").at_property.should == "@property(retain, nonatomic) NSNumber *value;"
      Property.new("value","date").at_property.should == "@property(retain, nonatomic) NSDate *value;"
  
    end  
    
    
  end
  
  context "generating output files" do
    
    it "should generate .h file" do
      
    end
  end
end
