require "sequel"

class Reservation < Sequel::Model
  alias_method :save!, :save
  plugin :validation_helpers

  def validate
    super
    validates_presence [:reserved_at, :from, :to]
  end

end
