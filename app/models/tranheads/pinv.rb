class Tranheads::Pinv < Tranhead
    belongs_to :supplier

    validates_presence_of :supplier
end
