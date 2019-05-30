<%
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

    customTool['tableModelDictDefineJson'] = tableModelDictDefineJson;

%>