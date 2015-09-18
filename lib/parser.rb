class WrongFormatException < Exception; end
class DateAlreadyReserved < Exception; end
class DateMismatch < Exception; end


class Parser
  attr_writer :reserved_at, :from, :to
  attr_reader :reservation, :errors

  def initialize(params)
    @params = params["text"]
    @errors = Sequel::Model::Errors.new
  end

  def execute
    begin
      filter_params
    rescue WrongFormatException, DateAlreadyReserved, DateMismatch => e
      # byebug
      @errors.add(:error, e)
    end
  end

  def success?
    @success
  end

  private

  def filter_params
    raise WrongFormatException if format_invalid?
    raise DateAlreadyReserved if date_already_reserved?
    raise DateMismatch if date_mismatch?

    splited = @params.split('-')

    date = splited[0].split('/')
    @reserved_at = Date.new(Date.today.year, date[0].to_i, date[1].to_i)
    @from = splited[1]
    @to = splited[2]
    @reservation = Reservation.create(reserved_at: @reserved_at, from: @from, to: @to)
    @success = true
  end

  def format_invalid?
    true if @params.nil?
  end

  def date_already_reserved?
    false
  end

  def date_mismatch?
    false
  end

end
