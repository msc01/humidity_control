# Beautifies durations
module Duration
  def beautify(seconds)
    mm, ss = seconds.to_i.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    "#{dd} Tagen, #{hh} Stunden #{mm} Minuten und #{ss} Sekunden"
  end
end
