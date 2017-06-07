require 'writeexcel'

module TapdExcel
    def toExcel groups, targetExcelPath
        # print data
        workbook = WriteExcel.new(targetExcelPath)

        worksheet = workbook.add_worksheet

        # write titles
        worksheet.write(0, 0, '用例目录')
        worksheet.write(0, 1, '用例名称')

        sheetOne = groups[0]
        line = 1
        sheetOne.each_with_index do |item|
            path = item.slice(0, 2).inject('') {|prev, cur| prev == ''? cur['title']: prev + ' -> ' + cur['title']}
            title = item.slice(2, item.length).inject('') {|prev, cur| prev == ''? cur['title']: prev + ' -> ' + cur['title']}

            if path != '' && title != ''
                line = line + 1
                worksheet.write(line, 0, path)
                worksheet.write(line, 1, title)
            end 
        end

        workbook.close
    end

    module_function :toExcel
end
