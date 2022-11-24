module TestBench
  module Output
    module Controls
      module Text
        def self.example
          "Some text"
        end

        def self.random
          suffix = Random.string

          "#{example} #{suffix}"
        end

        module NonPrintableCharacters
          def self.example
            characters.map(&:chr).join
          end

          def self.characters
            (0..0x20).to_a + (0x7F..0xFF).to_a
          end

          module Escaped
            def self.example
              unescaped = NonPrintableCharacters.example
              unescaped.dump[1...-1]
            end
          end
        end
      end
    end
  end
end
