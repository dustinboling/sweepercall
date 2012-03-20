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
  
  def link_to_twilio_client(name)
    account_sid = 'ACe079c3003a2c4a1d949806c681648262'
    auth_token = '85bcc52edb352a11a19b8de47b4437fb'
    capability = Twilio::Util::Capability.new(account_sid, auth_token)
    @token = capability.generate
  end
  
  def twilio_client_setup
    account_sid = 'ACe079c3003a2c4a1d949806c681648262'
    auth_token = '85bcc52edb352a11a19b8de47b4437fb'
    application_sid = 'AP652a6827c1f644d485d1176b8da8f176'
    
    capability = Twilio::Util::Capability.new(account_sid, auth_token)
    capability.allow_client_outgoing(application_sid)
    @token = capability.generate
  end
  
  def error_messages_for(object)
    render(:partial => 'shared/error_messages', :locals => {:object => object})  
  end
  
  def resolve_layout
    case action_name
    when "show"
      "agent"
    when "index", "new"
      "application"
    else
      "application"
    end
  end
  
end