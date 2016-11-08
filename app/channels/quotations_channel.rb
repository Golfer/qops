class QuotationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_for 'quotations'
  end
end