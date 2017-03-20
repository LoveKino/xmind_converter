require 'writeexcel'

module TapdExcel
    def toExcel groups, prefixDir
        # print data
        workbook = WriteExcel.new('text.xls')

        print groups[0].length

        worksheet = workbook.add_worksheet

        worksheet.write(0, 0, '用例目录')
        worksheet.write(0, 1, '用例名称')
        worksheet.write(0, 2, '需求ID')
        worksheet.write(0, 3, '前置条件')
        worksheet.write(0, 4, '用例步骤')
        worksheet.write(0, 5, '预期结果')
        worksheet.write(0, 6, '用例类型')
        worksheet.write(0, 7, '用例状态')
        worksheet.write(0, 8, '用例等级')
        worksheet.write(0, 9, '创建人')

        item = groups[0][0]

        worksheet.write(1, 0, "#{prefixDir}-testdir")
        worksheet.write(1, 1, item[1]['title'])
        worksheet.write(1, 7, '正常')

        workbook.close
    end

    module_function :toExcel
end
