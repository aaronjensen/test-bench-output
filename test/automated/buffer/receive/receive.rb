require_relative '../../automated_init'

context "Buffer" do
  context "Receive Data" do
    buffer = Output::Writer::Buffer.new

    data = Controls::Data.example

    bytes_received = 0

    received_data = buffer.receive(data[0...1])
    bytes_received += received_data.bytesize

    received_data = buffer.receive(data[1..-1])
    bytes_received += received_data.bytesize

    test! do
      assert(bytes_received == data.bytesize)
    end

    context "Buffer's Contents" do
      contents = buffer.contents

      comment contents.inspect
      detail "Data: #{data.inspect}"

      received = contents == data

      test "Received the data" do
        assert(received)
      end
    end
  end
end
