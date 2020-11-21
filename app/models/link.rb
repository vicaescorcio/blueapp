class Link < ApplicationRecord
  validates :original, presence: true, format: URI::regexp(%w[http https])
  validates :short_id, uniqueness: true

  before_validation :generate_short_id, on: :create

  ALPHABET =
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.split(//)

  def encode
    # from http://refactormycode.com/codes/125-base-62-encoding
    # with only minor modification
    return ALPHABET[0] if short_id.zero?

    s = ''
    base = ALPHABET.length
    while short_id.positive?
      s << ALPHABET[short_id.modulo(base)]
      self.short_id /= base
    end
    s.reverse
  end

  def self.decode(code)
    # based on base2dec() in Tcl translation
    # at http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
    i = 0
    base = ALPHABET.length
    code.each_char { |c| i = i * base + ALPHABET.index(c) }

    Link.find_by(short_id: i)
  end

  private

  def generate_short_id
    self.short_id = SecureRandom.random_number.to_s.split('.').last.to_i
  end
end
