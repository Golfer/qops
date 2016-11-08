class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  EXPIRES_IN = 12.hours
  DEFAULT_LIMIT_RECORD = 100
end
