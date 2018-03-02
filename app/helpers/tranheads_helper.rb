module TranheadsHelper
    def render_specific_data_for(tranhead)
        file_name = "#{simplify_tranhead_class(tranhead.type).downcase}_table_data.html.erb"
        render partial: file_name, locals: { tranhead: tranhead }
    end
    
    def simplify_tranhead_class(class_name)
        class_name.sub /\w+::/, ''
    end
end
