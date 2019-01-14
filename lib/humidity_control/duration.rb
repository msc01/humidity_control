# Beautifies durations
module Duration
  def beautify(seconds)
    mm, ss = seconds.to_i.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
  end
end
