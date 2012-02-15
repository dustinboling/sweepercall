module PeopleHelper
  def no_separator
    options={:words_connector => '', :two_words_connector => '', :last_word_connector => ''}
  end
  
  def type_display(type)
    case type
      when 1
        "Email"
      when 2
        "SMS"
      when 3
        "Voice"
    end
  end
end
