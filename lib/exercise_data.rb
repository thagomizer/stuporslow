class ExerciseData
  # exercise Exercise
  # weights Array
  # raw_times Array
  # relative_times Array
  # overall_average
  # average_last_10
  # average_last 3
  # dates_and_rel_times Array of tuples
  # dates_and_weights Array of tuples

  attr_accessor :exercise, :weights, :raw_times, :rel_times, :overall_average,
    :last_10_average, :last_3_average, :dates, :goal

  def dates_and_rel_times
    @dates.map{ |d| "Date.UTC(#{d.year}, #{d.month}, #{d.day})" }.zip(rel_times).delete_if { |date, time| time.nil? }
  end

  def dates_and_weights
    @dates.map{ |d| "Date.UTC(#{d.year}, #{d.month}, #{d.day})" }.zip(weights)
  end

  def initialize
    self.weights   = []
    self.raw_times = []
    self.rel_times = []
  end
end
