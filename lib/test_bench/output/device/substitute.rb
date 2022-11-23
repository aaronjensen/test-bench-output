module TestBench
  module Output
    module Device
      module Substitute
        def self.build
          Device.new
        end

        class Device
          def written_data
            @written_data ||= String.new
          end
          attr_writer :written_data

          def write(data)
            bytes_written = data.bytesize

            written_data << data

            bytes_written
          end
        end
      end
    end
  end
end
