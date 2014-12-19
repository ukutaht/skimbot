class Skimism
  PHRASES_WITH_FREQUENCIES = [
    ['this guy', 8],
    ['got \'em', 7],
    ['wat', 6],
    ['boom got \'em', 4],
    ['wat bro', 3],
    ['whoa inappropiate', 3],
    [':watman:', 3],
    ['inappropriate', 3],
    [':thisguy:', 3],
    [':thisgal:', 3],
    ['watman', 2],
    ['what did you say to me?', 2],
    ['what for?', 2],
    [':boom: :goat: M', 2],
    [':skim:', 2],
    [':boom:',2]]


  PHRASES = PHRASES_WITH_FREQUENCIES.map(&:first)
  SHUT_UP_RESPONSE = 'whoa fine'
  ALLOWED_TO_SPEAK_RESPONSE = 'hey'
end
