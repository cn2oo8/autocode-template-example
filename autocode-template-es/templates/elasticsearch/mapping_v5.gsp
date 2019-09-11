<%
    def tableDefine = tableModel.tableDefine
    def columns = tableDefine.columns

    def esDataMapping = [:]
    esDataMapping['String'] = "keyword"
    esDataMapping['Float'] = "float"
    esDataMapping['Double'] = "double"
    esDataMapping['Integer'] = "integer"
    esDataMapping['Long'] = "long"
    esDataMapping['java.util.Date'] = "date"
    esDataMapping['java.sql.Timestamp'] = "date"

    //是否为模糊匹配查询
    def isText = { dataName ->
        if (dataName.contains("name")) {
            return true;
        }
        return false;
    }


    def getEsType = { it ->
        def columnType = it.columnType;
        def dataType = tableNameUtil.getDataType(it.columnType)
        def esType = esDataMapping.get(dataType)
        if (esType == null) {
            esType = "keyword"
        }
        if (esType == "keyword" && isText(it.columnName)) {
            esType = 'text'
        }
        return esType
    }


%>{
  "settings": {
    "index": {
      "number_of_shards": "4",
      "number_of_replicas": "1"
    }
  },
  "mappings": {
    "${tableDefine.dbTableName}": {
      "properties": {
<%
    columns.eachWithIndex { it, index ->
        String dataName = it.dataName
        String esType = getEsType(it)
        println """     "${dataName}": {"""
        print """       "type": "${esType}\""""

        if ('text' == esType) {
            println """,\n       "analyzer": "ik\""""
        } else if ('date' == esType) {
            println """,\n          "format": "yyyy-MM-dd HH:mm:ss||epoch_millis\""""
        } else {
            println ""
        }
        print """        }"""
        if (index < columns.size() - 1) {
            println ","
        }
    }
%>
}
}
}
}
