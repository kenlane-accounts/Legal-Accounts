module TransfersHelper
    def render_transpecific_data_for(transfer)
        file_name = "#{simplify_transfer_class(transfer.type).downcase.last(3)}_table_data.html.erb"
        render partial: file_name, locals: { transfer: transfer }
    end
    
    def simplify_transfer_class(class_name)
        class_name.sub /\w+::/, ''
    end
end
