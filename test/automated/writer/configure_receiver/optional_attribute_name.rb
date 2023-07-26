require_relative '../../automated_init'

context "Writer" do
  context "Configure Receiver" do
    context "Optional Attribute Name Given" do
      attr_name = :some_other_attr
      comment "Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      Output::Writer.configure(receiver, attr_name:)

      writer = receiver.public_send(attr_name)

      context "Configured" do
        comment writer.class.name

        configured = writer.instance_of?(Output::Writer)

        test do
          assert(configured)
        end
      end
    end
  end
end
