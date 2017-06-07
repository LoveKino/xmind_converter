#!/usr/bin/env ruby

# a small programmer to convert xmind type file to excel file
#
# - unzip xmind file
# - read and parse xmind xmls
# - generate excel file

require_relative 'xmindParser'
require 'transfer'
require 'securerandom'
require 'tapdExcel'

module TIM
    def formatFilePath(path, refer)
        if path[0] != '/'
            path = File.expand_path(File.join(refer, path))
        end
        path
    end

    def import(xmindFilePath, targetExcelPath)
        TapdExcel.toExcel(
            XMindTransfer.transfer(
                XMindParser.load formatFilePath(xmindFilePath, Dir.pwd), formatFilePath("tmp/#{SecureRandom.uuid}", File.dirname(__FILE__))
            ),

            targetExcelPath
        )
    end

    def count(xmindDirPath)
        Dir[formatFilePath(xmindDirPath, Dir.pwd) + '/*'].inject({}) do |prev, file| 
            if File.extname(file) == '.xmind'
                ret = XMindTransfer.transfer(XMindParser.load file, formatFilePath("tmp/#{SecureRandom.uuid}", File.dirname(__FILE__)))
                prev[File.basename(file)] = ret.inject(0) do |sum, group|
                    sum + group.length
                end
            end
            prev
        end
    end
end
