require_relative '../../automated_init'

context "Writer" do
  context "Configure Receiver" do
    context "Optional Styling Omitted" do
      receiver = Struct.new(:writer).new

      default_styling_policy = Output::Writer::Styling.default
      detail "Default: #{default_styling_policy.inspect}"

      Output::Writer.configure(receiver)

      writer = receiver.writer

      context "Styling Policy" do
        styling_policy = writer.styling_policy

        comment styling_policy.inspect

        test do
          assert(styling_policy == default_styling_policy)
        end
      end
    end
  end
end
