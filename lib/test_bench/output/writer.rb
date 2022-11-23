module TestBench
  module Output
    class Writer
      def device
        @device ||= Device::Substitute.build
      end
      attr_writer :device

      def buffer
        @buffer ||= Buffer.new
      end
      attr_writer :buffer

      def tty?
        device.tty?
      end

      def flush
        buffer.flush(device)
      end
    end
  end
end
