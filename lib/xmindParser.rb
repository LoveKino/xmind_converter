# parse xmind file
# - unzip to target directory
require 'fileutils'
require 'zip'
require 'nokogiri'

module XMindParser
    def XMindParser.load(filePath, targetDir)
        result = {'attachments' => {}}

        Zip::File.open(filePath) do |zipfile|
            zipfile.each do |file|
                # extract files
                print "Extracting #{file.name}\n"
                destFile = File.join(targetDir, file.name)
                FileUtils.mkdir_p File.dirname(destFile)
                file.extract(destFile)

                # analysis extracted files
                if(file.name == 'content.xml')
                    result['content'] = Nokogiri::XML(file.get_input_stream.read)
                end

                if(file.name == 'meta.xml')
                    result['meta'] = Nokogiri::XML(file.get_input_stream.read)
                end

                if(file.name == 'styles.xml')
                    result['styles'] = Nokogiri::XML(file.get_input_stream.read)
                end

                if(file.name == 'META-INF/manifest.xml')
                    result['manifest'] = Nokogiri::XML(file.get_input_stream.read)
                end

                if !(file.name =~ /^attachments\//).nil?
                    result['attachments'][file.name] = destFile;
                end
            end

            FileUtils.rm_r targetDir
        end

        result
    end
end
