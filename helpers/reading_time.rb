# Thanks to http://torspark.com/how-to-calculate-article-reading-time-with-a-custom-middleman-extension/
module ReadingTime
  def reading_time(input)
    words_per_minute = 180

    words = input.split.size
    minutes = (words / words_per_minute).floor
    "#{minutes} min read"
  end
end
