require "sequel"

class Reservation < Sequel::Model

  alias_method :save!, :save
  plugin :validation_helpers
  plugin :json_serializer

  def validate
    super
    validates_presence [:reserved_at, :from, :to]
  end

end
