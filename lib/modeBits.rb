module ModeBits

  MODEPAT = /^((r|-)(w|-)(x|-)){3}$/
  READ = 4
  WRITE = 2
  EXE = 1

  def self.valid?(mode)
    return (MODEPAT =~ mode).nil? ? false : true
  end

  def self.txt2num(mode)
    if !valid?(mode)
      raise ArgumentError, "Mode string '#{mode}' is illegal."
    end
    result = 0
    (0..2).each do |i|
      n = ((mode[-3]=='r') ? READ : 0) +
          ((mode[-2]=='w') ? WRITE : 0) +
          ((mode[-1]=='x') ? EXE : 0)
      result = result | (n << i*3)
      mode = mode[0..-4]
    end
    return result
  end

  def self.num2txt(imode)
    groups = []
    (1..3).each do
      txt = ((imode&READ)>0?'r':'-') +
            ((imode&WRITE)>0?'w':'-') +
            ((imode&EXE)>0?'x':'-')
      groups << txt
      imode = imode >> 3
    end
    txt = groups.reverse.join
    return txt
  end


end
