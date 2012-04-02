module ApplicationHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => 'btn btn-danger')
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => 'btn btn-warning')
  end
  
  def twilio_client_setup
    account_sid = 'ACbc18a2ac1712bd298d743d0f395defc4'
    auth_token = 'cccf865524c94ab9dff4de6cc98d70c3'
    application_sid = 'AP7df5bb8e358f412daa214dcf0f30edba'
    
    capability = Twilio::Util::Capability.new(account_sid, auth_token)
    capability.allow_client_outgoing(application_sid)
    @token = capability.generate
  end
  
  def error_messages_for(object)
    render(:partial => 'shared/error_messages', :locals => {:object => object})  
  end
  
end
