class Sudoku

    def initialize(filename)
        f = File.open(filename, mode = "rt")
        sudoku = []
        9.times do

            line = []

            3.times do

                vector = []

                3.times do
                    vector.push(f.getc.to_i)
                end

                line.push(vector)
            end

            sudoku.push(line)
            f.getc #改行送り
        end

        @sudoku = sudoku
        f.close
    end

    def show
        @sudoku.each do |line|
            line.each do |vector|
                vector.each do |num|
                    if num == 0
                        print " "
                    else
                        print num
                    end
                end
            end
            puts ""
        end
    end

    def translation #転置

    end

    def checkHolizontal
    end

    def check
    end
    
end

sudoku = Sudoku.new(ARGV[0])
sudoku.show
