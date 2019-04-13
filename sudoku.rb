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
        puts "------------------------------"
        p @sudoku
    end

    def transpose #転置
        sudoku = []
        sudoku2 = []
        @sudoku.each do |line|
            line2 = []
            line.each do |vector|
                vector.each do |num|
                    line2.push(num)
                end
            end
            sudoku2.push(line2)
        end
        sudoku2.transpose.each do |line|
            sudoku.push(line.each_slice(3).to_a)
        end
        @sudoku = sudoku
    end

    def checkHolizontal
    end

    def check
    end

end

sudoku = Sudoku.new(ARGV[0])
sudoku.show
sudoku.transpose
sudoku.show
