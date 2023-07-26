require_relative '../../automated_init'

context "Buffer" do
  context "Configure Receiever" do
    context "Optional Attribute Name Given" do
      attr_name = :some_other_attr
      comment "Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      Output::Writer::Buffer.configure(receiver, attr_name:)

      buffer = receiver.public_send(attr_name)

      context "Configured" do
        comment buffer.class.name

        configured = !buffer.nil?

        test do
          assert(configured)
        end
      end
    end
  end
end
