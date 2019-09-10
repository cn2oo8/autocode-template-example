<%
    def tableDefine=tableModel.tableDefine
    def columns=tableDefine.columns

    def esDataMapping=[:]
    esDataMapping['String'] = "string"
    esDataMapping['Float'] = "float"
    esDataMapping['Double'] = "double"
    esDataMapping['Integer'] = "integer"
    esDataMapping['Long'] = "long"
    esDataMapping['java.util.Date'] = "date"
    esDataMapping['java.sql.Timestamp'] = "date"

    def getEsType={ it->
        def esType = esDataMapping.get(it)
        if(esType==null){
            esType="string"
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
    columns.eachWithIndex{ it,index->
        String dataName = it.dataName
        def dataType =tableNameUtil.getDataType(it.columnType)
        String esType = getEsType(dataType)
        println """     "${dataName}": {"""
        println """        "type": "${esType}","""
        println """          "index": "not_analyzed" """
        if ('date' == esType) {
            println """,\n          "format": "yyyy-MM-dd HH:mm:ss||epoch_millis" """
        }
        print """\n        }"""
        if (index < columns.size() - 1) {
            print ","
        }
    }
%>
      }
    }
  }
}
