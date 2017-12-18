

Block = BlockchainLite::ProofOfWork::Block

## see https://github.com/openblockchains/blockchain.lite.rb/blob/master/lib/blockchain-lite/proof_of_work/block.rb

######
## add more methods

class Block

=begin
  attr_reader :index, :timestamp, :transactions, :previous_hash, :hash

  def initialize( index, transactions, previous_hash )
    @index         = index
    @timestamp     = Time.now.utc    ## note: use coordinated universal time (utc)
    @transactions  = transactions
    @previous_hash = previous_hash
    @hash          = calc_hash
  end

  def calc_hash
    sha = Digest::SHA256.new
    sha.update( @index.to_s + @time.to_s + @transactions.to_s + @previous_hash )
    sha.hexdigest
  end


  def self.first( transactions )    # create genesis (big bang! first) block
    ## uses index zero (0) and arbitrary previous_hash ('0')
    self.new( 0, transactions, '0' )
  end

  def self.next( previous, transactions )
    self.new( previous.index+1, transactions, previous.hash )
  end
=end



def to_h
  { index:         @index,
    timestamp:     @timestamp,
    nonce:         @nonce,
    transactions:  @transactions.map { |tx| tx.to_h },
    previous_hash: @previous_hash }
end

def self.from_h( h )
  transactions = h['transactions'].map { |h_tx| Tx.from_h( h_tx ) }

  ## parse iso8601 format e.g 2017-10-05T22:26:12-04:00
  timestamp    = Time.parse( h['timestamp'] )

  self.new( h['index'],
            transactions,
            h['previous_hash'],
            timestamp: timestamp,
            nonce: h['nonce'].to_i )
end


def valid?
  true   ## for now always valid
end


end # class Block
