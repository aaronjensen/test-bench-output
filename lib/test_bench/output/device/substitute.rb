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

          def flushed_data
            @flushed_data ||= String.new
          end
          attr_writer :flushed_data

          def write(data)
            bytes_written = data.bytesize

            written_data << data

            bytes_written
          end

          def flush
            flushed_data << written_data
          end

          def written?(data=nil)
            if data.nil?
              !written_data.empty?
            else
              written_data == data
            end
          end
        end
      end
    end
  end
end
