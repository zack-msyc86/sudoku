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
        sudoku3 = []
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
                sudoku.push(line.each_slice(3).to_a)
            end
            sudoku3[i] =
        end
        @sudoku = sudoku
    end
=end

    def hSolve
        9.times do |num|
            sudoku = @sudoku[num+1]
            9.times do |i|
                #puts sudoku[i].flatten.count(0)
                if sudoku[i].flatten.count(0) == 1
                    3.times do |j|
                        3.times do |k|
                            if sudoku[i][j][k] == 0
                                @sudoku[0][i][j][k] = sudoku[i][j][k] = num+1
                                printf("Horisontaly solve!:(%d,%d)->%d\n",i+1,j*3+k+1,num+1)
                            end
                        end
                    end
                end
            end
            @sudoku[num+1] = sudoku
        end
    end

    def vSolve
        9.times do |num|
            sudoku = @sudoku[num+1]
            3.times do |i|
                3.times do |j|
                    marker = []
                    9.times do |k|
                        if sudoku[k][i][j] == 0
                            marker.push([k,i,j])
                        end
                    end
                    #p marker.count
                    if marker.count == 1
                        #p marker
                        @sudoku[0][marker[0][0]][marker[0][1]][marker[0][2]] = sudoku[marker[0][0]][marker[0][1]][marker[0][2]] = num+1
                        printf("Verticaly solve!:(%d,%d)->%d\n",marker[0][0]+1,marker[0][1]*3+marker[0][2]+1,num+1)
                    end
                end
            end
            @sudoku[num+1] = sudoku
        end
    end

    def bSolve
        9.times do |num|
            sudoku = @sudoku[num+1]
            3.times do |i|
                3.times do |j|
                    marker = []
                    3.times do |k|
                        3.times  do |l|
                            if sudoku[i*3+k][j][l] == 0
                                marker.push([i*3+k,j,l])
                            end
                        end
                    end
                    if marker.count == 1
                        @sudoku[0][marker[0][0]][marker[0][1]][marker[0][2]] = sudoku[marker[0][0]][marker[0][1]][marker[0][2]] = num+1
                        printf("Box solve!:(%d,%d)->%d\n",marker[0][0]+1,marker[0][1]*3+marker[0][2]+1,num+1)
                    end
                end
            end
            @sudoku[num+1] = sudoku
        end
    end

    def fill
        9.times do |num|
            #puts num+1
            hFlag = Array.new(9, false)
            vFlag = Array.new(9, false)
            bFlag = Array.new(9, false)

            sudoku = []
            9.times do |i|
                line = []
                3.times do |j|
                    line[j] = [0,0,0]
                end
                sudoku[i] = line
            end


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
                            bFlag[line/3*3 + vector] = true
                            sudoku[line][vector][value] = num+1
                        end

                        if @sudoku[0][line][vector][value] != 0 && @sudoku[0][line][vector][value] != num+1
                            sudoku[line][vector][value] = "+"
                        end
                    end
                end
            end


            9.times do |i|
                if hFlag[i]
                    3.times do |j|
                        3.times do |k|
                            if sudoku[i][j][k] == 0
                                sudoku[i][j][k] = "+"
                            end
                        end
                    end
                end
            end

            9.times do |i|
                if vFlag[i]
                    9.times do |j|
                        #printf("%d -> 1 (%d, %d)\n",sudoku[j][i/3][i%3],j,i/3+i%3)
                        #p sudoku[j]
                        if sudoku[j][i/3][i%3] == 0
                            sudoku[j][i/3][i%3] = "+"
                        end
                        #p sudoku[j]
                        #p "----------"
                    end
                end
            end

            #p bFlag

            9.times do |i|
                if bFlag[i]
                    3.times do |j|
                        #p sudoku[i/3+j][i%3]
                        3.times do |k|
                            if sudoku[i/3*3+j][i%3][k] == 0
                                sudoku[i/3*3+j][i%3][k] = "+"
                            end
                        end
                        #printf("%d,%d\n",i/3+j,i%
                    end
                        #p sudoku[i/3+j][i%3].object_id
                end
            end
            @sudoku[num+1] = sudoku
        end
    end


end

def showall(sudoku)
    10.times do |i|
        sudoku.show(i)
    end
end

sudoku = Sudoku.new(ARGV[0])
showall(sudoku)
sudoku.fill
showall(sudoku)
puts "////////////////////"
ARGV[1].to_i.times do
    sudoku.hSolve
    sudoku.fill
    sudoku.vSolve
    sudoku.fill
    sudoku.bSolve
    sudoku.fill

    puts ""
    showall(sudoku)
    #sudoku.show(3)

    puts "============================"
end
