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
import operate from './operate.vue';
import dictLabel from '@/views/common/dict/DictLabel'
import dictSelect from '@/views/common/dict/DictSelect'
import dictCheckbox from '@/views/common/dict/DictCheckBox'

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

const dictKinds = {
LOCAL_LABEL_DICT: 'local_label_dict'
}
const localDicts = {
dictKinds,
dictData: {
    [dictKinds.LOCAL_LABEL_DICT]: [{
        kind: dictKinds.LOCAL_LABEL_DICT,
        itemKey: '1',
        'itemName': '标签1',
        'parentKind': '',
        'parentKey': '',
        'sortNum': 1,
        'cssType': 'blue'
    }, {
        kind: dictKinds.LOCAL_LABEL_DICT,
        itemKey: '2',
        'itemName': '标签2',
        'parentKind': '',
        'parentKey': '',
        'sortNum': 1,
        'cssType': 'red'
    }
    ]
}
}

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
                align: 'center',
                render: (h, params) => {
                    return h(operate, {
                        props: {
                            item: params.row
                        },
                        on: {
                            'refreshList': () => {
                                this.loadData()
                            },
                            'updateItem': (item) => {
                                this.editItem(item)
                            }
                        }
                    });
                }
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
        constants,
        localDicts
    }
},
mounted() {
    this.loadData()
},
components: {
    operate,
    dictLabel,
    dictSelect,
    dictCheckbox
}
}
export default tableDefine;