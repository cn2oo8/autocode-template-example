<%

    /**
     * 单条字典项json定义
     */
    def dictDefine = {dict, formatPrepend ->
        if(formatPrepend == null){
            formatPrepend = '';
        }

        def dictRuleLineList =[];
        def optionList = dict.optionList;
        optionList.eachWithIndex { option, index ->
            def cssType = option['cssClass'];
            if(cssType == null || cssType == ''){
                cssType = 'default';
            }
            def itemJson =  """{kind: '${dict.id}', itemKey: '${option.value}', 'itemName': '${option.name}', 'sortNum': ${index+1}, 'cssType': '${cssType}'}"""
            if (index < optionList.size() - 1) {
                itemJson = itemJson + ',';
            }
            dictRuleLineList.add(itemJson)
        }


        StringBuilder sb = new StringBuilder(formatPrepend);
        sb.append("""'${dict.id}': """).append("[").append("\n");
        dictRuleLineList.each { line ->
            sb.append(formatPrepend).append('\t').append(line).append("\n")
        }
        sb.append(formatPrepend).append("]")
        return sb.toString();
    }

    /**
     * 整个表模型的字典项定义
     */
    def tableModelDictDefine = { tableModel,formatPrepend ->
        if(formatPrepend == null){
            formatPrepend = '';
        }
        def dictMap = tableModel['dictMap']
        if (dictMap == null || dictMap.isEmpty()) {
            return formatPrepend + "{}"
        }

        StringBuilder sb = new StringBuilder();
        sb.append("{").append('\n')
        def index = 0;
        dictMap.each { key, dict ->
            def oneDictDefine = dictDefine(dict, formatPrepend + '\t');
            sb.append(oneDictDefine);
            if(index < dictMap.size()-1){
                sb.append(",")
            }
            sb.append("\n")
            index++;
        }
        sb.append(formatPrepend).append("}")
        return sb.toString();
    }



    /**
     * 单条字典项json定义
     */
    def dictDefineJson = {dict, formatPrepend ->
        def dictRuleList =new ArrayList();
        def optionList = dict.optionList;
        optionList.eachWithIndex { option, index ->
            def cssType = option['cssClass'];
            if(cssType == null || cssType == ''){
                cssType = 'default';
            }
            def dictItem = new HashMap();
            dictItem["kind"] = dict.id;
            dictItem["itemKey"] = option.value;
            dictItem["itemName"] = option.name;
            dictItem["sortNum"] = index+1;
            dictItem["cssType"] = cssType;
            dictRuleList.add(dictItem)
        }
        return dictRuleList;
    }

    /**
     * 整个表模型的字典项定义
     */
    def tableModelDictDefineJson = { tableModel, formatPrepend ->
        if (formatPrepend == null) {
            formatPrepend = '';
        }
        def dictMap = tableModel['dictMap']
        if (dictMap == null || dictMap.isEmpty()) {
            return "{}"
        }

        def dictRuleMap = [:]
        dictMap.each { key, dict ->
            def oneDictDefine = dictDefineJson(dict, formatPrepend);
            dictRuleMap.put(key, oneDictDefine);
        }
        return JSON.toJSONString(dictRuleMap,com.alibaba.fastjson.serializer.SerializerFeature.PrettyFormat);
    }


    customTool['dictDefine'] = dictDefine;
    customTool['tableModelDictDefine'] = tableModelDictDefine;
    customTool['tableModelDictDefineJson'] = tableModelDictDefineJson;

%>