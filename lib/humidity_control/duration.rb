# Beautifies durations
module Duration
  def beautify(seconds)
    mm, ss = seconds.to_i.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    "#{dd} Tag(en), #{hh} Stunde(n) #{mm} Minute(n) und #{ss} Sekunde(n)"
  end
end
