class Criteria
  def initialize(text)
    @text = text
  end

  def origin
    left_text
  end

  def destination
    right_text.lstrip
  end

  private

  def left_text
    @text.split(',')[0]
  end

  def right_text
    @text.split(',')[1]
  end
end
