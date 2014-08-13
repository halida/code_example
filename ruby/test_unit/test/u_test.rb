require 'test/unit'

class UTest < Test::Unit::TestCase
  def setup
    @v = 12
  end

  def test_pass
    assert_equal @v, 12
  end

  def test_fail
    assert_equal @v, 1
  end
end
