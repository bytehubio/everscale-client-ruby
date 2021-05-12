module TonClient

  class Processing
    include CommonInstanceHelpers

    attr_reader :core, :context
    MODULE = self.to_s.downcase.gsub(/^(.+::|)(\w+)$/, '\2').freeze

    def initialize(context: Context.new, core: TonClient::TonBinding)
      @context = context
      @core = core
    end

    # INPUT: TSDKParamsOfSendMessage
    # message: String -     # Message BOC.
    # abi: TSDKAbi -     # Optional message ABI.    # If this parameter is specified and the message has the`expire` header then expiration time will be checked againstthe current time to prevent unnecessary sending of already expired message.The `message already expired` error will be returned in thiscase.Note, that specifying `abi` for ABI compliant contracts isstrongly recommended, so that proper processing strategy can bechosen.
    # send_events: Boolean -     # Flag for requesting events sending
    # RESPONSE: TSDKResultOfSendMessage
    # shard_block_id: String -     # The last generated shard block of the message destination account before the message was sent.    # This block id must be used as a parameter of the`wait_for_transaction`.
    # sending_endpoints: Array -     # The list of endpoints to which the message was sent.    # This list id must be used as a parameter of the`wait_for_transaction`.
    def send_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfWaitForTransaction
    # abi: TSDKAbi -     # Optional ABI for decoding the transaction result.    # If it is specified, then the output messages' bodies will bedecoded according to this ABI.The `abi_decoded` result field will be filled out.
    # message: String -     # Message BOC.    # Encoded with `base64`.
    # shard_block_id: String -     # The last generated block id of the destination account shard before the message was sent.    # You must provide the same value as the `send_message` has returned.
    # send_events: Boolean -     # Flag that enables/disables intermediate events
    # sending_endpoints: Array -     # The list of endpoints to which the message was sent.    # You must provide the same value as the `send_message` has returned.
    # RESPONSE: TSDKResultOfProcessMessage
    # transaction: Value -     # Parsed transaction.    # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     # List of output messages' BOCs.    # Encoded as `base64`
    # decoded: TSDKDecodedOutput -     # Optional decoded message bodies according to the optional `abi` parameter.
    # fees: TSDKTransactionFees -     # Transaction fees
    def wait_for_transaction(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

    # INPUT: TSDKParamsOfProcessMessage
    # message_encode_params: TSDKParamsOfEncodeMessage -     # Message encode parameters.
    # send_events: Boolean -     # Flag for requesting events sending
    # RESPONSE: TSDKResultOfProcessMessage
    # transaction: Value -     # Parsed transaction.    # In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    # out_messages: Array -     # List of output messages' BOCs.    # Encoded as `base64`
    # decoded: TSDKDecodedOutput -     # Optional decoded message bodies according to the optional `abi` parameter.
    # fees: TSDKTransactionFees -     # Transaction fees
    def process_message(payload, &block)
      core.requestLibrary(context: context.id, method_name: full_method_name(MODULE, __method__.to_s), payload: payload, &block)
    end

  end
end

