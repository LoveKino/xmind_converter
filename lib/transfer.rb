require 'writeexcel'

module XMindTransfer
    def convertTopic topicNode
        
        {
            'title' => topicNode.css('>title').text,
            'time' => topicNode.attr('timestamp'),
            'children' => topicNode.css('>children>topics>topic').map do |child|
                convertTopic child
            end,
            'makerRefs' => (topicNode.css('>marker-refs').css('>marker-ref').map {|item| item.attr('marker-id')})
        }
    end

    def convertContent contentDoc
        {
            'sheets' => contentDoc.css('>xmap-content>sheet').map do |sheet|
                sheet.css('>topic').map do |topic|
                     convertTopic(topic)
                end
            end
        }
    end

    def transferTopic topic, parentPath=[]
        path = parentPath
        path.push ({
            'title' => topic['title'], 
            'makerRefs' => topic['makerRefs'],
            'time' => topic['time']
        })
        topic['children'].length == 0 ? [path]: (topic['children'].map {|item| transferTopic item, path.clone}).inject([]) {|prev, item| prev.concat(item)}
    end
    
    def transfer xmindData
        contentDoc = xmindData['content']
        infoTree = convertContent(contentDoc)
        infoTree['sheets'].map do |sheet|
            (sheet.map {|item| transferTopic item}).inject([]) { |prev, item| prev.concat item }
        end
    end

    module_function :transfer
    module_function :convertTopic
    module_function :convertContent
    module_function :transferTopic
end
