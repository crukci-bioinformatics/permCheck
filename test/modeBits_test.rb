require 'test_helper'

class ModeBitsTest < Minitest::Test
  def test_basic_validate
    assert ::ModeBits.valid?("rwxrwxrwx")
  end

  def test_basic_toStr
    assert_equal("rwxr-xr-x",ModeBits.num2txt(0755))
  end

  def test_basic_fromStr
    assert_equal(0755,ModeBits.txt2num("rwxr-xr-x"))
  end

  def test_illegal_fromStr
    x = assert_raises(ArgumentError) {ModeBits.txt2num("zork")}
    assert_equal("Mode string 'zork' is illegal.",x.message())
  end

end
