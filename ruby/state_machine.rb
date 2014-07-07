require 'state_machine'

class Person
  attr_accessor :married_at, :money

  state_machine :state, initial: :single do
    after_transition on: :married, do: :feed_family

    after_transition on: :married do |p, t|
      p.married_at = Time.now
    end

    after_transition on: :divorced do |p, t|
      p.money /= 2
    end

    event :marrage do
      transition [:single, :divorced] => :married
    end

    event :divorse do
      transition [:married] => :divorced
    end

    state :single, :divorced do
      def available?
        true
      end
    end

    state :married do
      def available?
        false
      end
    end

  end

  def initialize
    self.money = 3000
    super()
  end

  def feed_family
    self.money -= 1000
  end
end

def live
  p = Person.new
  p.marrage!
  p.divorse!
end

live
