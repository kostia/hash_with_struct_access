require "test/unit"


FileList["lib/*"].each { |f| load f }
FileList["test/fixtures/*"].each { |f| load f }
