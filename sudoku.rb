$maxLoop = ARGV[1].to_i
$analogy = 0

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
    end

    def result
        @sudoku[0].flatten.join
    end

    def hSolve
        flag = false
        9.times do |num|
            sudoku = @sudoku[num+1]
            9.times do |i|
                #puts sudoku[i].flatten.count(0)
                if sudoku[i].flatten.count(0) == 1
                    3.times do |j|
                        3.times do |k|
                            if sudoku[i][j][k] == 0
                                @sudoku[0][i][j][k] = sudoku[i][j][k] = num+1
                                flag = true
                                printf("Horisontaly solve!:(%d,%d)->%d\n",i+1,j*3+k+1,num+1)
                            end
                        end
                    end
                end
            end
            self[num+1] = sudoku
            self.fill
        end
        return flag
    end

    def vSolve
        flag = false
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
                        flag = true
                        printf("Verticaly solve!:(%d,%d)->%d\n",marker[0][0]+1,marker[0][1]*3+marker[0][2]+1,num+1)
                    end
                end
            end
            self[num+1] = sudoku
            self.fill
        end
        return flag
    end

    def bSolve
        flag = false
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
                        flag = true
                        printf("Box solve!:(%d,%d)->%d\n",marker[0][0]+1,marker[0][1]*3+marker[0][2]+1,num+1)
                    end
                end
            end
            self[num+1] = sudoku
            self.fill
        end
        return flag
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

=begin
    def sum
        sFlag = false
        all = (1..9).to_a
        9.times do |line|
            3.times do |vector|
                3.times do |value|
                    9.times do |num|
                        flag = true
                        num+1
                        removedNum = all - [num+1]
                        8.times do |i|
                            if @sudoku[removedNum[i]][line][vector][value] != "+" || @sudoku[removedNum[i]][line][vector][value] != removedNum[i]
                                flag = false
                            end
                        end
                        if flag
                            @sudoku[num+1][line][vector][value] = num+1
                            @sudoku[0][line][vector][value] = num+1
                            sFlag = true
                            printf("Sum solve!:(%d,%d)->%d\n",line+1,vector*3+value+1,num+1)
                            self.fill
                            self.show(num+1)
                        end
                    end
                end
            end
        end
        return sFlag
    end

=begin
    def analogy(analogyCount)
        81.times do
            num = $analogy/9
            line = $analogy - $analogy/9*9
            sudoku = @sudoku[num+1]
            printf("$analogy=%d,num=%d,line=%d,count=%d\n",$analogy,num+1,line+1,analogyCount)
            if sudoku[line].flatten.count(0) == 2
                puts "count=2"
                index = sudoku[line].flatten.each_index.select{|i| sudoku[line].flatten[i] == 0}
                @sudoku[0][line][index[analogyCount]/3][index[analogyCount]-index[analogyCount]/3] = num+1
                @sudoku[num+1][line][index[analogyCount]/3][index[analogyCount]-index[analogyCount]/3] = num+1
                self.fill
                printf("\nanalogy:(%d,%d)->%d\n\n",line+1,index[analogyCount]+1,num+1)
                if analogyCount == 1
                    $analogy += 1
                end
                return
            elsif $analogy == 80
                puts "analogy over"
                exit
            else
                $analogy += 1
            end
        end
    end
=end

    def fin?
        return !@sudoku[0].flatten.include?(0)
    end

    def copy
        Marshal.load(Marshal.dump(self))
    end
end

def showall(sudoku)
    puts "---------"
    10.times do |i|
        sudoku.show(i)
        puts "---------"
    end
end

def solve(sudoku)
    ARGV[1].to_i.times do |loop|

        flag = false

        hFlag = sudoku.hSolve
        vFlag = sudoku.vSolve
        bFlag = sudoku.bSolve
        #sFlag = sudoku.sum
        flag = hFlag || vFlag || bFlag
        puts "\n"
        if !flag
            return
        end

        sudoku.show(0)
        if ARGV[2].to_i != 0
            puts "---------"
            sudoku.show(ARGV[2].to_i)
        end
        printf("\nLOOP%d=============================\n\n",loop+1)
    end
end

def main

    if ARGV[1].to_i == 0
        ARGV[1] = "100"
    end

    sudoku = Sudoku.new(ARGV[0])
    sudoku.fill
    showall(sudoku)
    printf("\nDisplay Type:%d\nMax Loop:%d\n\nFin init======================\n\n",ARGV[2].to_i,ARGV[1].to_i)

    ARGV[1].to_i.times do

        solve(sudoku)

        if sudoku.fin?
            printf("\nfin!\n%s\n\n",sudoku.result)
            sudoku.show(0)
            return
        end
    end

end

main
