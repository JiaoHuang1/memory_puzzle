class Card
    ALPHA = ("A".."Z").to_a
    def initialize
        @value = ALPHA.sample
    end

    def reveal
        @value
    end

end
