<%
  def columns=tableDefine.columns
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)
  def urlPrefix=PubUtils.addStrBeforeSeparator(PubUtils.packageToPath(config.category),".")+varDomainName
%>
/**
 * 抽取出来方便
 */
import * as renderUtil from '@/libs/renderUtil.js'
import constants from '@/constants/constants'
import dictLabel from '@/view/components/dict/DictLabel'
import dictSelect from '@/view/components/dict/DictSelect'
import dictCheckbox from '@/view/components/dict/DictCheckBox'

const searchFormRules = {
<%
  List<String> list=tableModel.getSearchKeyList();
  def listSize=list.size()
  int i=0;
  list.each{
    def column=tableDefine.getColumnByColumnName(it);
    print snippetTemplateUtil.getTemplate(column,'form_rule_item_vue');
    i++;
    if(i<listSize) println ',';

  }
%>
};

let tableDefine = {
data() {
    return {
        loading: false,
        columns: [
          <%
            columns.each{
              def column=it
              if(tableModel.isNotInList('queryList',column.columnName)){
                return
              }

              if("Select".equalsIgnoreCase(column.jspTag)) {%>
                {
                  title: '${column.cnname}',
                  width: 100,
                  render: (h, params) => {
                     return h(dictLabel, {
                         props: {
                             value: params.row['${column.dataName}'],
                             kind: constants.dicts.dictKinds.${column.dictName},
                             showStyle: true
                         }
                     })
                  }
                },
             <%}else  if("datetime".equalsIgnoreCase(column.jspTag)) {%>
                {
                 title: '${column.cnname}',
                  key: '${column.dataName}',
                  width: 100,
                  render: (h, params) => {
                      return h('div', renderUtil.formatDateTime(params.row.${column.dataName}))
                  }
                },
            <%}else {%>
              {
                  title: '${column.cnname}',
                  key: '${column.dataName}',
                  width: 100
                },
              <%}

            }
          %>
            {
                title: '操作',
                key: 'action',
                width: 150,
                fixed: 'right',
                align: 'center',
                slot: 'operateSlot'
            }
        ],
        queryResult: {
            dataList: [],
            pageQuery: {
                totalCount: 0,
                pageCount: 0,
                pageNo: 1,
                pageSize: 10
            }
        },
        formSearch: {
<%
  list.eachWithIndex{ it,index ->
      def column=tableDefine.getColumnByColumnName(it);
      String dataName = column.dataName
      String value = tableNameUtil.genTestDataQuote(column,dictMap)
      print """       "${dataName}": ${value}"""
      if(index < list.size()-1){
        println ","
      }else{
        println ""
      }
  }
%>
        },
        searchFormRules: searchFormRules,
        constants
    }
},
mounted() {
    this.loadData()
},
components: {
    dictLabel,
    dictSelect,
    dictCheckbox
}
}
export default tableDefine;