<%
    def tableDefine=tableModel.tableDefine;
    def columns=tableDefine.columns;
    Set excludes = ["id","status","operator","created","modified"]
%>{
  "addInfo":{
<%
      columns.eachWithIndex{ it,index ->
          if(!it.canBeNull && !it.isPK) {
              String dataName = it.dataName
              String value = tableNameUtil.genTestDataQuote(it,dictMap)
              print """       "${dataName}": ${value}"""
              if(index < columns.size()-1){
                  println ","
              }else{
                  println ""
              }
          }
      }
 %>
  },
  "updateInfo":{
<%
    columns.eachWithIndex{it,index ->
        if(!it.canBeNull  && !it.isPK) {
            String dataName = it.dataName
            String value = tableNameUtil.genTestDataQuote(it,dictMap)
            print """       "${dataName}": ${value}"""
            if(index < columns.size()-1){
                println ","
            }else{
                println ""
            }
        }
    }
%>
  }
}