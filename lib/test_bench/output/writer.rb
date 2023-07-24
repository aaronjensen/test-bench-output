module TestBench
  module Output
    class Writer
      def device
        @device ||= Device::Substitute.build
      end
      attr_writer :device

      def digest
        @digest ||= Digest.new
      end
      attr_writer :digest

      def sequence
        @sequence ||= 0
      end
      attr_writer :sequence

      def column_sequence
        @column_sequence ||= 0
      end
      attr_writer :column_sequence

      def buffer
        @buffer ||= Buffer.new
      end
      attr_writer :buffer

      def sync
        @sync.nil? ? @sync = true : @sync
      end

      def print(text)
        text = text.dump[1...-1]

        self.column_sequence += text.length

        write(text)

        self
      end

      def write(data)
        if sync
          bytes_written = write!(data)
        else
          bytes_written = buffer.receive(data)
        end

        self.sequence += bytes_written

        data = data[0...bytes_written]
        digest.update(data)

        bytes_written
      end

      def write!(data)
        device.write(data)

        data.bytesize
      end

      def tty?
        device.tty?
      end

      def flush
        buffer.flush(device)
      end

      def sync=(sync)
        @sync = sync

        if sync
          flush
        end
      end

      def written?(data=nil)
        if data.nil?
          sequence > 0
        else
          digest.digest?(data)
        end
      end

      def current?(sequence)
        sequence >= self.sequence
      end
    end
  end
end
