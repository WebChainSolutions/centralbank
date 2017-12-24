# encoding: utf-8

# stdlibs
require 'json'
require 'digest'
require 'net/http'
require 'set'
require 'pp'
require 'optparse'    ## note: used for command line tool (see Tool in tool.rb)


### 3rd party gems
require 'sinatra/base'                         # note: use "modular" sinatra app / service

require 'merkletree'
require 'blockchain-lite/proof_of_work/block'  # note: use proof-of-work block only (for now)


### our own code
require 'centralbank/version'    ## let version always go first
require 'centralbank/block'
require 'centralbank/cache'
require 'centralbank/transaction'
require 'centralbank/blockchain'
require 'centralbank/pool'
require 'centralbank/bank'
require 'centralbank/ledger'
require 'centralbank/wallet'

require 'centralbank/node'
require 'centralbank/service'

require 'centralbank/tool'    ## add (optional) command line tool





module Centralbank


  class Configuration
     ## user/node settings
     attr_accessor :address   ## single wallet address (for now "clear" name e.g.Sepp, Franz, etc.)

     WALLET_ADDRESSES = %w[Alice Bob Max Franz Maria Ferdl Lisi Adam Eva]

     ## system/blockchain settings
     attr_accessor :coinbase
     attr_accessor :mining_reward


     def initialize
       ## try default setup via ENV variables
       ## pick "random" address if nil (none passed in)
       @address = ENV[ 'CENTRALBANK_NAME'] || WALLET_ADDRESSES[rand( WALLET_ADDRESSES.size )]

       @coinbase      = 'COINBASE'   ## use a different name - why? why not?
       @mining_reward = 5
     end
  end # class Configuration


  ## lets you use
  ##   Centralbank.configure do |config|
  ##      config.address = 'Sepp'
  ##   end

  def self.configure
    yield( config )
  end

  def self.config
    @config ||= Configuration.new
  end


  ## add command line binary (tool) e.g. $ try centralbank -h
  def self.main
   Tool.new.run(ARGV)
  end

end # module Centralbank


# say hello
puts Centralbank::Service.banner
