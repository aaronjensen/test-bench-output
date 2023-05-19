module TestBench
  module Output
    class Writer
      class Buffer
        attr_accessor :limit

        def contents
          @contents ||= String.new
        end
        attr_writer :contents

        def self.build
          instance = new
          instance.limit = 0
          instance
        end

        def self.configure(receiver, attr_name: nil)
          attr_name ||= :buffer

          instance = build
          receiver.public_send(:"#{attr_name}=", instance)
        end

        def receive(data)
          bytes = data.bytesize

          if not limit.nil?
            final_size = contents.bytesize + data.bytesize

            if final_size > limit
              bytes = limit - contents.bytesize
            end
          end

          data = data[0...bytes]

          contents << data

          bytes
        end

        def limit?
          !limit.nil?
        end

        def flush(*devices)
          devices.each do |device|
            device.write(contents)
          end

          contents.clear
        end
      end
    end
  end
end