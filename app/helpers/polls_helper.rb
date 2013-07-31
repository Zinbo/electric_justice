module PollsHelper
  
      def link_to_add_fields(name, f)  
      new_object = Answer.new  
      fields = f.fields_for(Answer, new_object, :child_index => "new_#{Answer}") do |builder|  
        render('answer' + "_fields", :f => builder)  
      end  
      link_to_function(name, h("add_fields(this, #{escape_javascript(fields)})"))  
    end  
end
