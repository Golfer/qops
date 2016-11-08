module ApplicationHelper
  def twitterized_type(type)
    case type.to_sym
      when :alert
        'warning'
      when :error
        'danger'
      when :notice
        'info'
      when :success
        'success'
      when :timedout
        ''
      else
        type.to_s
    end
  end
end
