class Tranheads::Sinv < Tranhead
    belongs_to :case

    validates_presence_of :case
end
