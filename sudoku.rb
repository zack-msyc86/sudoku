class Sudoku < Array

    def initialize(filename)
        f = File.open(filename, mode = "rt")
        sudoku = []
        10.times do |i|
            sudokuEach = []
            9.times do
                line = []
                3.times do
                    vector = []
                    3.times do
                        if i == 0
                            vector.push(f.getc.to_i)
                        else
                            if f.getc.to_i == i
                                vector.push(i)
                            else
                                vector.push(0)
                            end
                        end
                    end
                    line.push(vector)
                end
                sudokuEach.push(line)
                f.getc #改行送り
            end
            sudoku.push(sudokuEach)
            f.rewind
        end
        @sudoku = sudoku
        f.close
    end

    def show(i)
        @sudoku[i].each do |line|
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
    end
=begin
    def transpose #転置
        10.times do |i|
            sudoku = []
            sudoku2 = []
            @sudoku[i].each do |line|
                line2 = []
                line.each do |vector|
                    vector.each do |num|
                        line2.push(num)
                    end
                end
                sudoku2.push(line2)
            end
            sudoku2.transpose.each do |line|
                sudoku[i].push(line.each_slice(3).to_a)
            end
        end
        @sudoku = sudoku
    end
=end
    def check

    end

    def fill
        1.times do |num|
            puts num+1
            hFlag = Array.new(9, false)
            vFlag = Array.new(9, false)
            bFlag = Array.new(9, false)
            sudoku = []

=begin            @sudoku[num+1].each do |line|
                line.each do |vector|
                    if vector.include?(num+1)
                        hFlag[num] = true
                    end
                end
            end
=end
            9.times do |line|
                3.times do |vector|
                    3.times do |value|
                        if @sudoku[num+1][line][vector][value] == num+1
                            hFlag[line] = true
                            vFlag[vector*3 + value] = true
                            bFlag[line*3 + vector] = true
                        end
                    end
                end
            end

            9.times do |i|
                if hFlag[i]
                    line = Array.new(3, [num+1,num+1,num+1])
                else
                    line = Array.new(3, [0,0,0])
                end
                sudoku.push(line)
            end

            9.times do |i|
                if vFlag[i]
                    1.times do |j|
                        printf("%d : %d,%d \n",i,i/3,i%3)
                        sudoku[j][i/3][i%3] = num+1
                    end
                end
            end

            @sudoku[num+1] = sudoku
        end
    end

end

def showall(sudoku)
    1.times do |i|
        sudoku.show(i+1)
    end
end

sudoku = Sudoku.new(ARGV[0])
showall(sudoku)
sudoku.fill
showall(sudoku)
#sudoku[0].show
