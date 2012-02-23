require "turn/autorun"

FileList["lib/*"].each { |f| load f }
FileList["test/fixtures/*"].each { |f| load f }
